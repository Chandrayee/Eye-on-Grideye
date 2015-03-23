#converts date and time format to unixtime

import datetime
from datetime import datetime
import calendar
import pytz, time
from pytz import timezone
import scipy.io

eastern = timezone('US/Eastern')

utime = []
data = []


getfile = open("/Users/chandrayeebasu/Documents/CO2basedOCC/groundtruth/GHC4211/co24211_test.txt")
getdata = getfile.readlines()

newdata = str.split(getdata[0],'\r')
#print newdata

savedata = open("/Users/chandrayeebasu/Documents/CO2basedOCC/groundtruth/GHC4211/co24211_unixtime_test.txt",'a')

for i in newdata[1:]:
    x = str.split(i,'\t')
    xdatetime = str.split(x[0])
    xdate = str.split(xdatetime[0],'/')
    xtime = str.split(xdatetime[1],':')
    xdata = x[1]

    d = eastern.localize(datetime(2014,int(xdate[1]),int(xdate[0]),int(xtime[0]),int(xtime[1]),0))
    unixtime = calendar.timegm(d.utctimetuple())
    utime.append(unixtime)
    data.append(float(xdata))

scipy.io.savemat('4211co2_test',mdict = {'co24211_utime_test':utime,'co24211_test': data})

savedata.close()

print len(newdata[1:])
    
