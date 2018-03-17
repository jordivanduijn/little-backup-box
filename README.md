# Little Backup Box

Bash shell scripts that transform a Raspberry Pi (or any single-board computer running a Debian-based Linux distribution) into an inexpensive, fully-automatic, pocketable photo backup and streaming device.

<img src="https://i.imgur.com/OQ3AQfM.jpg" alt="" width="375"/>

## Installation

First of all, make sure that your Raspberry Pi is connected to the internet.

Run the following command on the Raspberry Pi:

    curl -sSL https://goo.gl/btmpKd | bash

When prompted, select the desired backup mode:

1. **Storage Card Backup** Back up files from a storage card connected via a card reader to an external storage device)
2. **Camera Backup** Back up files from the connected camera to the */home/pi/[CAMERA MODEL]* directory on Raspberry Pi. **Important** If you choose to use this mode make sure that the camera is set to the MTP USB connection mode.

Reboot the Raspberry Pi.

## Alternative Camera Backup

Some cameras (notably Sony Alpha models) may not work with the default direct file transfer script. In this case, run the `crontab -e` command and comment the following lines by adding *#* to the beginning of each line:

    #@reboot sudo /home/pi/little-backup-box/backup.sh > /home/pi/backup.log
	#@reboot sudo /home/pi/little-backup-box/gphoto-backup.sh > /home/pi/gphoto-backup.log

Uncomment then the following line by removing *#*:

    #@reboot sudo /home/pi/little-backup-box/gphoto-backup-alt.sh > /home/pi/gphoto-backup-alt.log

## Usage

1. Boot the Raspberry Pi
2. Plug in the backup storage device (or camera, if you configured Little Backup Box as described above)
3. Plug in the card reader and wait till the Raspberry Pi shuts down

To geocorrelate the backed up photos, place a GPX file in the root of the storage device before plugging it into the Raspberry Pi.

**Note:** To differentiate between different storage cards, the backup script creates a datetime-based *.id* file in the root of each storage card. The name of the *.id* file is also used as the destination backup folder on the storage device.

With the camera backup mode enabled, follow this steps:

1. Boot the Raspberry Pi
2. Connect the camera and turn it on and wait till the Raspberry Pi shuts down

Note that the camera backup mode doesn't support geocorrelation.

## Problems?

Please report bugs and issues in the [Issues](https://github.com/dmpop/little-backup-box/issues) section.

## Contribute

If you've found a bug or have a suggestion for improvement, open an issue in the [Issues](https://github.com/dmpop/little-backup-box/issues) section.

To add a new feature or fix issues yourself, follow the following steps.

1. Fork the project's repository repository
2. Create a feature branch using the `git checkout -b new-feature` command
3. Add your new feature or fix bugs and run the `git commit -am 'Add a new feature'` command to commit changes
4. Push changes using the `git push origin new-feature` command
5. Submit a pull request

## Author

Dmitri Popov [dmpop@linux.com](mailto:dmpop@linux.com)

## License

The [GNU General Public License version 3](http://www.gnu.org/licenses/gpl-3.0.en.html)

## Linux Photography

Little Backup Box is a part of a streamlined and automated Linux-based photographic workflow described in the [Linux Photography](https://gumroad.com/l/linux-photography) book. The book provides step-by-step instructions on building a Raspberry Pi-based photo backup device running the Little Backup Box script. Get your copy at [Google Play Store](https://play.google.com/store/books/details/Dmitri_Popov_Linux_Photography?id=cO70CwAAQBAJ) or [Gumroad](https://gumroad.com/l/linux-photography).

<img src="https://scribblesandsnaps.files.wordpress.com/2016/07/linux-photography-6.jpg" width="200"/>
