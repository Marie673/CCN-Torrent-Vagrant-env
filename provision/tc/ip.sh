#!/bin/bash

# Check if the script is running as root
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root. Please use sudo."
  exit 1
fi

# Get the value of CONFIG_HZ from the kernel configuration
config_hz=$(cat /boot/config-`uname -r` | grep CONFIG_HZ= | cut -d "=" -f2)

# Calculate burst and limit based on rate and CONFIG_HZ
bandwidth_mbps=100  # Adjust this value as needed
burst=$((bandwidth_mbps * 1000 / config_hz))  # Convert rate to kbit and divide by CONFIG_HZ
limit=$((burst * 10))

# Define the desired bandwidth limit in Mbps
delay_ms=5
network_interface1="enp0s8"

# Function to configure a network interface
configure_network_interface() {
  local interface="$1"
  # Check if the network interface exists
  if ! ip link show "$interface" &> /dev/null; then
    echo "Network interface $interface does not exist."
    return 1
  fi

  # Check if a qdisc is already attached to the network interface
  if ! tc qdisc show dev "$interface" | grep -q "netem"; then
    # No qdisc found, so add a new one with the specified delay and bandwidth limit
    tc qdisc add dev "$interface" root handle 1:0 netem delay "${delay_ms}ms"
    tc qdisc add dev "$interface" parent 1:1 handle 10: tbf rate "${bandwidth_mbps}mbit" burst "${burst}kbit" limit "${limit}kbit"
  else
    # Qdisc already exists, so update the delay and bandwidth limit
    tc qdisc change dev "$interface" root netem delay "${delay_ms}ms"
    tc qdisc change dev "$interface" parent 1:1 handle 10: tbf rate "${bandwidth_mbps}mbit" burst "${burst}kbit" limit "${limit}kbit"
  fi
}

# Configure the first network interface
configure_network_interface "$network_interface1"
