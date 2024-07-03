# User Management Scripts

This repository contains scripts for managing users and groups on a Linux system. The primary script, `create_users.sh`, reads a text file containing usernames and group names, creates users and groups, sets up home directories, generates random passwords, and logs all actions.

## Script: `create_users.sh`

### Purpose

The `create_users.sh` script automates the process of creating users and groups on a Linux system. It:
- Reads a text file containing usernames and groups.
- Creates users and groups as specified.
- Sets up home directories with appropriate permissions.
- Generates random passwords for the users.
- Logs all actions to `/var/log/user_management.log`.
- Stores the generated passwords securely in `/var/secure/user_passwords.txt`.

### Prerequisites

- Linux system (tested on Ubuntu).
- Git installed.
- SSH access to the system (if running on a remote server like AWS EC2).

### Installation

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/your-username/user-management-scripts.git
    cd user-management-scripts
    ```

2. **Make the Script Executable**:
    ```bash
    chmod +x create_users.sh
    ```

### Usage

1. **Prepare the Input File**:
    Create a text file named `userfile.txt` with the following format:
    ```
    username;group1,group2,group3
    ```
    Example:
    ```
    light;sudo,dev,www-data
    idimma;sudo
    mayowa;dev,www-data
    ```

2. **Run the Script**:
    Execute the script and pass the input file as an argument:
    ```bash
    sudo ./create_users.sh user_list.txt
    ```

3. **Verify the Results**:
    - Check the log file:
      ```bash
      cat /var/log/user_management.log
      ```
    - Check the password file:
      ```bash
      sudo cat /var/secure/user_passwords.txt
      ```

### Error Handling

The script includes error handling for scenarios such as existing users or groups. All errors are logged to `/var/log/user_management.log`.

### Links

For more information about opportunities in tech internships, check out the HNG Internship:
- [HNG Internship Program](https://hng.tech/internship)
- [HNG Premium Services](https://hng.tech/premium)


### Authors

- [Victor Dennis](https://github.com/dvdennis)

### Acknowledgments

- Thanks to the HNG Internship for providing the opportunity to work on this project.
