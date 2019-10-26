#!/usr/bin/python

from datetime import datetime
from psutil import disk_usage, sensors_battery, cpu_percent
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
         0: "",
         "empty": ""
        }

def write(data):
    stdout.write('%s\n' % data)
    stdout.flush()

def refresh():
    cpu = str(cpu_percent()).rjust(4)

    mem = check_output("/home/kyeb/.config/sway/scripts/memory.sh").strip().decode('utf-8')

    disk = bytes2human(disk_usage('/').free)

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

    output = f"{ssid} |  {cpu} |  {mem} |  {disk} | {batteryicons} {battery}% | {date}"
    write(output)

while True:
    try:
        refresh()
    except Exception as e:
        with open("/tmp/status_log", "w+") as f:
            f.write(str(e) + "\n")
        raise e
    sleep(1)

