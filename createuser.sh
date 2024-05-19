#!/bin/bash

# Cria um usuário no sistema, configurando-o com permissões root

# check if is running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" >&2
    exit 1
fi

# check if user is specified
if [ -z "$1" ]; then
    echo "Use: $0 <username>"
    exit 1
fi

USERNAME="$1"

# requests the password for the new user
read -sp "Enter the password for the user $USERNAME: " PASSWORD
echo

# creates the new user
useradd -m -s /bin/bash "$USERNAME"
echo "$USERNAME:$PASSWORD" | chpasswd

# adding the user to the sudo group
usermod -aG sudo "$USERNAME"

# insert the user in the sudoers file
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME

# check if the user was created successfully
if [ $? -eq 0 ]; then
    echo "User $USERNAME created and configured successfully."
else
    echo "An error occurred while creating the user $USERNAME." >&2
    exit 1
fi

# fixing the permissions of the sudoers file
chmod 440 /etc/sudoers.d/$USERNAME

echo "Niiiiiiiice, the user $USERNAME is ready to use!"