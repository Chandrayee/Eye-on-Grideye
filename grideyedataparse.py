#read from Grideye usb port and save data in sqlite3 database

#create sqlite3 database
'''CREATING SOME TABLES:
#    >>> create_tables('tablename')
'''
'''
Grideye table has two columns: unixtime stamp and a byte string
Values in the Grid eye Tables you can Request:
               unixtime REAL, temperature array BLOB
'''
import datetime
import numpy as np
import sqlite3
from sqlite3 import dbapi2 as sqlite3
from numpy import vstack
import scipy as sp
from scipy import stats
from datetime import datetime,date
import time
from time import mktime, localtime, gmtime, strftime, time
import serial
import pytz
from pytz import timezone
import math

########################################
### CREATE CONNECTION WITH DATABASE ####
########################################


connection = sqlite3.connect('grideye.db')
cursor = connection.cursor()
#cursor.execute('''CREATE TABLE grideye (unixtime REAL, temp TEXT, rownum TEXT, PRIMARY KEY(unixtime))''')
#cursor.close()
#use BLOB if TEXT doesn't work

########################################
### OPEN SERIAL PORT AND SAVE DATA ####
########################################

port='/dev/tty.usbserial-AE00BUKF'

ser = serial.Serial(port, 115200, timeout=2000, xonxoff=False, rtscts=False, dsrdtr=False) #Tried with and without the last 3 parameters, and also at 1Mbps, same happens.
#ser.close()
#ser.open()

#ser.timeout = 2000
#ser.flushInput()
#ser.flushOutput()


newdata = open('data.txt','a')

t = 0

data = []

while t<=664:
    data_raw = ser.readline()
    grideyenum = data_raw[9:10].decode(encoding = 'UTF-8')
    data_str = data_raw.decode(encoding = 'UTF-8')
    #cur_time = datetime.now().timestamp()
    dt = datetime.now().strftime("%f"), time()
    cur_time = '%.3f' % round(dt[1],3)
    newdata.write(str(cur_time) + '\t'+ data_str+'\n')
    print([cur_time,data_str,grideyenum])
    cursor.execute('INSERT INTO grideye VALUES (?,?,?)',[cur_time,data_str,grideyenum])
    t+=1
    if t == 664:
        connection.commit()
        connection.commit()
        cursor.close()
        newdata.close()
        print('done')
        ser.close()
        #t =0
    
#connection.commit()
#cursor.close()
#newdata.close()
#print('done')
#ser.close()
