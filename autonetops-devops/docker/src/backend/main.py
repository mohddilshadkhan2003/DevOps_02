from __future__ import annotations

import os
import sqlite3
from datetime import datetime, timezone
from pathlib import Path
from urllib.parse import urlparse, unquote

from flask import Flask, jsonify

app = Flask(__name__)

APP_ENV = os.getenv("APP_ENV", "development")
APP_HOST = os.getenv("APP_HOST", "0.0.0.0")
APP_PORT = int(os.getenv("APP_PORT", "8000"))
DATASTORE_URL = os.getenv("DATASTORE_URL", "sqlite:////app/data/db.sqlite3")


def ensure_database() -> str:
    parsed = urlparse(DATASTORE_URL)
    if parsed.scheme != "sqlite":
        return DATASTORE_URL

    db_path = unquote(parsed.path or "/app/data/db.sqlite3")
    db_file = Path(db_path)
    db_file.parent.mkdir(parents=True, exist_ok=True)

    with sqlite3.connect(str(db_file)) as connection:
        connection.execute(
            """
            CREATE TABLE IF NOT EXISTS health_checks (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                checked_at TEXT NOT NULL
            )
            """
        )
        connection.execute(
            "INSERT INTO health_checks (checked_at) VALUES (?)",
            (datetime.now(timezone.utc).isoformat(),),
        )
        connection.commit()

    return str(db_file)


@app.route("/")
def home() -> tuple[dict, int]:
    return (
        jsonify(
            {
                "service": "autonetops-backend",
                "status": "ok",
                "environment": APP_ENV,
                "timestamp": datetime.now(timezone.utc).isoformat(),
                "database": ensure_database(),
            }
        ),
        200,
    )


@app.route("/health")
def health() -> tuple[dict, int]:
    return (
        jsonify(
            {
                "status": "healthy",
                "service": "autonetops-backend",
                "environment": APP_ENV,
                "database": ensure_database(),
            }
        ),
        200,
    )


if __name__ == "__main__":
    ensure_database()
    app.run(host=APP_HOST, port=APP_PORT, debug=APP_ENV.lower() != "production")
