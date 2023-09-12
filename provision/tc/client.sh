#!/bin/bash

# Define the desired bandwidth limit in Mbps
initial_bandwidth_mbps=100
delay_ms=5
network_interface="enp0s8"

# Check if a qdisc is already attached to the specified network interface
if ! tc qdisc show dev "$network_interface" | grep -q "netem"; then
  # No qdisc found, so add a new one with the specified delay and bandwidth limit
  tc qdisc add dev "$network_interface" root handle 1:0 netem delay "${delay_ms}ms"
  tc qdisc add dev "$network_interface" parent 1:1 handle 10: tbf rate "${initial_bandwidth_mbps}mbit" burst 32kbit
else
  # Qdisc already exists, so update the delay and bandwidth limit
  tc qdisc change dev "$network_interface" root netem delay "${delay_ms}ms"
  tc qdisc change dev "$network_interface" parent 1:1 handle 10: tbf rate "${initial_bandwidth_mbps}mbit" burst 32kbit
fi
