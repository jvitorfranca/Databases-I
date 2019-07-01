import sqlite3

from sqlite3 import Error
from utilities import create_connection
from utilities import create_table
from utilities import parse_sql_file


if __name__ == "__main__":

    db_file = '/home/jvitorfranca/Documents/cadeiras/bd/database.db'

    script = parse_sql_file()

    conn = create_connection(db_file)

    for i, command in enumerate(script.split(';')):
        create_table(conn, command)
