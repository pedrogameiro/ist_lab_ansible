#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    sudo "$0" "$@"
    exit
fi

apt install -y openssh-server
adduser --disabled-password --gecos "" deploy

mkdir ~deploy/.ssh
>> ~deploy/.ssh/authorized_keys echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOI32JIBhE6bDRAQFm5/5VaOgtX4ybONW2Z2J3jBQGjTNMzcFaUqLGJ/oUg4cysbB02o/9y9DgXucg+TltqDOTspHIRTvBnIjY6CNh+GOyWagViB7+0PMbYRhaQ05em1lY8SOcYo9of3aIr2S0HOhGTNPflyqPINpGVtve1uqLxkQk8WuHWlT+6ttkvNwmg+tkqXbCJJOPtE+EbLuRNwuHmsFdQgzBA1spwvrJA1cWZ3Zsnych96P1hjQyJETzIO3eCsswsyCZkJDA5slPalZbOMeqfnE795HgjNhuZvbKTM5FdbVjFYSeX6XL2asIMbM+fHwMkknW8rA2dcVLk2b1 petrucci@t560'
chown deploy: -R ~deploy/.ssh

echo 'deploy ALL=(ALL)NOPASSWD:ALL' > /etc/sudoers.d/deploy
echo 'AllowUsers deploy' >> /etc/ssh/sshd_config
echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config

ifconfig 

