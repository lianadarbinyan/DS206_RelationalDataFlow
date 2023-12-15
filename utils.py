
import uuid
import configparser
# utils.py
import configparser
# utils.py
import configparser

def get_sql_config(filename, database):
    """de
    Get SQL Server configuration parameters from a configuration file.

    Parameters:
    - filename (str): Path to the configuration file.
    - database (str): Name of the database section in the configuration file.

    Returns:
    - tuple: Configuration parameters (driver, server, database, trusted_connection).
    """
    cf = configparser.ConfigParser()
    cf.read(filename)  # Read configuration file

    # Read corresponding file parameters
    _driver = cf.get(database, "DRIVER")
    _server = cf.get(database, "Server")
    _database = cf.get(database, "Database")
    _trusted_connection = cf.get(database, "Trusted_Connection")

    return _driver, _server, _database, _trusted_connection



def generate_uuid():
    """
    Generate a unique UUID.

    Returns:
    - str: Unique UUID as a string.
    """
    return str(uuid.uuid4())

