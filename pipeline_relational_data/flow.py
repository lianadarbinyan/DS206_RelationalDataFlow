#import config
import sys
from .config import logs_location
import os
from .tasks import connect_db_create_cursor, drop_table, create_table, insert_into_table
import utils  
from logger import CustomLogs
import logging

#setting up logging
log_file_path= logs_location
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
file_handler = logging.FileHandler(log_file_path)
file_handler.setLevel(logging.DEBUG)

# Set the formatter for the FileHandler
file_handler.setFormatter(CustomLogs())
# Add the FileHandler to the logger
logger.addHandler(file_handler)

class RelationalDataFlow:
    def __init__(self):
        # Generate a unique UUID upon object creation
        self.execution_id = utils.generate_uuid()
        logger.info(f"RelationalDataFlow instance created with UUID: {self.execution_id}")

    def exec(self):
        # Create a cursor
        curs = connect_db_create_cursor('ORDERS_RELATIONAL_DB')

        # Example: Drop and create a table
        #drop_table(curs, 'customers', 'ORDERS_RELATIONAL_DB', 'dbo')
        #create_table(curs, 'customers', 'ORDERS_RELATIONAL_DB', 'dbo')
        #drop_table(curs, 'categories', 'ORDERS_RELATIONAL_DB', 'dbo')
        #create_table(curs, 'categories', 'ORDERS_RELATIONAL_DB', 'dbo')
        #drop_table(curs, 'employees', 'ORDERS_RELATIONAL_DB', 'dbo')
        #create_table(curs, 'employees', 'ORDERS_RELATIONAL_DB', 'dbo')
        #drop_table(curs, 'orders', 'ORDERS_RELATIONAL_DB', 'dbo')
        #create_table(curs, 'orders', 'ORDERS_RELATIONAL_DB', 'dbo')
        #drop_table(curs, 'shippers', 'ORDERS_RELATIONAL_DB', 'dbo')
        #create_table(curs, 'shippers', 'ORDERS_RELATIONAL_DB', 'dbo')
        #drop_table(curs, 'region', 'ORDERS_RELATIONAL_DB', 'dbo')
        #create_table(curs, 'region', 'ORDERS_RELATIONAL_DB', 'dbo')
        #drop_table(curs, 'territories', 'ORDERS_RELATIONAL_DB', 'dbo')
        #create_table(curs, 'territories', 'ORDERS_RELATIONAL_DB', 'dbo')
        #drop_table(curs, 'suppliers', 'ORDERS_RELATIONAL_DB', 'dbo')
        #create_table(curs, 'suppliers', 'ORDERS_RELATIONAL_DB', 'dbo')
        #drop_table(curs, 'products', 'ORDERS_RELATIONAL_DB', 'dbo')
        #create_table(curs, 'products', 'ORDERS_RELATIONAL_DB', 'dbo')
        #drop_table(curs, 'orderdetails', 'ORDERS_RELATIONAL_DB', 'dbo')
        #create_table(curs, 'orderdetails', 'ORDERS_RELATIONAL_DB', 'dbo')

        # Example: Insert data into a table
        file_path = r'C:\\Users\\Lenovo\\Desktop\\Group1_DS206_GroupProject2\\raw_data_source.xlsx'
        #insert_into_table(curs, 'customers', 'ORDERS_RELATIONAL_DB', 'dbo', file_path, 'Customers')
        #insert_into_table(curs, 'employees', 'ORDERS_RELATIONAL_DB', 'dbo', file_path, 'Employees')
        #insert_into_table(curs, 'orders', 'ORDERS_RELATIONAL_DB', 'dbo', file_path, 'Orders')
        #insert_into_table(curs, 'orderdetails', 'ORDERS_RELATIONAL_DB', 'dbo', file_path, 'OrderDetails')
        #insert_into_table(curs, 'shippers', 'ORDERS_RELATIONAL_DB', 'dbo', file_path, 'Shippers')
        #insert_into_table(curs, 'region', 'ORDERS_RELATIONAL_DB', 'dbo', file_path, 'Region')
        # insert_into_table(curs, 'territories', 'ORDERS_RELATIONAL_DB', 'dbo', file_path, 'Territories')
        #insert_into_table(curs, 'suppliers', 'ORDERS_RELATIONAL_DB', 'dbo', file_path, 'Suppliers')
        #insert_into_table(curs, 'products', 'ORDERS_RELATIONAL_DB', 'dbo', file_path, 'Products')
        #insert_into_table(curs, 'categories', 'ORDERS_RELATIONAL_DB', 'dbo', file_path, 'Categories')

        logger.info("Relational Completed Successfully")

