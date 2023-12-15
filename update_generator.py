import openpyxl
import os

# Path to the Excel file
excel_file_path = 'raw_data_source.xlsx'

# Output folder for SQL scripts
output_folder = 'pipeline_dimensional_data/queries/'

# Load the Excel workbook
workbook = openpyxl.load_workbook(excel_file_path)

# Iterate through each sheet and generate a SQL script for update
for sheet_name in workbook.sheetnames:
    table_name = sheet_name.lower().replace(' ', '_')

    # Create the SQL script content for update
    sql_script_content = f"""
-- {output_folder}update_table_{table_name}.sql

-- Update existing records in the table based on the Excel data
-- Modify the SET statements as per your requirements
UPDATE {table_name}
SET
    column1 = YourNewValue1,
    column2 = YourNewValue2
-- Add more SET statements for other columns
WHERE
    -- Define your condition to match records for update
    -- For example, use an appropriate unique identifier
    YourUniqueIDColumn = YourUniqueIDValue;
"""

    # Save the SQL script to a file
    script_filename = f"{output_folder}update_table_{table_name}.sql"
    with open(script_filename, 'w') as script_file:
        script_file.write(sql_script_content)

print("Update SQL scripts generated successfully.")
