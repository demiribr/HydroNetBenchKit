#!/usr/bin/python
# -*- coding: utf-8 -*-
"""Make figures from result benchmarks"""

__author__      = "Robert Szczepanek"
__email__       = "robert@szczepanek.pl"


import pandas as pd
import seaborn as sns
import numpy as np
import matplotlib.pyplot as plt


RESULT_FOLDER = '../data/benchmark/'
RESULT_FOLDER_ITEMS = '../data/benchmark/result/'
RESULT_FILE = 'results-query.txt'

MODELS = ('AL', 'NS', 'PE', 'SN')
OPS = ('QPARE', 'QCHIL', 'QPATH', 'QTREE')


def mo(operation):

    mo = []
    for m in MODELS:
        mo.append(m + '-' + operation)

    return mo


def plot_op(operation):
    """ Plots operation for all models
    """

    df = pd.read_csv(RESULT_FOLDER + RESULT_FILE, usecols=[1, 2, 3])
    print(df.columns)
    df.columns = ['mo', 'node', 'time']
    #print df.head()

    ele = mo(operation)

    qpare = df[df.mo == ele[0]]
    qpare = qpare.append(df[df.mo == ele[1]])
    qpare = qpare.append(df[df.mo == ele[2]])
    qpare = qpare.append(df[df.mo == ele[3]])

    f, ax = plt.subplots()
    ax.set(yscale="log")

    ax.set_title('Query time')
    sns.set_style("whitegrid")
    sns.boxplot(x='mo', y='time', data=qpare)
    ax.set_xlabel("model-operation")
    ax.set_ylabel("time [s]")

    #sns.plt.show()
    sns.plt.savefig(RESULT_FOLDER + operation + '.png')
    sns.plt.clf()


if __name__ == "__main__":

    for op in OPS:
        plot_op(op)
