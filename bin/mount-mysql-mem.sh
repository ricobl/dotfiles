#!/bin/bash

MEM_DIR="/mnt/ramfs"
MEM_MYSQL_DIR="$MEM_DIR/mysql"
FS_TYPE="tmpfs"
MOUNT_SIZE="100m"

MYSQL_DIR="/var/lib/mysql"

sudo service mysql stop

# Cria mount em memória
[ ! -d $MEM_DIR ] && sudo mkdir $MEM_DIR
[ ! `df $MEM_DIR | grep $FS_TYPE | awk '{print $6}'` ] && sudo mount -t "$FS_TYPE" -o size="$MOUNT_SIZE" "$FS_TYPE" "$MEM_DIR"

# Copia banco pra memória
sudo cp -R $MYSQL_DIR $MEM_DIR

# Corrige permissões
sudo chown -R mysql:mysql $MEM_MYSQL_DIR

# Reconfigura
#sudo vim /etc/mysql/my.cnf
#sudo vim /etc/apparmor.d/usr.sbin.mysqld

# Atualiza apparmor e inicia mysql
#sudo /etc/init.d/apparmor restart
sudo service mysql start

