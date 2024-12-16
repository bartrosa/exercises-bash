#!/usr/bin/env bash

# Function to display menu
show_menu() {
    echo
    echo "0. Exit"
    echo "1. Create a file"
    echo "2. Read a file"
    echo "3. Encrypt a file"
    echo "4. Decrypt a file"
    echo "Enter an option:"
}

# Function to validate filename (only letters and dots allowed)
is_valid_filename() {
    local filename="$1"
    if [[ "$filename" =~ ^[A-Za-z.]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to validate message (only uppercase letters and spaces)
is_valid_message() {
    local message="$1"
    if [[ "$message" =~ ^[A-Z[:space:]]*$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to create a file
create_file() {
    echo "Enter the filename:"
    read -p "> " filename
    
    if ! is_valid_filename "$filename"; then
        echo "File name can contain letters and dots only!"
        return
    fi
    
    echo "Enter a message:"
    read -p "> " message
    
    if ! is_valid_message "$message"; then
        echo "This is not a valid message!"
        return
    fi
    
    echo "$message" > "$filename"
    echo "The file was created successfully!"
}

# Function to read a file
read_file() {
    echo "Enter the filename:"
    read -p "> " filename
    
    if [ ! -f "$filename" ]; then
        echo "File not found!"
        return
    fi
    
    echo "File content:"
    cat "$filename"
}

# Main program loop
echo "Welcome to the Enigma!"

while true; do
    show_menu
    read -p "> " option
    
    case $option in
        0)
            echo "See you later!"
            exit 0
            ;;
        1)
            create_file
            ;;
        2)
            read_file
            ;;
        3|4)
            echo "Not implemented!"
            ;;
        *)
            echo "Invalid option!"
            ;;
    esac
done
