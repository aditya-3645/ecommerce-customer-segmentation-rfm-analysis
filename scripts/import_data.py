"""
ETL Script

Purpose:
Import Olist Brazilian E-Commerce CSV datasets into MySQL tables.

Author: Aditya
"""

import pandas as pd
import os
from sqlalchemy import create_engine
from sqlalchemy.engine import URL

# ==========================
# MYSQL DETAILS
# ==========================

MYSQL_USER = "USER"
MYSQL_PASSWORD = "YOUR PASSWORD"
MYSQL_HOST = "localhost"
MYSQL_DATABASE = "ecommerce-rfm"

# ==========================
# CSV FOLDER LOCATION
# ==========================

CSV_FOLDER = r"C:\Users\Dell\Downloads\ecommerce-rfm-project"

# ==========================
# MYSQL CONNECTION
# ==========================

connection_url = URL.create(
    drivername="mysql+pymysql",
    username=MYSQL_USER,
    password=MYSQL_PASSWORD,
    host=MYSQL_HOST,
    database=MYSQL_DATABASE
)

engine = create_engine(connection_url)

# ==========================
# FILE -> TABLE MAPPING
# ==========================

files = {
    "olist_orders_dataset.csv": "orders",
    "olist_products_dataset.csv": "products",
    "olist_sellers_dataset.csv": "sellers",
    "olist_order_items_dataset.csv": "order_items",
    "olist_order_payments_dataset.csv": "order_payments",
    "olist_order_reviews_dataset.csv": "order_reviews",
    "olist_customers_dataset.csv": "customers"
}

print("=" * 60)
print("STARTING IMPORT")
print("=" * 60)

for filename, table_name in files.items():

    try:

        file_path = os.path.join(CSV_FOLDER, filename)

        print(f"\nReading: {filename}")

        df = pd.read_csv(file_path)

        print(f"Rows Found: {len(df)}")

        df.to_sql(
            name=table_name,
            con=engine,
            if_exists="replace",
            index=False,
            chunksize=5000,
            method="multi"
        )

        print(f"SUCCESS -> {table_name}")

    except Exception as e:

        print(f"FAILED -> {filename}")
        print(e)

print("\n" + "=" * 60)
print("IMPORT COMPLETED")
print("=" * 60)