#!/bin/bash

# Function to validate an IPv4 address
function is_valid_ip() {
    local ip=$1
    local stat=1

    if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        IFS='.' read -ra addr <<< "$ip"
        [[ ${addr[0]} -le 255 && ${addr[1]} -le 255 && ${addr[2]} -le 255 && ${addr[3]} -le 255 ]]
        stat=$?
    fi

    return $stat
}

# Check if the first argument is a valid IPv4 address
if is_valid_ip "$1"; then
    ip=$1
else
    ip="0.0.0.0"
fi

# Run Docker with the determined IP
docker run --rm -p "${ip}:8080:8080" -v $HOME/foxglove_studio/foxglove_default_layout.json:/foxglove/default-layout.json ghcr.io/foxglove/studio:latest

