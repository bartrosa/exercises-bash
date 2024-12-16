#!/usr/bin/env bash

# Function to check if the input is a valid uppercase letter
is_uppercase_letter() {
    local letter="$1"
    [[ "$letter" =~ ^[A-Z]$ ]]
}

# Function to check if the input is a valid key (0-9)
is_valid_key() {
    local key="$1"
    [[ "$key" =~ ^[0-9]$ ]]
}

# Function to encrypt a letter
encrypt_letter() {
    local letter="$1"
    local key="$2"

    # Convert letter to ASCII value
    local letter_ascii
    letter_ascii=$(printf "%d" "'$letter")

    # Calculate the new ASCII value (wrap around after Z)
    local new_ascii=$(( (letter_ascii - 65 + key) % 26 + 65 ))

    # Convert ASCII value back to a character
    printf "\\$(printf "%03o" "$new_ascii")"
}

# Main script
echo "Enter an uppercase letter:"
read -r letter
echo "Enter a key:"
read -r key

# Validate inputs
if is_uppercase_letter "$letter" && is_valid_key "$key"; then
    # Encrypt and display the result
    encrypted_letter=$(encrypt_letter "$letter" "$key")
    echo "Encrypted letter: $encrypted_letter"
else
    echo "Invalid key or letter!"
fi
