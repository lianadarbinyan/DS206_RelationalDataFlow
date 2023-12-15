import openpyxl
import os

# Path to the Excel file
excel_file_path = 'raw_data_source.xlsx'

# Output folder for SQL scripts
output_folder = 'queries/'

# Load the Excel workbook
workbook = openpyxl.load_workbook(excel_file_path)

# Iterate through each sheet and generate a SQL script
for sheet_name in workbook.sheetnames:
    table_name = sheet_name.lower().replace(' ', '_')  

    # Create the SQL script content
    sql_script_content = f"""
-- {output_folder}create_table_{table_name}.sql

-- Create an empty table for sheet: {sheet_name}
CREATE TABLE IF NOT EXISTS {table_name} (
    -- Define your table columns here
    column1 INT,
    column2 VARCHAR(255),
    -- Add more columns as needed
);

-- Optionally, add additional table constraints or indices
"""

    # Save the SQL script to a file
    script_filename = f"{output_folder}create_table_{table_name}.sql"
    with open(script_filename, 'w') as script_file:
        script_file.write(sql_script_content)

print("SQL scripts generated successfully.")
