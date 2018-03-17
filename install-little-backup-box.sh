#!/usr/bin/env bash

sudo apt update && sudo apt dist-upgrade -y && sudo apt install acl git-core screen rsync exfat-fuse exfat-utils ntfs-3g minidlna gphoto2 libimage-exiftool-perl -y

sudo sed -i 's|'media_dir=/var/lib/minidlna'|'media_dir=/media/storage'|' /etc/minidlna.conf
sudo service minidlna start

sudo mkdir /media/card
sudo mkdir /media/storage
sudo chown -R pi:pi /media/storage
sudo chmod -R 775 /media/storage
sudo setfacl -Rdm g:pi:rw /media/storage

cd
git clone https://github.com/dmpop/little-backup-box.git

PS3='Please choose default backup mode. Choose Done to finish installation.'
options=("Storage Card Backup" "Camera Backup" "Done")
select opt in "${options[@]}"
do
    case $opt in
        "Storage Card Backup")
            crontab -l | { cat; echo "@reboot sudo /home/pi/little-backup-box/backup.sh > /home/pi/little-backup-box.log"; } | crontab
	    crontab -l | { cat; echo "#@reboot sudo /home/pi/little-backup-box/gphoto-backup.sh > /home/pi/gphoto-backup.log"; } | crontab
	    crontab -l | { cat; echo "#@reboot sudo /home/pi/little-backup-box/gphoto-backup-alt.sh > /home/pi/gphoto-backup-alt.log"; } | crontab
            echo "Choose Done to finish the installation"
            ;;
        "Camera Backup")
            crontab -l | { cat; echo "#@reboot sudo /home/pi/little-backup-box/backup.sh > /home/pi/little-backup-box.log"; } | crontab
	    crontab -l | { cat; echo "@reboot sudo /home/pi/little-backup-box/gphoto-backup.sh > /home/pi/gphoto-backup.log"; } | crontab
	    crontab -l | { cat; echo "#@reboot sudo /home/pi/little-backup-box/gphoto-backup-alt.sh > /home/pi/gphoto-backup-alt.log"; } | crontab
            echo "Choose Done to finish the installation"
            ;;
         "Done")
	    echo "------------------------"
            echo "All done! Please reboot."
            echo "------------------------"
            break
            ;;
        *) echo invalid option;;
    esac
done
