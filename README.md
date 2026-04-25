# ❤️ Heart Disease Prediction System

## 📌 Purpose

Medical reports contain multiple parameters (age, BP, cholesterol, etc.), making it difficult to quickly assess heart disease risk.
This system allows users to enter their report values and get an instant prediction.

---

## 🚀 Features

* User Login & Signup
* Real-time Prediction
* Prediction History stored in PostgreSQL
* Admin Dashboard

---

## 🧠 Model

* Dataset: Kaggle (~916 rows)
* Algorithm: Naive Bayes
* Accuracy: **93.2%**
* F1 Score: **0.9208**

---

## ⚙️ Tech Stack

* Frontend: JSP
* Backend: Java Servlets
* Database: PostgreSQL
* ML: Python (Flask API + Scikit-learn)

---

## 🔗 Flow

JSP → Servlet → Flask API → ML Model → Result → Database

---

## 📌 Note

This project focuses on integrating Machine Learning into a real-world full-stack system.

---

## 🛠️ Running Locally

### Prerequisites

- macOS with [Homebrew](https://brew.sh)
- Java 17+ (managed via [asdf](https://asdf-vm.com) or system install)
- Maven
- Python 3
- Docker (optional — only needed if not using Homebrew for PostgreSQL)

### 1. Install dependencies (one-time)

```bash
make setup
```

This installs **Tomcat 9** and **PostgreSQL 15** via Homebrew.

### 2. Start the application

```bash
make start
```

This will:
- Start PostgreSQL and create the `heart_disease_project` database, tables, and default admin user
- Generate `DataModel/scaler.pkl` from `heart.csv` if missing (no notebook required)
- Install Python dependencies (`pandas`, `scikit-learn`, `flask`, `joblib`)
- Start the Flask ML API at `http://127.0.0.1:5000`
- Build the WAR with Maven and deploy it to Tomcat

### 3. Open the app

| URL | Description |
|-----|-------------|
| `http://localhost:8080/Heart_Disease/` | Landing page |
| `http://localhost:8080/Heart_Disease/login.jsp` | User login |
| `http://localhost:8080/Heart_Disease/signup.jsp` | User signup |

### 4. Stop the application

```bash
make stop
```

---

## 👤 Default Credentials

| Role | User ID | Password |
|------|---------|----------|
| Admin | `admin` | `admin123` |
| User | _(sign up)_ | _(sign up)_ |

Admin logs in at `login.jsp` and is redirected to the stats dashboard.
Regular users are redirected to their prediction history and can click **Predict** to submit health data.

---

## 🧹 Available Make Targets

| Target | Description |
|--------|-------------|
| `make setup` | Install Tomcat 9 and PostgreSQL 15 via Homebrew |
| `make start` | Start all services (DB + Flask + Tomcat) |
| `make stop` | Stop all services |
| `make scaler` | Regenerate `scaler.pkl` from `heart.csv` |
| `make db-start` | Start PostgreSQL only |
| `make db-stop` | Stop PostgreSQL only |
| `make flask-start` | Start Flask ML server only |
| `make flask-stop` | Stop Flask ML server only |
| `make app-build` | Build the WAR file only |
| `make app-start` | Build and deploy to Tomcat only |
| `make app-stop` | Stop Tomcat only |
| `make clean` | Stop everything and remove build artifacts |

---

## 🔗 Architecture

```
Browser → JSP (Tomcat :8080) → Java Servlet → PostgreSQL :5432
                                      ↓
                               Flask API :5000 → KNN Model → Prediction
```
