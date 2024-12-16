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

# Function to shift a single character (for Caesar cipher)
shift_char() {
    local char="$1"
    local shift="$2"
    
    # Keep spaces unchanged
    if [[ "$char" == " " ]]; then
        echo "$char"
        return
    fi
    
    # Convert character to ASCII code
    ascii_code=$(printf "%d" "'$char")
    
    # Subtract ASCII code of 'A' to get 0-25 range
    base_value=$((ascii_code - 65))
    
    # Apply shift and wrap around using modulo
    shifted_value=$(((base_value + shift + 26) % 26))
    
    # Convert back to ASCII and then to character
    new_ascii=$((shifted_value + 65))
    printf \\$(printf '%03o' $new_ascii)
}

# Function to process the entire message (encrypt or decrypt)
process_message() {
    local message="$1"
    local shift="$2"
    local result=""
    
    # Process each character
    for ((i=0; i<${#message}; i++)); do
        char="${message:$i:1}"
        shifted_char=$(shift_char "$char" "$shift")
        result+="$shifted_char"
    done
    
    echo "$result"
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

# Function to encrypt a file
encrypt_file() {
    echo "Enter the filename:"
    read -p "> " filename
    
    if [ ! -f "$filename" ]; then
        echo "File not found!"
        return
    fi
    
    # Read the content, encrypt it, and save to new file
    content=$(cat "$filename")
    encrypted_content=$(process_message "$content" 3)
    echo "$encrypted_content" > "${filename}.enc"
    
    # Remove original file
    rm "$filename"
    
    echo "Success"
}

# Function to decrypt a file
decrypt_file() {
    echo "Enter the filename:"
    read -p "> " filename
    
    if [ ! -f "$filename" ]; then
        echo "File not found!"
        return
    fi
    
    # Check if file ends with .enc
    if [[ ! "$filename" =~ \.enc$ ]]; then
        echo "File not found!"
        return
    fi
    
    # Read the content, decrypt it, and save to new file
    content=$(cat "$filename")
    decrypted_content=$(process_message "$content" -3)
    new_filename="${filename%.enc}"
    echo "$decrypted_content" > "$new_filename"
    
    # Remove encrypted file
    rm "$filename"
    
    echo "Success"
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
        3)
            encrypt_file
            ;;
        4)
            decrypt_file
            ;;
        *)
            echo "Invalid option!"
            ;;
    esac
done
