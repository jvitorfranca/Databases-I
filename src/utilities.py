import sqlite3
from sqlite3 import Error


def create_connection(db_file):
    """ Create a database connection to a SQLite database
        :param db_file: Path to database
        :return: Connection
    """
    try:
        conn = sqlite3.connect(db_file)
        return conn
    except Error as e:
        print(e)


def create_table(conn, create_table_sql):
    """ Create a table from the create_table_sql statement
        :param conn: Connection object
        :param create_table_sql: a CREATE TABLE statement
        :return:
    """
    try:
        c = conn.cursor()
        c.execute(create_table_sql)
    except Error as e:
        print(e)

def insert(conn, sql):
    """ Execute a insert statement
        :param conn: Connection object
        :param sql: a INSERT statement
        :return:
    """
    try:
        c = conn.cursor()
        c.execute(sql)
    except Error as e:
        print(e)


def parse_sql_file(path='script.sql'):
    """ Read sql file
        :param path: Path to sql file
        :return: opened file ready to use
    """
    sql_file = open(path, 'r')
    script = sql_file.read()
    sql_file.close()

    return script
