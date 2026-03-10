#!/bin/zsh
OPTS=(moodle portal studip vpn spluseins cmo)

RESULT=`echo $OPTS | tr " " "\n" | wmenu -p 'ostfalia'`

case $RESULT in
    moodle|portal|studip|cmo)
        firefox --new-tab https://${RESULT}.ostfalia.de
        ;;
    vpn)
        PW=`zenity --password`
        nmcli connection up sonia4-linux 
        ;;
    spluseins)
        firefox --new-tab https://spluseins.de/
        ;;
    *) ;;
esac
