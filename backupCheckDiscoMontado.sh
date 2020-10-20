############################################
########### SCRIPT BACKUP DADOS  ###########
###########  RAFAEL A. L. ALVES ############
############################################

# MONTA O PONTO DE MONTAGEM /BACKUP
mount -t cifs -o  username=USER,password=PASSWORD //192.168.0.100/Dados  /mnt/disco1/

# VERIFICA O CAMINHO DO DISCO
montado=`mount | grep /mnt/disco1`


# SE A MONTAGEM N TIVER UP , CASO CONTRARIO REALIZA O BACKUP
if [ -z "$montado" ]; then
     exit 1
else
#RSYNC
/usr/bin/rsync -avx /sharedfolders/dados/ /mnt/disco1

# DESMONTA O PONTO DE MONTAGEM /BACKUP
umount /mnt/disco1

fi
# FIM
