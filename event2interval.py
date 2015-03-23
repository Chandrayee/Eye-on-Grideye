#convert event triggered data to interval data

import datetime
from datetime import datetime
import calendar
import pytz, time
from pytz import timezone
import numpy as np
import collections
import matplotlib
from matplotlib import pyplot as plt
import scipy.io

filename = open("/Users/chandrayeebasu/Documents/CO2basedOCC/groundtruth/GHC4211/testdata.txt",'r')

readdata = filename.readlines()

eastern = timezone('US/Eastern')

#generate time for each date in unixtime format

utime = []
date = []
time = []
readings = []
datenumber = []
timearray = []

newdata = str.split(readdata[0],'\r')



#access = {}
for i in newdata[2:]:
    #print(i)
    temp = str.split(i,'\t')
    if  temp[4]!='':
        xtime = str.split(temp[0],':')
        xdate = str.split(temp[1],'/')
        print [xdate,xtime]
        d = eastern.localize(datetime(2014,int(xdate[0]),int(xdate[1]),int(xtime[0]),int(xtime[1]),0))
        unixtime = calendar.timegm(d.utctimetuple())
        utime.append(unixtime)
        time.append(temp[0])
        date.append(temp[1])
        datenumber.append(int(xdate[0]+xdate[1]))
        readings.append(float(temp[4]))

access = dict(zip(utime,readings))
d = collections.OrderedDict(sorted(access.items()))


dateset = list(set(datenumber))

for i in dateset:
    i = str(i)
    mon = int(i[0])
    day = int(i[1:])
    #print [mon,day]
    for j in np.arange(0,24):
        for k in np.arange(0,60):
            #print [j,k]
            dtime = eastern.localize(datetime(2014,mon,day,j,k,0))
            ugen = calendar.timegm(dtime.utctimetuple())
            timearray.append(ugen)

#vals = d.values()
#keys = d.keys()

#pick indices from timearray corresponding to keys

ind = []

for i in utime:
    ind.append(timearray.index(i))

data = 0*np.arange(0,len(timearray))

data[ind]=readings

for i in range(len(ind)-1):
    print [ind[i+1]-ind[i],readings[i]]
    data[ind[i]:ind[i+1]] = readings[i]

#save = open('/Users/chandrayeebasu/Documents/CO2basedOCC/groundtruth/GHC4211/occ4211_unixtime.txt','a')

scipy.io.savemat('4211occ_test',mdict = {'occ4211_utime_test':timearray,'occ4211_test':data})


plt.plot(data)
plt.show()

print len(data)   





   


    

    
    
    
    

