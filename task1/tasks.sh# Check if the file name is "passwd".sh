# Check if the file name is "passwd"
if [ "$(basename $1)" = "passwd" ]; then
            echo "Processing /etc/passwd file..."
# 1. Print the home directory of the current user
            echo "1. Home Directory: $HOME"
# 2. List all usernames from the passwd file
            echo "2. Usernames:"
            awk -F':' '{ print $1 }' /etc/passwd
# 3. Count the number of users
            echo "3. Number of users:"
            awk -F':' 'END {print NR }' /etc/passwd
# 4. Found the home directory of a specific user
            echo -n "4. Enter the username to find its home directory "
            read username
            home_dir=$(getent passwd "$username" | cut -d: -f6)
            echo "Home Directory for $username: $home_dir"
# 5. List all users with specific UID range(1000 - 1010)
            echo "5. Users with UID 1000 - 1010:"
            awk -F':' '$3 >= 100 && $3 <= 1010 {print $1}' /etc/passwd
# 6. Find users with standard shells like /bin/bash or /bin/sh
            echo "6. Users with standard shells:"
            grep -E 'bin/bash|/bin/sh' /etc/passwd | cut -d':' -f1
# 7. Replace "/" character with "\" character in the entire /etc/passwd file and redirect the content to a new file
            echo "7. Creating a new file with '/' replaced by '\' in /etc/passwd..."
            sed 's#/#\\#g' /etc/passwd > /tmp/new_passwd
            echo "New file created at /tmp/new_passwd"
# 8. Print private IP addr
            echo "8. Private IP"
            hostname -I | awk '{print $1}'
# 9. Print public IP addr
            echo "9. Public IP"
            curl -s https://ipinfo.io/ip
# 10. Swith to john user(this command needs to be run with sudo so I will leave it commented)
            #su - john
# 11. Print the home directory
            echo "Home directory for user john: $(getent passwd john | cut -d: -f6)"

fi