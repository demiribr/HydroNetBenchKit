#!/usr/bin/python
# -*- coding: utf-8 -*-
"""Calculate statistics from result benchmarks"""

__author__      = "Robert Szczepanek"
__email__       = "robert@szczepanek.pl"


import pandas as pd
import numpy as np


RESULT_FOLDER = '../data/benchmark/'
RESULT_FOLDER_ITEMS = '../data/benchmark/result/'
RESULT_FILE = 'results-query.txt'


def stat():

    print '-' * 10
    df = pd.read_csv(RESULT_FOLDER + RESULT_FILE, usecols=[1, 2, 3])
    df.columns = ['mo', 'node', 'time']

    x = df['time'].groupby(df['mo'])
    print 'max time'
    print x.max()
    print 'average time'
    print x.mean()
    print 'standard deviation'
    print x.std()

    return




if __name__ == "__main__":
    stat()
