# ============================================================
# Cross-platform OS detection
#   Windows : requires Git Bash (git-scm.com) + GNU Make
#   macOS   : Homebrew-based tooling
#   Linux   : systemd / apt assumed
# ============================================================
ifeq ($(OS),Windows_NT)
    DETECTED_OS  := Windows
    # Point CATALINA_HOME at your Tomcat 9 install dir, or override TOMCAT_HOME
    TOMCAT_HOME  ?= $(CATALINA_HOME)
    # JAVA_HOME must already be set in your Windows environment
    JAVA_HOME    ?= $(JAVA_HOME)
    TOMCAT_START := cmd /C "$(TOMCAT_HOME)/bin/startup.bat"
    TOMCAT_STOP  := cmd /C "$(TOMCAT_HOME)/bin/shutdown.bat"
    PG_SVC_START := net start postgresql-x64-15
    PG_SVC_STOP  := net stop postgresql-x64-15
    PKG_INSTALL  := choco install -y
    PG_PKGS      := postgresql15
    TOMCAT_PKG   := tomcat
    PYTHON       := python
    RM_F         := rm -f
else
    UNAME_S      := $(shell uname -s)
    PYTHON       := python3
    RM_F         := rm -f
    ifeq ($(UNAME_S),Darwin)
        DETECTED_OS  := macOS
        TOMCAT_HOME  := $(shell brew --prefix tomcat@9 2>/dev/null)/libexec
        JAVA_HOME    := $(shell asdf where java 2>/dev/null || /usr/libexec/java_home 2>/dev/null)
        PG_SVC_START := brew services start postgresql@15
        PG_SVC_STOP  := brew services stop postgresql@15
        PKG_INSTALL  := brew install
        PG_PKGS      := postgresql@15
        TOMCAT_PKG   := tomcat@9
    else
        DETECTED_OS  := Linux
        TOMCAT_HOME  ?= /opt/tomcat
        JAVA_HOME    ?= $(shell dirname $$(dirname $$(readlink -f $$(which java))))
        PG_SVC_START := sudo systemctl start postgresql
        PG_SVC_STOP  := sudo systemctl stop postgresql
        PKG_INSTALL  := sudo apt-get install -y
        PG_PKGS      := postgresql-15
        TOMCAT_PKG   := tomcat9
    endif
    TOMCAT_START := $(TOMCAT_HOME)/bin/startup.sh
    TOMCAT_STOP  := $(TOMCAT_HOME)/bin/shutdown.sh
endif
export JAVA_HOME

DB_NAME   := heart_disease_project
DB_USER   := postgres
DB_PASS   := Ankit@4837
DB_PORT   := 5432
FLASK_DIR := DataModel
WAR_NAME  := Heart_Disease

.PHONY: all setup start stop db-start db-stop db-init scaler flask-start flask-stop app-build app-start app-stop clean

all: start

## Install Tomcat 9 and PostgreSQL (one-time setup)
setup:
ifeq ($(DETECTED_OS),Windows)
	@echo "==> Installing Tomcat 9 and PostgreSQL 15 via Chocolatey..."
	choco install -y $(TOMCAT_PKG) $(PG_PKGS)
	@echo "==> Set CATALINA_HOME and ensure the PostgreSQL bin dir is in PATH."
else ifeq ($(DETECTED_OS),macOS)
	@echo "==> Installing Tomcat 9 and PostgreSQL 15 via Homebrew..."
	brew install $(TOMCAT_PKG) $(PG_PKGS)
else
	@echo "==> Installing Tomcat 9 and PostgreSQL 15..."
	$(PKG_INSTALL) $(TOMCAT_PKG) $(PG_PKGS)
endif
	@echo "==> Setup complete. Run 'make start' to launch the app."

## Start everything: database, ML server, web app
start: db-start flask-start app-start
	@echo ""
	@echo "==> All services started."
	@echo "    Web app : http://localhost:8080/$(WAR_NAME)/"
	@echo "    Flask   : http://127.0.0.1:5000"
	@echo "    DB      : localhost:$(DB_PORT)/$(DB_NAME)"

## Stop everything
stop: app-stop flask-stop db-stop
	@echo "==> All services stopped."

# --- Database ---

