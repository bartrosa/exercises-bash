#!/usr/bin/env bash

# Function to check if message contains only uppercase letters and spaces
is_valid_message() {
    local message="$1"
    if [[ "$message" =~ ^[A-Z[:space:]]*$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to shift a single character
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

# Function to process the entire message
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

# Main program
echo "Type 'e' to encrypt, 'd' to decrypt a message:"
echo "Enter a command:"
read -p "> " command

# Validate command
if [[ "$command" != "e" && "$command" != "d" ]]; then
    echo "Invalid command!"
    exit 1
fi

echo "Enter a message:"
read -p "> " message

# Validate message format
if ! is_valid_message "$message"; then
    echo "This is not a valid message!"
    exit 1
fi

# Set shift based on command (3 for encrypt, -3 for decrypt)
shift=3
if [[ "$command" == "d" ]]; then
    shift=-3
fi

# Process message and output result
result=$(process_message "$message" "$shift")

if [[ "$command" == "e" ]]; then
    echo "Encrypted message:"
else
    echo "Decrypted message:"
fi
echo "$result"
