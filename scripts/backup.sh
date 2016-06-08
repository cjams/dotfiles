#!/usr/bin/bash

sudo rsync -aAXv --delete --info=progress2,stats2 --exclude-from=backup_exclude / /mnt/backup > ./backup.log
