import sys
import os
from .config import logs_location
from .tasks import connect_db_create_cursor, update_dim_table_scd4, drop_table_dim, create_table_dim,update_table #update_dim_table_scd4,
import utils
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

class DimensionalDataFlow:
    def __init__(self):
        # Generate a unique UUID upon object creation
        self.execution_id = utils.generate_uuid()
        # Set up logging with the generated UUID
        logger.info(f"DimensionalDataFlow instance created with UUID: {self.execution_id}")

    def exec(self):
        # Create a cursor
        curs = connect_db_create_cursor('ORDERS_DIMENSIONAL_DB')
        # drop_table_dim(curs, 'DimCategories_SCD1', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # create_table_dim(curs, 'DimCategories_SCD1', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # drop_table_dim(curs, 'DimCustomers_SCD2', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # create_table_dim(curs, 'DimCustomers_SCD2', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # drop_table_dim(curs, 'DimEmployees', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # create_table_dim(curs, 'DimEmployees', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # drop_table_dim(curs, 'DimEmployees_History', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # create_table_dim(curs, 'DimEmployees_History', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        #drop_table_dim(curs, 'DimSuppliers', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        #create_table_dim(curs, 'DimSuppliers', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # drop_table_dim(curs, 'DimSuppliers_History', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # create_table_dim(curs, 'DimSuppliers_History', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # drop_table_dim(curs, 'DimProducts', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # create_table_dim(curs, 'DimProducts', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # drop_table_dim(curs, 'DimProducts_History', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # create_table_dim(curs, 'DimProducts_History', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # drop_table_dim(curs, 'DimRegion_SCD3', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # create_table_dim(curs, 'DimRegion_SCD3', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # drop_table_dim(curs, 'DimShippers_SCD1', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # create_table_dim(curs, 'DimShippers_SCD1', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        # drop_table_dim(curs, 'DimTerritories_SCD3', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        #create_table_dim(curs, 'DimTerritories_SCD3', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        #create_table_dim(curs, 'FactOrders', 'ORDERS_DIMENSIONAL_DB', 'dbo')
        
        #update_table(curs, 'DimShippers_SCD1', 'ORDERS_DIMENSIONAL_DB', 'dbo','Shippers', 'ORDERS_RELATIONAL_DB', 'dbo')
        #update_dim_table(curs, 'DimCategories_SCD1', None, 'ORDERS_DIMENSIONAL_DB', 'dbo','Categories', 'ORDERS_RELATIONAL_DB', 'dbo', 1)
        #update_table(curs, 'DimCustomers_SCD2', 'ORDERS_DIMENSIONAL_DB', 'dbo','Customers', 'ORDERS_RELATIONAL_DB', 'dbo')
        #update_table(curs, 'DimTerritories_SCD3', 'ORDERS_DIMENSIONAL_DB', 'dbo','Territories', 'ORDERS_RELATIONAL_DB', 'dbo')
        #update_table(curs, 'DimRegion_SCD3', 'ORDERS_DIMENSIONAL_DB', 'dbo','Region', 'ORDERS_RELATIONAL_DB', 'dbo')
        #update_dim_table_scd4(curs, 'DimSuppliers', 'DimSuppliers_SCD4_History', 'ORDERS_DIMENSIONAL_DB', 'dbo','Suppliers', 'ORDERS_RELATIONAL_DB', 'dbo')
        #update_dim_table_scd4(curs, 'DimProduct', 'DimProduct_SCD4_History', 'ORDERS_DIMENSIONAL_DB', 'dbo','Products', 'ORDERS_RELATIONAL_DB', 'dbo')
        #update_dim_table_scd4(curs, 'DimEmployees', 'DimEmployees_SCD4_History', 'ORDERS_DIMENSIONAL_DB', 'dbo','Employees', 'ORDERS_RELATIONAL_DB', 'dbo')
        update_table(curs, 'FactOrders', 'ORDERS_DIMENSIONAL_DB', 'dbo','Orders', 'ORDERS_RELATIONAL_DB', 'dbo')

        logger.info("Dimensional Flow Completed Successfully")

