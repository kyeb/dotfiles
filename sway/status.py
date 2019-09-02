#!/usr/bin/python

from datetime import datetime
from psutil import disk_usage, sensors_battery
from psutil._common import bytes2human
from socket import gethostname, gethostbyname
from subprocess import check_output
from sys import stdout
from time import sleep

icons = {
         "charging": " ",
         100: "",
         75: "",
         50: "",
         25: "",
         "empty": ""
        }

def write(data):
    stdout.write('%s\n' % data)
    stdout.flush()

def refresh():
    disk = bytes2human(disk_usage('/').free)

    mem = check_output("/home/kyeb/.config/sway/memory.sh").strip().decode('utf-8')

    try:
        ssid = " " + check_output("iwgetid -r", shell=True).strip().decode('utf-8')
    except Exception:
        ssid = ""

    batteryicons = ""
    if sensors_battery() is not None:
        plugged = sensors_battery().power_plugged 
        battery = int(sensors_battery().percent)
        batteryicons += icons["charging"] if plugged else ""
        batteryicons += icons[(battery // 25) * 25] if battery > 5 else icons["empty"]
    else:
        battery = "?"

    date = datetime.now().strftime('%h %d %A %H:%M')

    output = f"{ssid} |  {mem} |  {disk} | {batteryicons} {battery}% | {date}"
    write(output)

while True:
    refresh()
    sleep(1)

