import openpyxl
import os

# Path to the Excel file
excel_file_path = 'raw_data_source.xlsx'

# Output folder for SQL scripts
output_folder = 'pipeline_relational_data/queries/'

# Database and schema information
db = 'db'
schema = 'schema'

# Load the Excel workbook
workbook = openpyxl.load_workbook(excel_file_path)

# Iterate through each sheet and generate a generic SQL script for inserting data
for sheet_name in workbook.sheetnames:
    table_name = sheet_name.lower().replace(' ', '_')

    # Load the sheet data
    sheet = workbook[sheet_name]
    
    # Extract column names from the first row of the sheet
    columns = [cell.value for cell in sheet[1]]

    # Create the SQL script content
    sql_script_content = f"""
-- {output_folder}insert_into_{table_name}.sql

-- Insert data into table: {table_name}
INSERT INTO {db}.{schema}.{table_name}
   ({', '.join(columns)})
VALUES
    ({', '.join(['?' for _ in columns])});
"""

    # Save the SQL script to a file
    script_filename = f"{output_folder}insert_into_{table_name}.sql"
    with open(script_filename, 'w') as script_file:
        script_file.write(sql_script_content)

print("SQL scripts generated successfully.")
