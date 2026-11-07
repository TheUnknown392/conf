#!/bin/sh
i3lock --nofork &
sleep 3
systemctl suspend
wait
