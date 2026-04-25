TOMCAT_HOME  := $(shell brew --prefix tomcat@9 2>/dev/null)/libexec
JAVA_HOME    := $(shell asdf where java 2>/dev/null || /usr/libexec/java_home 2>/dev/null)
export JAVA_HOME
DB_NAME      := heart_disease_project
DB_USER      := postgres
DB_PASS      := Ankit@4837
DB_PORT      := 5432
FLASK_DIR    := DataModel
WAR_NAME     := Heart_Disease

.PHONY: all setup start stop db-start db-stop db-init scaler flask-start app-build app-start clean

all: start

## Install Tomcat 9 and PostgreSQL 15 via Homebrew (one-time setup)
setup:
	@echo "==> Installing Tomcat 9 and PostgreSQL 15..."
	brew install tomcat@9 postgresql@15
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
	@echo "==> Starting PostgreSQL 15 (Homebrew)..."
	@brew services start postgresql@15
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
	@brew services stop postgresql@15

# --- ML artifacts ---

## Regenerate scaler.pkl from heart.csv (no notebook needed)
scaler:
	@echo "==> Installing Python dependencies..."
	@pip install -q pandas scikit-learn joblib flask
	@echo "==> Generating scaler.pkl..."
	@python $(FLASK_DIR)/gen_scaler.py
	@echo "==> Done: $(FLASK_DIR)/scaler.pkl"

# --- Flask ML server ---

flask-start:
	@[ -f "$(FLASK_DIR)/scaler.pkl" ] || $(MAKE) scaler
	@echo "==> Starting Flask ML server..."
	@cd $(FLASK_DIR) && nohup python app.py > ../flask.log 2>&1 & echo $$! > ../flask.pid
	@sleep 2
	@echo "==> Flask running at http://127.0.0.1:5000 (logs: flask.log)"

flask-stop:
	@echo "==> Stopping Flask ML server..."
	@if [ -f flask.pid ]; then \
		kill $$(cat flask.pid) 2>/dev/null || true; \
		rm -f flask.pid; \
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
		echo "       Run 'make setup' first to install Tomcat 9."; \
		echo ""; \
		exit 1; \
	fi
	@echo "==> Deploying to Tomcat..."
	@cp target/$(WAR_NAME).war $(TOMCAT_HOME)/webapps/
	@$(TOMCAT_HOME)/bin/startup.sh
	@echo "==> App running at http://localhost:8080/$(WAR_NAME)/"

app-stop:
	@echo "==> Stopping Tomcat..."
	@$(TOMCAT_HOME)/bin/shutdown.sh 2>/dev/null || true

# --- Cleanup ---

clean: stop
	@echo "==> Cleaning build artifacts..."
	@mvn clean -q
	@rm -f flask.pid flask.log
	@echo "==> Clean complete."
