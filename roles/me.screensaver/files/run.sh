#!/bin/bash

discover_dbus() {
# Remember to run this script using the command "source ./filename.sh"

# Search these processes for the session variable 
# (they are run as the current user and have the DBUS session variable set)
compatiblePrograms=( nautilus kdeinit kded4 pulseaudio trackerd )

# Attempt to get a program pid
for index in ${compatiblePrograms[@]}; do
    PID=$(pidof -s ${index})
    if [[ "${PID}" != "" ]]; then
        break
    fi
done
if [[ "${PID}" == "" ]]; then
    echo "Could not detect active login session"
fi

QUERY_ENVIRON="$(tr '\0' '\n' < /proc/${PID}/environ | grep "DBUS_SESSION_BUS_ADDRESS" | cut -d "=" -f 2-)"
if [[ "${QUERY_ENVIRON}" != "" ]]; then
    export DBUS_SESSION_BUS_ADDRESS="${QUERY_ENVIRON}"
    echo "Connected to session:"
    echo "DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS}"
else
    echo "Could not find dbus session ID in user environment."
fi

}

export DISPLAY=:0
discover_dbus unity

gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend 'false'
gsettings set org.gnome.desktop.screensaver lock-enabled 'false'
