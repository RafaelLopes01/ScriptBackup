##############################################
#                                            #
#  Sistema de backup em HD Interno           #
#  Criado por: Rafael Alves                  #
#                                            #
##############################################

#BACKUP HD INTENO NO FORMATO EXT4

#Montando a Unidade
mount -t ext4 /dev/sdb1 /disco1

#Copiando Arquivos Mantendo os Arquivos Apagados do Servidor.
/usr/bin/rsync -avx /dados/ /disco1/backup/

#Copiando Arquivos e Excluindo Arquivos Apagados do Servidor.
usr/bin/rsync -avx --delete /dados/ /disco1/backup/

#Desmontando a Unidade
umount /disco1

