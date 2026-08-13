import os
import re
import pandas as pd
import pyodbc
from datetime import datetime


# ============================================================
# 1. CONFIGURATION
# ============================================================

SERVER = r"localhost"          # Change if required
DATABASE = "master"
TARGET_DATABASE = "test"

# Change this to your CSV root folder
CSV_ROOT_FOLDER = (
    r"C:\Users\Numantra\OneDrive - NuMantra Technologies"
    r"\Desktop\Usql\sql-data-warehouse-project"
    r"\sql-data-warehouse-project\datasets"
)

# SQL Server connection
CONNECTION_STRING = (
    "DRIVER={ODBC Driver 17 for SQL Server};"
    f"SERVER={SERVER};"
    f"DATABASE={DATABASE};"
    "Trusted_Connection=yes;"
)

# Folder where generated SQL will be saved
OUTPUT_SQL_FILE = "generated_test.sql"


# ============================================================
# 2. SQL SERVER CONNECTION
# ============================================================

def get_connection(database="master"):

    connection_string = (
        "DRIVER={ODBC Driver 17 for SQL Server};"
        f"SERVER={SERVER};"
        f"DATABASE={database};"
        "Trusted_Connection=yes;"
    )

    return pyodbc.connect(connection_string)


# ============================================================
# 3. CLEAN TABLE NAME
# ============================================================

def clean_name(name):

    name = str(name).strip()

    # Replace spaces and special characters with _
    name = re.sub(r"[^a-zA-Z0-9_]", "_", name)

    # Prevent name starting with number
    if name and name[0].isdigit():
        name = "_" + name

    return name


# ============================================================
# 4. INFER SQL SERVER DATA TYPE
# ============================================================

def infer_sql_type(series):

    # Remove null values for datatype detection
    non_null = series.dropna()

    if len(non_null) == 0:
        return "NVARCHAR(255)"

    # Convert values to string for testing
    values = non_null.astype(str).str.strip()

    # --------------------------------------------------------
    # INTEGER
    # --------------------------------------------------------

    numeric_values = pd.to_numeric(values, errors="coerce")

    if numeric_values.notna().all():

        # Check if all values are integer
        if (numeric_values % 1 == 0).all():

            min_value = numeric_values.min()
            max_value = numeric_values.max()

            if min_value >= -2147483648 and max_value <= 2147483647:
                return "INT"

            elif min_value >= -9223372036854775808 and \
                 max_value <= 9223372036854775807:
                return "BIGINT"

            else:
                return "DECIMAL(18,2)"

        else:
            return "DECIMAL(18,4)"

    # --------------------------------------------------------
    # DATE / DATETIME
    # --------------------------------------------------------

    date_values = pd.to_datetime(
        values,
        errors="coerce"
    )

    if date_values.notna().all():

        # Check if time component exists
        if (
            date_values.dt.hour.eq(0).all()
            and date_values.dt.minute.eq(0).all()
            and date_values.dt.second.eq(0).all()
        ):
            return "DATE"

        return "DATETIME2"

    # --------------------------------------------------------
    # BOOLEAN
    # --------------------------------------------------------

    lower_values = values.str.lower()

    if lower_values.isin(
        ["true", "false", "yes", "no", "0", "1"]
    ).all():

        return "BIT"

    # --------------------------------------------------------
    # STRING
    # --------------------------------------------------------

    max_length = values.str.len().max()

    # Keep reasonable size
    if max_length <= 50:
        size = 50

    elif max_length <= 100:
        size = 100

    elif max_length <= 255:
        size = 255

    elif max_length <= 1000:
        size = 1000

    else:
        return "NVARCHAR(MAX)"

    return f"NVARCHAR({size})"


# ============================================================
# 5. CREATE DATABASE AND SCHEMAS
# ============================================================

