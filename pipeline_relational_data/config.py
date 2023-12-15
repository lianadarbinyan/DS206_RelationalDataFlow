input_dir = 'C:\\Users\\Lenovo\\Desktop\\Group1_DS206_GroupProject2\\pipeline_relational_data\\queries'
logs_location = 'C:\\Users\\Lenovo\\Desktop\\Group1_DS206_GroupProject2\\logs\\logs_relational_data_pipeline.txt'
sql_server_config = 'C:\\Users\\Lenovo\\Desktop\\Group1_DS206_GroupProject2\\sql_server_config.cfg'
import os
import sys


current_script_directory = os.path.dirname(os.path.abspath(__file__))

parent_directory = os.path.abspath(os.path.join(current_script_directory, '..'))
sys.path.append(parent_directory)
