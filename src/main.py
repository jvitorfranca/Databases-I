import sqlite3

from sqlite3 import Error
from utilities import create_connection
from utilities import create_table
from utilities import parse_sql_file


if __name__ == "__main__":

    db_file = '/home/jvitorfranca/Documents/cadeiras/bd/Databases-I/database.db'

    script = parse_sql_file(path='/home/jvitorfranca/Documents/cadeiras/bd/Databases-I/script.sql')

    conn = create_connection(db_file)

    '''
    for i, command in enumerate(script.split(';')):
        create_table(conn, command)
    '''