#!/bin/bash
#
# [Ansible Role]
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705 & Deiteq & FlickerRate
# URL:      https://plexguide.com
#
# PlexGuide Copyright (C) 2018 PlexGuide.com
# Licensed under GNU General Public License v3.0 GPL-3 (in short)
#
#   You may copy, distribute and modify the software as long as you track
#   changes/dates in source files. Any modifications to our software
#   including (via compiler) GPL-licensed code must also be made available
#   under the GPL along with build & install instructions.
#
#################################################################################

export NCURSES_NO_UTF8_ACS=1
############# User Confirms They Understand
dialog --title "Very Important" --msgbox "\nWhen PlexDrive finishes the initial scan, make sure to reboot the server! If using PD5 and then says 'Opening Cache' - go ahead and reboot the server!" 0 0


############ Menu
HEIGHT=12
WIDTH=45
CHOICE_HEIGHT=5
BACKTITLE="Visit https://PlexGuide.com - Automations Made Simple"
TITLE="PlexDrive for PG"
MENU="Choose one of the following options:"

OPTIONS=(A "PlexDrive4 (Recommended)"
         B "PlexDrive5 "
         C "Remove PlexDrive Tokens"
         Z "Exit")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        A)
            if dialog --stdout --title "PlexDrive 4 Install" \
              --backtitle "Visit https://PlexGuide.com - Automations Made Simple" \
              --yesno "\nDo you want to install PlexDrive4?" 7 50; then
                clear

                    echo "true" > /tmp/alive
                    sudo ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags plexdrive --skip-tags plexd5
                    #read -n 1 -s -r -p "Press any key to continue "
                    loop="true"
                    echo "true" > /tmp/alive
                    #while [ "$loop" = "true" ]
                    #do
                    #    dialog --infobox "Installing." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing.." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing..." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing...." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing....." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing......" 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing......." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing........" 3 22
                    #    sleep 1
                    #    loop=$(cat /tmp/alive)
                    #done &
                mv /tmp/plexdrive-linux-amd64 plexdrive
                mv plexdrive /usr/bin/
                cd /usr/bin/
                chown root:root /usr/bin/plexdrive
                chmod 755 /usr/bin/plexdrive
                systemctl enable plexdrive
                bash -x /opt/plexguide/menus/plexdrive/check4.sh &
                bash -x /opt/plexguide/menus/plexdrive/pd4.sh 2>&1 | tee /opt/appdata/plexguide/plexdrive.info
                loop="false"
            else
                dialog --title "PG Update Status" --msgbox "\nExiting - User Selected No" 0 0
                echo "Type to Restart the Program: sudo plexguide"
                exit 0
            fi

            ;;
        B)
            if dialog --stdout --title "PlexDrive 5 Install" \
              --backtitle "Visit https://PlexGuide.com - Automations Made Simple" \
              --yesno "\nDo you want to Install PlexDrive5?" 7 50; then
                clear

                    echo "true" > /tmp/alive
                    sudo ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags plexdrive --skip-tags plexd4 

                    loop="true"
                    echo "true" > /tmp/alive
                    #while [ "$loop" = "true" ]
                    #do
                    #    dialog --infobox "Installing." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing.." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing..." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing...." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing....." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing......" 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing......." 3 22
                    #    sleep 1
                    #    dialog --infobox "Installing........" 3 22
                    #    sleep 1
                    #    loop=$(cat /tmp/alive)
                    #done &
                mv /tmp/plexdrive-linux-amd64 plexdrive 1>/dev/null 2>&1
                mv plexdrive /usr/bin/ 1>/dev/null 2>&1
                cd /usr/bin/
                chown root:root /usr/bin/plexdrive
                chmod 755 /usr/bin/plexdrive
                systemctl enable plexdrive
                bash -x /opt/plexguide/menus/plexdrive/check4.sh &
                bash -x /opt/plexguide/menus/plexdrive/pd5.sh 2>&1 | tee /opt/appdata/plexguide/plexdrive.info
                loop="false"
            else
                dialog --title "PG Update Status" --msgbox "\nExiting - User Selected No" 0 0
                echo "Type to Restart the Program: sudo plexguide"
                exit 0
            fi
            ;;
        C)
            rm -r /root/.plexdrive 1>/dev/null 2>&1
            rm -r ~/.plexdrive 1>/dev/null 2>&1
            dialog --title "Token Status" --msgbox "\nThe Tokens were Removed" 0 0
            bash /opt/plexguide/menus/plexdrive/main.sh ;;
        Z)
            clear
            exit 0 ;;
esac