db-start:
	@echo "==> Starting PostgreSQL..."
	@$(PG_SVC_START) || echo "PostgreSQL may already be running."
	@echo "==> Waiting for PostgreSQL to be ready..."
	@until pg_isready -q -p $(DB_PORT); do sleep 1; done
	@$(MAKE) -s db-init
	@echo "==> PostgreSQL ready at localhost:$(DB_PORT)/$(DB_NAME)"

db-init:
	@echo "==> Ensuring postgres role and database exist..."
	@psql postgres -tc "SELECT 1 FROM pg_roles WHERE rolname='$(DB_USER)'" | grep -q 1 || \
		psql postgres -c "CREATE ROLE $(DB_USER) WITH SUPERUSER LOGIN PASSWORD '$(DB_PASS)';"
	@psql -U $(DB_USER) postgres -tc "SELECT 1 FROM pg_database WHERE datname='$(DB_NAME)'" | grep -q 1 || \
		psql -U $(DB_USER) postgres -c "CREATE DATABASE $(DB_NAME);"
	@psql -U $(DB_USER) -d $(DB_NAME) -c "CREATE TABLE IF NOT EXISTS users (userid VARCHAR(50) PRIMARY KEY, full_name VARCHAR(100), email VARCHAR(100), password VARCHAR(100), role VARCHAR(20), created_at DATE DEFAULT CURRENT_DATE);" -q
	@psql -U $(DB_USER) -d $(DB_NAME) -c "CREATE TABLE IF NOT EXISTS history (id SERIAL PRIMARY KEY, userid VARCHAR(50) REFERENCES users(userid), prediction_date DATE, age INT, resting_bp INT, cholesterol INT, prediction_result INT);" -q
	@psql -U $(DB_USER) -d $(DB_NAME) -c "INSERT INTO users (userid, full_name, email, password, role) VALUES ('admin', 'Admin', 'admin@admin.com', 'admin123', 'admin') ON CONFLICT (userid) DO NOTHING;" -q

db-stop:
	@echo "==> Stopping PostgreSQL..."
	@$(PG_SVC_STOP) || true

# --- ML artifacts ---

## Regenerate scaler.pkl from heart.csv (no notebook needed)
scaler:
	@echo "==> Installing Python dependencies..."
	@$(PYTHON) -m pip install -q pandas scikit-learn joblib flask
	@echo "==> Generating scaler.pkl..."
	@$(PYTHON) $(FLASK_DIR)/gen_scaler.py
	@echo "==> Done: $(FLASK_DIR)/scaler.pkl"

# --- Flask ML server ---

flask-start:
	@[ -f "$(FLASK_DIR)/scaler.pkl" ] || $(MAKE) scaler
	@echo "==> Starting Flask ML server..."
	@cd $(FLASK_DIR) && nohup $(PYTHON) app.py > ../flask.log 2>&1 & echo $$! > ../flask.pid
	@sleep 2
	@echo "==> Flask running at http://127.0.0.1:5000 (logs: flask.log)"

flask-stop:
	@echo "==> Stopping Flask ML server..."
	@if [ -f flask.pid ]; then \
		kill $$(cat flask.pid) 2>/dev/null || true; \
		$(RM_F) flask.pid; \
	fi

# --- Java web app ---

app-build:
	@echo "==> Building WAR..."
	@mvn clean package -q
	@echo "==> Build complete: target/$(WAR_NAME).war"

app-start: app-build
	@if [ ! -d "$(TOMCAT_HOME)" ]; then \
		echo ""; \
		echo "ERROR: Tomcat not found at $(TOMCAT_HOME)."; \
		echo "       Run 'make setup' first, or set CATALINA_HOME (Windows) / TOMCAT_HOME."; \
		echo ""; \
		exit 1; \
	fi
	@echo "==> Deploying to Tomcat..."
	@cp "target/$(WAR_NAME).war" "$(TOMCAT_HOME)/webapps/"
	@$(TOMCAT_START)
	@echo "==> App running at http://localhost:8080/$(WAR_NAME)/"

app-stop:
	@echo "==> Stopping Tomcat..."
	@$(TOMCAT_STOP) 2>/dev/null || true

# --- Cleanup ---

clean: stop
	@echo "==> Cleaning build artifacts..."
	@mvn clean -q
	@$(RM_F) flask.pid flask.log
	@echo "==> Clean complete."
