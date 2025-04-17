# imports
import pandas as pd
import os
import warnings
import pyodbc
# warnings.filterwarnings('ignore')

# Connection Definition

# Env query for connection string
CONNECTION_STRING = os.environ.get('AZURE_SQL_CONNECTIONSTRING')

# Check Connection & Config

try:
    AZD_connection = pyodbc.connect(CONNECTION_STRING)
    # AZD_cursor = AZD_connection.cursor()
    # AZD_connection.getinfo()
    print(AZD_connection.getinfo(pyodbc.SQL_DATABASE_NAME))
    print(AZD_connection.getinfo(pyodbc.SQL_DBMS_NAME))
    print(AZD_connection.getinfo(pyodbc.SQL_DBMS_VER))
    AZD_connection.close()

except Exception as e:
    print("Error while connecting to Azure SQL", e)


# define query execution to return df
def search(query:str) -> pd.DataFrame:
    connection = pyodbc.connect(CONNECTION_STRING)
    cursor = connection.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    df = pd.DataFrame(data)
    connection.close()
    return df


if __name__ == "__main__":
    # remember to change
    with open(r"SQL\SQL_Queries.sql", 'r') as file:
        sql_script = file.read()

    for statement in sql_script.split(';'):
            stmt = statement.strip()
            print(search(stmt))
