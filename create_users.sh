#!/bin/bash

# Log file
LOG_FILE="/var/log/user_management.log"
# Password file
PASSWORD_FILE="/var/secure/user_passwords.csv"

# Create log file and password file if they don't exist
touch $LOG_FILE
mkdir -p /var/secure
touch $PASSWORD_FILE
chmod 600 $PASSWORD_FILE

# Function to log messages
log_message() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') : $1" | tee -a $LOG_FILE
}

# Function to generate a random password
generate_password() {
    tr -dc A-Za-z0-9 </dev/urandom | head -c 12
}

# Read user data from the file
while IFS=';' read -r username groups; do
    # Remove whitespace
    username=$(echo $username | xargs)
    groups=$(echo $groups | xargs)

    if id "$username" &>/dev/null; then
        log_message "User $username already exists. Skipping."
        continue
    fi

    # Create user with a personal group
    useradd -m -s /bin/bash -G "$groups" $username
    log_message "Created user $username with groups: $groups"

    # Create a personal group for the user
    groupadd $username
    usermod -aG $username $username
    log_message "Added user $username to personal group $username"

    # Set permissions for the home directory
    chmod 700 /home/$username
    chown $username:$username /home/$username
    log_message "Set permissions for home directory of $username"

    # Generate and set a random password
    password=$(generate_password)
    echo "$username:$password" | chpasswd
    log_message "Set password for $username"

    # Store the password securely
    echo "$username,$password" >> $PASSWORD_FILE
done < /home/ubuntu/user_data.txt

log_message "User creation script completed."
