#!/bin/bash
#####################################
#####           BACKUP          #####
#####        RAFAEL ALVES       #####
#####################################

# DEFININDO VARIAVEIS
# Origens de Backup
ORIGEM1="/dados"
# ORIGEM2="/mnt/hd-2"

# Destino de backups (Um HD Externo)
DESTINO1="/mnt/disco1"
DESTINO2="/mnt/disco2"

# Caminho dos logs e nome por data
LOG="/root/log/backup_logs/`date +%d-%m-%y | tr / -`.log"

# Logs de leitura iniciais
echo "" >> $LOG
echo "" >> $LOG
echo "######################################" >> $LOG
echo "###           BACKUP               ###" >> $LOG
echo "######## BACKUP AUTOMATIZADO #########" >> $LOG
echo "######################################" >> $LOG
echo "" >> $LOG
echo "Iniciando script................[OK]" >> $LOG
echo "Limpando logs antigos ..........[OK]" >> $LOG

# Procura e remove logs com mais de 5 dias
find /root/log/backup_logs -type f -mtime +5 -exec rm -rf {} ";"

# Define o /dev do HD Externo (Para pegar o blkid do device use blkid como root no terminal).
DEVICE1=`/sbin/blkid |grep  56005CC1005CA9AF | awk -F: '{print $1}'`
DEVICE2=`/sbin/blkid |grep  985873755873514C | awk -F: '{print $1}'`

# Desmonta e monta o HD Externo
umount -l $DEVICE1
umount -l $DEVICE2

# Verifica se o HD esta montado ou nao
if mount -t ntfs-3g $DEVICE1 $DESTINO1
then
    {
        #se estiver montado, inicia a sincronia do device.
        echo "" >> $LOG
        echo "HD EXTERNO OK: Iniciando a sincronia de discos.." >> $LOG
        rsync -avx $ORIGEM2 $DESTINO1
        echo "" >> $LOG
        echo "BACKUP REALIZADO COM SUCESSO!" >> $LOG
    }
elif mount -t ntfs-3g $DEVICE2 $DESTINO2
then
        {
        # Se estiver montado, inicia a sincronia do device.
        echo "" >> $LOG
        echo "HD EXTERNO OK: Iniciando a sincronia de discos..." >> $LOG
        rsync -avx  $ORIGEM1 $DESTINO2 >> $LOG
        echo "" >> $LOG
        echo "BACKUP REALIZADO COM SUCESSO!" >> $LOG
        }
else
  {
    echo "" >> $LOG
    echo "ERRO AO MONTAR O HD EXTERNO: BACKUP CANCELADO!" >> $LOG
  }
fi

# Desmonta o HD ao finalizar
echo "Fim do Relatorio." >> $LOG
umount -l $DEVICE1
umount -l $DEVICE2