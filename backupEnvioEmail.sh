#!/bin/bash
############################################
########### SCRIPT BACKUP DADOS  ###########
############################################

# Caminho onde este script foi instalado
MY_PATH="/root/backup"

AGORA=`date +%d-%m-%Y-%H:%M:%S`

ULTIMOFILE="$MY_PATH/bkp-ultimo"

AGORAESTATICO="$AGORA"

LOGBACKUP="/root/backup/backup-dados/"$AGORAESTATICO".txt"

LOG="/root/backup/backup-dados/logs/"$AGORAESTATICO".txt"


# MONTA O PONTO DE MONTAGEM /MNT/DISCO1
mount -t cifs -o  username=USER,password=PASSWORD //192.168.0.100/Dados  /mnt/disco1/

montado=`mount | grep /mnt/disco1`

# VERIFICA SE O DISCO ESTA MONTADO
if [ -z "$montado" ]; then
     mail -s "Relatório de Backup " EMAIL@DOMINIO.com.br <<< "ERRO!! O DISCO NÃO ESTÁ MONTADO!"   
     exit 1
else
#RSYNC
/usr/bin/rsync -avx /sharedfolders/dados/ /mnt/disco1 >>  $LOG

# DESMONTA O PONTO DE MONTAGEM /MNT/DISCO1
umount /mnt/disco1

fi

#ENVIAR EMAIL COM O LOG DO BACKUP
	echo "--------------------------------------------------" >> $LOGBACKUP
        echo "" >> $LOGBACKUP
        echo "RELATÓRIO DE BACKUP" >> $LOGBACKUP
        echo "" >> $LOGBACKUP
	echo "--------------------------------------------------" >> $LOGBACKUP
	echo "" >> $LOGBACKUP
	echo "ESPAÇO EM DISCO" >> $LOGBACKUP
	echo "" >> $LOGBACKUP
        df -h  >> $LOGBACKUP
        echo "" >> $LOGBACKUP
        echo "--------------------------------------------------" >> $LOGBACKUP

        echo "" >> $LOGBACKUP
        echo "ULTIMO ARQUIVO DE BACKUP" >> $LOGBACKUP
        echo "" >> $LOGBACKUP
        tail $LOG  >> $LOGBACKUP
        echo "" >> $LOGBACKUP
        echo "--------------------------------------------------" >> $LOGBACKUP


        echo "" >> $LOGBACKUP
        echo "BACKUP CRIADO COM SUCESSO!" >> $LOGBACKUP
        echo "" >> $LOGBACKUP
        echo "--------------------------------------------------" >> $LOGBACKUP


echo $AGORAESTATICO > $ULTIMOFILE

#ENVIAR EMAIL
mail -s "Relatório de Backup" EMAIL@DOMINIO.com.br < /root/backup/backup-dados/$AGORAESTATICO".txt"
