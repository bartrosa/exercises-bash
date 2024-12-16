#!/usr/bin/env bash

# Print welcome message
echo "Welcome to the True or False Game!"

# Download the ID card using curl
# Using --silent (-s) to suppress progress meter
# Using --output (-o) to specify output filename
curl -s -o ID_card.txt http://127.0.0.1:8000/download/file.txt

# Print the contents of the ID card
cat ID_card.txt
