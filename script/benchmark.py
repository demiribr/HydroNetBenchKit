#!/usr/bin/python
# -*- coding: utf-8 -*-
"""Run benchmark queries for network models on given nodes"""

__author__      = "Robert Szczepanek"
__email__       = "robert@szczepanek.pl"


import psycopg2
import time
import os
import datetime

DATA_FOLDER = '../data/'
DATA_FILE = 'test-watersheds.txt'
SQL_FOLDER = '../sql/'
SQL_TOOLS_FOLDER = '../sql/tools/'
DB_NAME = 'dbname=db-opty'
RESULT_FOLDER = '../data/benchmark/'
RESULT_FOLDER_ITEMS = '../data/benchmark/result/'
RESULT_FILE = 'results-query.txt'
MISSING = 'MISSING'     # missing file with query


def read_watershed():
    """ Read list of watershed nodes to be tested; return list
    """

    with open(DATA_FOLDER + DATA_FILE, "r") as myfile:
        data = myfile.read().splitlines()

    # remove header if exist
    try:
        x = int(data[0])
    except ValueError:
        data = data[1:]

    result = [row.split(',') for row in data]

    return result


def read_sql(f_name, param=None):
    """ Read SQL query from file
    """

    try:
        with open(SQL_FOLDER + f_name, "r") as myfile:
            data = myfile.read()
        data1 = data.split('\n')
        data2 = data1[2:]       # skip 2 lines of comments
        data3 = ' '.join(data2)
        if param:
            result = data3.format(*param)
        else:
            result = data3
    except IOError:
        result = MISSING

    return result


def read_sql_tools(f_name):
    """ Read SQL queries from file and return list without comments.
    """

    try:
        with open(SQL_TOOLS_FOLDER + f_name, "r") as myfile:
            data = myfile.readlines()
    except IOError:
        result = MISSING

    result = []
    for line in data[1:]:   # assume first line is comment; also BOM issue
        if line[:2] == '--':    # comment
            pass
        elif len(line) < 3:     # empty
            pass
        else:
            result.append(line)

    return result


def run_query(sql, sql_name, node, invasive):
    """ Run SQL query;   return execution time in seconds

    non invasive returns/saves results
    invasive does not
    """

    dbconn = psycopg2.connect(DB_NAME)
    cursor = dbconn.cursor()

    start = datetime.datetime.now()
    cursor.execute(sql)
    end  = datetime.datetime.now()
    items = cursor.rowcount

    if not invasive:
        with open('{}{}-{}.txt'.format(RESULT_FOLDER_ITEMS, sql_name,
                  node[0]), "w") as res_file:
            for row in cursor.fetchall():
                res_file.write(str(row[0]) + '\n')

    cursor.close()
    dbconn.close()

    q_time = end - start
    q_time = max(q_time.total_seconds(), 0.001)

    return (q_time, items)


def write_bench(sql_name, node, bench_time=None, items=None):
    """ Append benchmark results to file
    """

    time_stamp = time.strftime("%Y-%m-%d %H:%M:%S")
    row = '{},{},'.format(time_stamp, sql_name)

    if bench_time is None:
        row += MISSING + '\n'
    else:
        row += '{},{:.3f},{}\n'.format(node, bench_time, items)
    with open('{}{}'.format(RESULT_FOLDER, RESULT_FILE), "a") as res_file:
        res_file.write(row)


def drop_table(name):
    """ Drop table
    """

    dbconn = psycopg2.connect(DB_NAME)
    dbconn.autocommit = True
    cursor = dbconn.cursor()
    sql = "DROP TABLE {};".format(name)
    try:
        cursor.execute(sql)
    except psycopg2.ProgrammingError:
        print 'Already dropped.'
    cursor.close()
    dbconn.close()


def restore_table(model):
    """ Restore original table version after ADD, DEL, MOVE
    """

    name = model.lower()

    drop_table(name)

    dbconn = psycopg2.connect(DB_NAME)
    dbconn.autocommit = True
    cursor = dbconn.cursor()

    file_name = 'copy-table-{}.sql'.format(name)
    sql = read_sql_tools(file_name)
    for sql1 in sql:
        cursor.execute(sql1)

    sql = "VACUUM ANALYZE {}".format(name)
    cursor.execute(sql)

    cursor.close()
    dbconn.close()
    #print 'Table for model {} restored.'.format(model)


def bench_all(append=False):
    """ Run benchmark for all methods and watershes

    append - append results to file or create new file
    """

    nodes = read_watershed()
    models = ('AL', 'NS', 'PE', 'SN')
    operations = ('ADD', 'DEL', 'MOVE', 'QPARE', 'QCHIL', 'QPATH', 'QTREE')

    # runtime sets
    models = (models[1],)   # only NS
    #operations = operations[3:]     # only queries, not operations
    operations = (operations[3],)      # for testing single operation

    if not append:
        # write header to results file
        with open('{}{}'.format(RESULT_FOLDER, RESULT_FILE), "w") as res_file:
            res_file.write('date_time,model-operation,node,'
                           'sql_time,returned_items\n')

    # create RESULT_FOLDER_ITEMS if doesn't exist
    if not os.path.exists(RESULT_FOLDER_ITEMS):
        os.makedirs(RESULT_FOLDER_ITEMS)

    for model in models:
        for operation in operations:
            print model, operation,
            if operation[0] == "Q":  # noninvasive operations start with "Q"
                invasive = False
            else:
                invasive = True

            sql_name = '{}-{}'.format(model, operation)
            sql = read_sql(sql_name + '-param.sql', [0, 0, 0])

            if sql != MISSING:
                for node in nodes:
                    if operation == 'ADD':
                        node_q = (node[1], node[0])
                    elif operation == 'MOVE':
                        node_q = (node[0], node[2])
                    else:
                        node_q = (node[0], node[0], node[0])

                    sql = read_sql(sql_name + '-param.sql', node_q)
                    #print sql

                    bench_time, items = run_query(sql, sql_name,
                                                  node_q, invasive)

                    node_q = node_q[0]      # only for network queries
                    write_bench(sql_name, node_q, bench_time, items)

                    print '.',
                    if invasive:
                        restore_table(model)
            else:
                write_bench(sql_name, 0)
            print '>'


if __name__ == "__main__":

    bench_all(True)
