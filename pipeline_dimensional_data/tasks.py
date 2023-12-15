# import sys
from .config import input_dir, sql_server_config, logs_location
import os
import pandas as pd
import pyodbc
from utils import get_sql_config
from logger import CustomLogs

import logging
#setting up logging
log_file_path= logs_location
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# Create a FileHandler and set the level to DEBUG
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
    sql_script = ''
    for script in os.listdir(input_dir):
        if query_name in script:
            with open(input_dir + '\\' + script, 'r') as script_file:
                sql_script = script_file.read()
            break

    #logger.info("Loaded SQL Script: %s", sql_script) 
    return sql_script


def drop_table_dim(cursor, table_name, db, schema):
    drop_table_script = load_query('drop_table').format(db=db, schema=schema, table=table_name)
    print("Loaded Query:", drop_table_script)  # Add this line
    cursor.execute(drop_table_script)
    cursor.commit()
    print("The {schema}.{table_name} table from the database {db} has been dropped".format(db=db, schema=schema,
                                                                                       table_name=table_name))
    logger.info("The {schema}.{table_name} table from the database {db} has been dropped".format(db=db, schema=schema,
                                                                                       table_name=table_name))
    
def create_table_dim(cursor, table_name, db, schema):
    create_table_script = load_query('create_table_{}'.format(table_name)).format(db=db, schema=schema)
    print("SQL Query:", create_table_script)  # Add this line
    cursor.execute(create_table_script)
    cursor.commit()
    print("The {schema}.{table_name} table from the database {db} has been created".format(db=db, schema=schema,
                                                                                           table_name=table_name))
    logger.info("The {schema}.{table_name} table from the database {db} has been created".format(db=db, schema=schema,
                                                                                           table_name=table_name))
    

def update_table(cursor, table_dst, db_dst, schema_dst, table_src, db_src, schema_src):
    update_table_script = load_query('update_table_{}'.format(table_dst)).format(
        db_dim=db_dst, schema_dim=schema_dst, table_dim=table_dst,
        db_rel=db_src, schema_rel=schema_src, table_rel=table_src)

    cursor.execute(update_table_script)

    result = cursor.fetchall()

    for row in result:
        print({row})

    cursor.commit()

    print(f"The dimension table {table_dst} has been updated.")



def update_dim_table_scd4(cursor, table_dst, table_hist, db_dst, schema_dst, table_src, db_src, schema_src):
    # Load the SQL script using the formatted variables
    update_table_script = load_query('update_table_{}'.format(table_dst)).format(
        db_dim=db_dst, schema_dim=schema_dst, table_dim=table_dst, table_hist=table_hist,
        db_rel=db_src, schema_rel=schema_src, table_rel=table_src, table_dst=table_dst  # Include table_dst in the formatting dictionary
    )

    # Print the update query for debugging
    print("Update Query:")
    print(update_table_script)

    # Execute the query
    try:
        cursor.execute(update_table_script)
        cursor.commit()
        print(f"The dimension tables {table_dst} and {table_hist} have been updated.")
    except Exception as e:
        print("Error executing query:", str(e))
    logger.info(f"The dimension table {table_dst} has been updated.")



