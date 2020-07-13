#!/bin/bash

function msg_me {
    pid=$1
    msg1=$2
    msg2=$3
    telegram-send "$msg1"
    while [ -d /proc/$pid ] ; do
        sleep 1
    done
    telegram-send "$msg2"
}

function timestamp {
    date +%Y%m%d_%H%M%S
}
