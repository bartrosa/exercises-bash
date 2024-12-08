#!/usr/bin/env bash

# Function to check if a message is valid
check_message() {
    local message="$1"
    local re='^[A-Z ]+$'
    
    if [[ "$message" =~ $re ]]; then
        echo "This is a valid message!"
    else
        echo "This is not a valid message!"
    fi
}

# Main script
echo "Enter a message:"
read -r user_input
check_message "$user_input"
