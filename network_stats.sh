#!/bin/bash

# Gather CPU information
cpu_info=$(lscpu)
cpu_cores=$(echo "$cpu_info" | grep "^CPU(s):" | awk '{print $2}')
cpu_speed=$(echo "$cpu_info" | grep "^CPU MHz:" | awk '{print $3}')

# Gather memory information
mem_info=$(free -h)
mem_total=$(echo "$mem_info" | grep "Mem:" | awk '{print $2}')

# Gather storage information
storage_info=$(df -H | awk '{ if ($2 ~ /G/) { sum += $2; } else if ($2 ~ /M/) { sum += $2/1024; } } END { print sum "GB" }')
storage_total=$(echo "$storage_info")

# Gather other important statistics
load_average=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}')
network_traffic=$(ifconfig | grep "bytes" | awk '{print $3}' | awk -F':' '{print $2}')

# Gather Public IP, Private IP and Machine name
public_ip=$(curl -s ifconfig.me)
private_ip=$(hostname -I)
machine_name=$(hostname)

# Print the data in a format that can be easily copied and pasted into a spreadsheet
echo "$public_ip,$private_ip,$machine_name,$cpu_cores,$cpu_speed,$mem_total,$storage_total,$load_average,$network_traffic"
