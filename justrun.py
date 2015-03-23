
import serial
port='/dev/tty.usbserial-AE00BUKF'
ser = serial.Serial(port, 115200, timeout=.2)
ser.close()
