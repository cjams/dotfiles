#!/usr/bin/bash

sync
echo 1 > /sys/power/pm_trace
echo mem > /sys/power/state