def create_database():

    # Connect to master database
    conn = get_connection("master")

    # IMPORTANT:
    # ALTER DATABASE and DROP DATABASE
    # should run outside a transaction
    conn.autocommit = True

    cursor = conn.cursor()

    print(f"\nChecking {TARGET_DATABASE} database...")

    # Check if database exists
    cursor.execute(f"""
    IF EXISTS (
        SELECT 1
        FROM sys.databases
        WHERE name = '{TARGET_DATABASE}'
    )
    BEGIN
        ALTER DATABASE [{TARGET_DATABASE}]
        SET SINGLE_USER
        WITH ROLLBACK IMMEDIATE;

        DROP DATABASE [{TARGET_DATABASE}];
    END;
    """)

    print(
        f"{TARGET_DATABASE} database dropped "
        f"if it existed."
    )

    # Create new database
    cursor.execute(
        f"CREATE DATABASE [{TARGET_DATABASE}];"
    )

    print(
        f"{TARGET_DATABASE} database created successfully."
    )

    cursor.close()
    conn.close()

def create_schemas():

    conn = get_connection(TARGET_DATABASE)
    cursor = conn.cursor()

    schemas = ["bronze", "silver", "gold"]

    for schema in schemas:

        cursor.execute(f"""
        IF NOT EXISTS (
            SELECT 1
            FROM sys.schemas
            WHERE name = '{schema}'
        )
        BEGIN
            EXEC('CREATE SCHEMA [{schema}]');
        END;
        """)

    conn.commit()

    cursor.close()
    conn.close()

    print("Schemas created: bronze, silver, gold")


# ============================================================
# 6. CREATE TABLE
# ============================================================

def create_table(
    cursor,
    schema_name,
    table_name,
    columns
):

    column_definitions = []

    for column_name, sql_type in columns:

        column_name = clean_name(column_name)

        column_definitions.append(
            f"    [{column_name}] {sql_type}"
        )

    create_table_sql = f"""
CREATE TABLE [{schema_name}].[{table_name}]
(
{',\n'.join(column_definitions)}
);
"""

    cursor.execute(create_table_sql)

    return create_table_sql


# ============================================================
# 7. LOAD DATA INTO SQL SERVER
# ============================================================

def load_data(
    conn,
    df,
    schema_name,
    table_name,
    columns
):

    cursor = conn.cursor()

    column_names = [
        clean_name(col)
        for col, _ in columns
    ]

    placeholders = ",".join(
        ["?" for _ in column_names]
    )

    insert_sql = f"""
    INSERT INTO [{schema_name}].[{table_name}]
    (
        {",".join(f"[{col}]" for col in column_names)}
    )
    VALUES
    ({placeholders})
    """

    # Replace pandas NaN with None
    df = df.where(
        pd.notnull(df),
        None
    )

    # Convert dataframe to tuples
    data = [
        tuple(row)
        for row in df.itertuples(
            index=False,
            name=None
        )
    ]

    cursor.fast_executemany = True

    cursor.executemany(
        insert_sql,
        data
    )

    conn.commit()

    cursor.close()

    return len(data)


# ============================================================
# 8. PROCESS EACH CSV
# ============================================================

