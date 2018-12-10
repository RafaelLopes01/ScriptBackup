##############################################
#                                            #
#  Sistema de backup em HD Externo           #
#  Criado por: Rafael Alves                  #
#                                            #
##############################################

#BACKUP EM HD EXTERNO NO FORMATO NTFS

#Montando a Unidade
mount -t ntfs-3g /dev/sdc1 /disco1

#Copiando Arquivos Mantendo os Arquivos Apagados do Servidor.
/usr/bin/rsync -avx /dados/ /disco1/backup/
#Copiando Arquivos e Excluindo Arquivos Apagados do Servidor.
usr/bin/rsync -avx --delete /dados/ /disco1/backup/


#Desmontando a Unidade
umount /disco1

