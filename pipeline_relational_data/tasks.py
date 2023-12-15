# import sys
from .config import input_dir, sql_server_config, logs_location
import os
import pandas as pd
import pyodbc
from utils import get_sql_config
import logging
from logger import CustomLogs


log_file_path= logs_location
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
file_handler = logging.FileHandler(log_file_path)
file_handler.setLevel(logging.DEBUG)

# Set the formatter for the FileHandler
file_handler.setFormatter(CustomLogs())
# Add the FileHandler to the logger
logger.addHandler(file_handler)

def connect_db_create_cursor(database_conf_name):
    # Call to read the configuration file
    db_conf = get_sql_config(sql_server_config, database_conf_name)
    # Create a connection string for SQL Server
    db_conn_str = 'Driver={};Server={};Database={};Trusted_Connection={};'.format(*db_conf)
    # Connect to the server and to the desired database
    db_conn = pyodbc.connect(db_conn_str)
    # Create a Cursor class instance for executing T-SQL statements
    db_cursor = db_conn.cursor()
    return db_cursor


def load_query(query_name):
    sql_script = ''  # Initialize sql_script before the loop
    for script in os.listdir(input_dir):
        if query_name in script:
            with open(os.path.join(input_dir, script), 'r') as script_file:
                sql_script = script_file.read()
            break

    print(f"Loaded SQL script for query {query_name}: {sql_script}")
    return sql_script




def drop_table(cursor, table_name, db, schema):
    drop_table_script = load_query('drop_table').format(db=db, schema=schema, table=table_name)
    print("Loaded Query:", drop_table_script)  # Add this line
    cursor.execute(drop_table_script)
    cursor.commit()
    print("The {schema}.{table_name} table from the database {db} has been dropped".format(db=db, schema=schema,
                                                                                       table_name=table_name))
    logger.info("The {schema}.{table_name} table from the database {db} has been dropped".format(db=db, schema=schema,
                                                                                       table_name=table_name))

def create_table(cursor, table_name, db, schema):
    create_table_script = load_query('create_table_{}'.format(table_name)).format(db=db, schema=schema)
    print("SQL Query:", create_table_script)  # Add this line
    cursor.execute(create_table_script)
    cursor.commit()
    print("The {schema}.{table_name} table from the database {db} has been created".format(db=db, schema=schema,
                                                                                          table_name=table_name))
    logger.info("The {schema}.{table_name} table from the database {db} has been created".format(db=db, schema=schema,
                                                                                           table_name=table_name))

def insert_into_table(cursor, table_name, db, schema, source_data, sheet_name):
    # Read the Excel sheet
    df = pd.read_excel(source_data, sheet_name=sheet_name, header=0)

    insert_into_table_script = load_query('insert_into_{}'.format(table_name)).format(db=db, schema=schema)

    # Populate a table in SQL Server
    for index, row in df.iterrows():
        values = [row[col] if pd.notna(row[col]) else None for col in df.columns]
        cursor.execute(insert_into_table_script, *values)
        cursor.commit()

    print(f"{len(df)} rows have been inserted into the {db}.{schema}.{table_name} table")
    logger.info("Done.")

