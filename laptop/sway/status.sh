#!/bin/sh

# The Sway configuration file in ~/.config/sway/config calls this script.
# example confing line in a bar block:
#   status_command /path/to/status.sh
# You should see changes to the status bar after saving this script.
# If not restart sway.
# 
# To show emojis in the bar noto-fonts-emoji is required:
#   pacman -S noto-fonts-emoji

while true; do
  # sound 🔇 🔈🔉🔊 🎧 🎶 🎵 🎤
  sound_raw=$(wpctl get-volume @DEFAULT_SINK@)
  sound_volume=${sound_raw:8:4}
  sound_volume=$(echo $sound_volume | tr -d "." | sed s/100/0100/)
  sound_volume=${sound_volume:1}
  sound_icon="🔈"
  if [ ${#sound_raw} -eq 20 ]; then
    sound_icon="🔇"
  elif [ ${sound_volume} -gt 30 ]; then
    sound_icon="🔉"
  elif [ ${sound_volume} -gt 70 ]; then
    sound_icon="🔊"
  fi
  sound_formatted="${sound_icon} ${sound_volume}"

  # uptime 💎
  # uptime_formatted=$(uptime | cut -d ',' -f1  | cut -d ' ' -f4,5)
  
  # linux version 🐧
  # linux_version=$(uname -r | cut -d '-' -f1)

  # brightness 🔅🔆
  brightness=$(brightnessctl g)
  brightness_percentage=$(( 100 * brightness / 255 ))
  brightness_icon="🔅"
  if [ ${brightness_percentage} -gt 50 ]; then
    brightness_icon="🔆"
  fi
  brightness_formatted="${brightness_icon} ${brightness_percentage}"

  # temperature 🌡🔥 ❄
  # thermal zones
  # cat /sys/class/thermal/thermal_zone{0,1}/temp
  # eg 39000, 40000, 38000
  # 1 von den muss cpu und das andere gpu sein
  temp0_raw=$(cat /sys/class/thermal/thermal_zone0/temp)
  temp1_raw=$(cat /sys/class/thermal/thermal_zone1/temp)
  temp0=${temp0_raw:0:2}
  temp1=${temp1_raw:0:2}
  temp_formatted="🔥${temp0}C ${temp1}C"

  # inet 🌐💻📡🔗🪢
  inet_icon="🌐"
  inet_dev_icon="💻"
  inet=$(nmcli -g NAME connection show | head -n 1)
  inet_ip="127.0.0.1"
  if [ "$inet" = "lo" ]; then
    inet="localhost"
  elif [ "$inet" = "Wired connection 1" ]; then
    inet="wired"
    inet_dev_icon="🪢"
    inet_ip=$(ip -f inet -o addr show enp2s0 | cut -d\  -f 7 | cut -d/ -f 1)
  else
    inet_dev_icon="📡"
    inet_ip=$(ip -f inet -o addr show wlp4s0 | cut -d\  -f 7 | cut -d/ -f 1)
  fi
  inet_formatted="${inet_icon} ${inet} ${inet_dev_icon} ${inet_ip}"
  
  # battery 🔋🪫🔌⚡
  battery_status=$(cat /sys/class/power_supply/BAT0/status)
  battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
  battery_remaining=$(acpi -b | awk -F'[ :]' '{ print $6":"$7 }')
  battery_icon="🔋"
  if [ ${battery_capacity} -lt 15 ]; then
    battery_icon="🪫"
  fi
  battery_plugged=""
  if [ "$battery_status" = "Charging" -o "$battery_status" = "Full" ]; then
    battery_plugged="🔌"
  fi
  battery_formatted="${battery_icon} ${battery_plugged} ${battery_capacity}% ${battery_remaining}"

  # date time 🕑⌚️
  date_formatted="🕑 $(date "+%a %d. %h %H:%M")"

  # keyboard layout
  keyboard_layout=$(swaymsg -t get_inputs | jq '.[0].xkb_active_layout_index') # 0->US,1->GER
  if [ ${keyboard_layout} -eq 0 ]; then
    kb_icon="🇺🇸"
  else
    kb_icon="🇩🇪"
  fi


  echo $kb_icon $temp_formatted $sound_formatted $brightness_formatted $inet_formatted $battery_formatted $date_formatted
  sleep 1
done

#  💡 📁 ⭐ ✅ 🏹 🪓 🛡 🔧 🔒
# more emojis on https://www.webfx.com/tools/emoji-cheat-sheet/
:
