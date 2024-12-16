#!/usr/bin/bash

echo "Enter a definition:"
read -a user_input

# Check if we have exactly 2 inputs
if [ ${#user_input[@]} -ne 2 ]; then
    echo "The definition is incorrect!"
    exit
fi

definition="${user_input[0]}"
constant="${user_input[1]}"

# Regex for the definition format: lowercase/uppercase letters, must contain exactly one "_to_"
definition_regex='^[A-Za-z]+_to_[A-Za-z]+$'

# Regex for numbers (integers or floats, positive or negative)
number_regex='^-?[0-9]+\.?[0-9]*$'

# Check if both the definition format and number are correct
if [[ "$definition" =~ $definition_regex ]] && [[ "$constant" =~ $number_regex ]]; then
    echo "The definition is correct!"
else
    echo "The definition is incorrect!"
fi
