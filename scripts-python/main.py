#!/usr/bin/python3
#--------------------------------|
# Criado por: RAFAEL A. L. ALVES |
#--------------------------------|

#Import
import time
import subprocess
#--------------------------------------------------------------------------------------------------
date = time.strftime("%d-%m-%Y--%H-%M-%S")

# Criação do Log de Backup
def createLog():
    logfile = '%s-backup.txt' % date
    pathLog = '/var/log/backupLog/%s' % logfile
    return pathLog

LOG = createLog()

def registerLog(startTime, BKP, LOG):
        date = (time.strftime('%d-%m-%Y'))
        r = open(LOG,"w+")
        log_message = 'LOG REGISTER\nDATE: %s\nSTART TIME:%s\nBKP FILE: %s\n' % (date,startTime,BKP)
        r.write(log_message)
        r.close()
# ------------------------------------------------------------------------------------------------
# Caminhos
MOUNT = 'mount -t cifs -o username=USER,password=PASSWORD //192.168.0.100/dados  /mnt/disco1/'
BKP = '/usr/bin/rsync -avx  /mnt/disco1 /backup'
UMOUNT = 'umount /mnt/disco1'
ERROR = 'Não foi Posiivel Fazer o Backup'
#-------------------------------------------------------------------------------------------------
# Função do Backup 
def backupFull():
        startTime =  time.strftime("%H:%M:%S")
        log = ' >> %s' % LOG
        if subprocess.call(MOUNT, shell=True):
            subprocess.call(BKP + log, shell=True)
            registerLog(startTime, BKP, LOG)
        else:
            registerLog(startTime, ERROR, LOG )
        subprocess.call(UMOUNT, shell=True)
#--------------------------------------------------------------------------------------------------
backupFull() 
