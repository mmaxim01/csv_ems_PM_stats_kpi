#!/bin/bash -
set -x
#title          :csv_processing.sh
#description
#author         :Marian Maxim
#date           :2019-09-20
#version: 1     :4.4.20(1)-release
version=$1
customer=$2
NetworkElementList=/srv/customers/hotstorage/configs/$version/$customer/NetworkElementList.cfg
filetountar=$(ls -lrtd /srv/customers/hotstorage/customers/$version/$customer/tarred/pm/* | grep -v grep | grep -v mail | tail -1 | awk '{print $9}')

find /srv/customers/hotstorage/customers/$version/$customer/pm/ -type f -name "*.csv" -mtime +22 -delete
cd /srv/customers/hotstorage/customers/$version/$customer/tarred/pm/
sync -a /srv/customers/hotstorage/customers/$version/$customer/tarred/pm/ /srv/customers/coldstorage/$version/$customer/tars/
tar  -xvf $filetountar
chmod -Rf 7777 /srv/customers/hotstorage/customers/$version/$customer/ && rm -Rf $filetountar
rsync -a /srv/customers/hotstorage/customers/$version/$customer/tarred/pm/ /srv/customers/hotstorage/customers/$version/$customer/csvfolders

