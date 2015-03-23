#extract grideye data from text files experimentwise

import sqlite3
from datetime import datetime
import scipy.io
import numpy as np

getfile = '4people_3_11.txt'


f = open(getfile).readlines()

utime = []
rownum = []
savedat = []

for i in f:
    #print i
    dat = str.split(i)
    utime.append(float(dat[0][2:-2]))
    #print float(dat[0][2:-2])
    #print dat[2][2:-3]
    rownum.append(int(dat[2][2:-3]))
    tempstr = str(dat[1][13:-11])
    tempstrnew = str.split(tempstr,',')
    savedat.append([int(j,16) for j in tempstrnew])
    
savedat = np.vstack((np.array(savedat)))
#print(savedat)
scipy.io.savemat('grideye3_11_4person.mat', mdict={'unixtime': np.vstack((np.array(utime))), 'data':savedat, 'rownum':rownum})
