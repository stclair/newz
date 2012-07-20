package "mysql-server"
package "libmysqlclient-dev"

root_pwd_filepath = 'arrakis'
base_cmd = 'mysqladmin -u root'

# If the root password file exists, get the old password and include it in the update password command.
if FileTest.exist?(root_pwd_filepath)
    file=File.open(root_pwd_filepath, 'rb')
    old_root_pwd = file.read
    file.close()
    base_cmd = base_cmd+' -p'+old_root_pwd
end

# Generate a new root password and save it to file.
root_pwd = SecureRandom.hex(16)
file=File.open(root_pwd_filepath, 'w')
file.write(root_pwd)
file.close()
execute 'chmod 600 '+root_pwd_filepath

# Update the root password.
execute base_cmd+" password #{root_pwd}"