def process_csv(
    csv_file,
    sql_output
):

    print("\n" + "=" * 70)

    print(
        f"Processing: "
        f"{os.path.basename(csv_file)}"
    )

    # --------------------------------------------------------
    # Read CSV
    # --------------------------------------------------------

    df = pd.read_csv(
        csv_file,
        dtype=str,
        keep_default_na=False
    )

    print(
        f"Rows detected: {len(df)}"
    )

    print(
        f"Columns detected: {len(df.columns)}"
    )

    # --------------------------------------------------------
    # Table name
    # --------------------------------------------------------

    file_name = os.path.basename(
        csv_file
    )

    table_name = os.path.splitext(
        file_name
    )[0]

    table_name = clean_name(
        table_name
    )

    # --------------------------------------------------------
    # Infer column datatypes
    # --------------------------------------------------------

    columns = []

    for column in df.columns:

        sql_type = infer_sql_type(
            df[column]
        )

        columns.append(
            (
                column,
                sql_type
            )
        )

        print(
            f"{column} -> {sql_type}"
        )

    # --------------------------------------------------------
    # SQL Server connection
    # --------------------------------------------------------

    conn = get_connection(
        TARGET_DATABASE
    )

    cursor = conn.cursor()

    # --------------------------------------------------------
    # Create table
    # --------------------------------------------------------

    create_table_sql = create_table(
        cursor,
        "bronze",
        table_name,
        columns
    )

    conn.commit()

    # --------------------------------------------------------
    # Load data
    # --------------------------------------------------------

    rows_loaded = load_data(
        conn,
        df,
        "bronze",
        table_name,
        columns
    )

    # --------------------------------------------------------
    # Validate
    # --------------------------------------------------------

    cursor = conn.cursor()

    cursor.execute(
        f"""
        SELECT COUNT(*)
        FROM [bronze].[{table_name}]
        """
    )

    sql_row_count = cursor.fetchone()[0]

    cursor.close()
    conn.close()

    # --------------------------------------------------------
    # Generate SQL documentation
    # --------------------------------------------------------

    sql_output.append(
        f"\n-- ==================================================\n"
    )

    sql_output.append(
        f"-- Source File: {csv_file}\n"
    )

    sql_output.append(
        f"-- Table: bronze.{table_name}\n"
    )

    sql_output.append(
        f"-- Rows Loaded: {rows_loaded}\n"
    )

    sql_output.append(
        f"-- SQL Server Rows: {sql_row_count}\n"
    )

    sql_output.append(
        f"-- ==================================================\n"
    )

    sql_output.append(
        create_table_sql
    )

    sql_output.append(
        f"""
-- Data loaded using Python
-- Original CSV:
-- {csv_file}

-- Validation
SELECT COUNT(*) AS row_count
FROM bronze.{table_name};

SELECT TOP 100 *
FROM bronze.{table_name};
"""
    )

    print(
        f"Rows loaded successfully: "
        f"{rows_loaded}"
    )

    print(
        f"SQL Server row count: "
        f"{sql_row_count}"
    )


# ============================================================
# 9. MAIN PROGRAM
# ============================================================

def main():

    start_time = datetime.now()

    print("=" * 70)

    print(
        "STARTING DATA WAREHOUSE AUTOMATION"
    )

    print("=" * 70)

    # --------------------------------------------------------
    # Create database
    # --------------------------------------------------------

    create_database()

    # --------------------------------------------------------
    # Create schemas
    # --------------------------------------------------------

    create_schemas()

    # --------------------------------------------------------
    # Find CSV files
    # --------------------------------------------------------

    csv_files = []

    for root, dirs, files in os.walk(
        CSV_ROOT_FOLDER
    ):

        for file in files:

            if file.lower().endswith(
                ".csv"
            ):

                csv_files.append(
                    os.path.join(
                        root,
                        file
                    )
                )

    print(
        f"\nTotal CSV files found: "
        f"{len(csv_files)}"
    )

    # --------------------------------------------------------
    # SQL output
    # --------------------------------------------------------

    sql_output = []

    sql_output.append(
        """
-- ============================================================
-- AUTO GENERATED DATA WAREHOUSE SQL
-- ============================================================

USE master;
GO

USE test;
GO

-- Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
"""
    )

    # --------------------------------------------------------
    # Process all CSVs
    # --------------------------------------------------------

    for csv_file in csv_files:

        try:

            process_csv(
                csv_file,
                sql_output
            )

        except Exception as e:

            print(
                f"\nERROR processing "
                f"{csv_file}"
            )

            print(e)

    # --------------------------------------------------------
    # Save generated SQL
    # --------------------------------------------------------

    with open(
        OUTPUT_SQL_FILE,
        "w",
        encoding="utf-8"
    ) as file:

        file.write(
            "\n".join(sql_output)
        )

    end_time = datetime.now()

    duration = (
        end_time - start_time
    )

    print("\n" + "=" * 70)

    print(
        "DATA WAREHOUSE LOAD COMPLETED"
    )

    print(
        f"Total execution time: "
        f"{duration}"
    )

    print(
        f"Generated SQL file: "
        f"{OUTPUT_SQL_FILE}"
    )

    print("=" * 70)


# ============================================================
# 10. RUN
# ============================================================

if __name__ == "__main__":

    main()