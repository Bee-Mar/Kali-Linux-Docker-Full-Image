#!/bin/bash

xhost +si:localuser:root > /dev/null 2>&1
docker run -e DISPLAY -v  /tmp/.X11-unix:/tmp/.X11-unix:ro --hostname kali -t -i kalifulldocker_kali /bin/bash
