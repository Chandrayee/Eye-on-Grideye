import sqlite3
from datetime import datetime
import scipy.io
import numpy as np


connection = sqlite3.connect('grideye.db')
cursor = connection.cursor()


#cursor.execute('''CREATE TABLE grideye (unixtime REAL, temp TEXT, rownum TEXT, PRIMARY KEY(unixtime))''')

file = open('grideye.mat')
cursor.execute('SELECT unixtime, rownum, temp FROM grideye')# WHERE unixtime>=1400058000')
dat = cursor.fetchall()

savedat = []
utime = []
rownum = []

for i in dat:
    tempstr = i[2][11:34]
    if i[0]>=1417197600 and len(i[2]) == 39:
            print [i[2],len(i[2])]
                                
            tempstr = str(i[2][11:34])
            print(tempstr)
            
            utime.append(i[0])
            rownum.append(int(i[1]))
            tempstrnew = str.split(tempstr,',')
            savedat.append([int(j,16) for j in tempstrnew])
            
            
savedat = np.vstack((np.array(savedat)))
print(savedat)
scipy.io.savemat('grideye.mat', mdict={'unixtime': np.vstack((np.array(utime))), 'data':savedat, 'rownum':rownum})
        
print('done')

cursor.commit()
cursor.close()

