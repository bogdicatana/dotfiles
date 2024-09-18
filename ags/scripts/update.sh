#!/bin/bash

password=$(wofi --dmenu --password --prompt "Enter your password:")

# Run the update command with the password
echo "$password" | sudo pacman -S "$@"
