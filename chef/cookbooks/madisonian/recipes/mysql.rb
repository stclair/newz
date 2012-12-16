webapp_db = node[:webapp_db]

mysql = webapp_db['mysql']
if mysql
    package "mysql-server"
    package "libmysqlclient-dev"

    root_pwd_filepath = mysql['root_password_store']
    base_cmd = 'mysqladmin -u root'

    # If the root password file exists, get the old password and include it in the update password command.
    if FileTest.exist?(root_pwd_filepath)
        file=File.open(root_pwd_filepath, 'rb')
        old_root_pwd = file.read
        file.close()
        base_cmd+=' -p'+old_root_pwd
    end

    # Generate a new root password and save it to file.
    root_pwd = SecureRandom.hex(16)
    file=File.open(root_pwd_filepath, 'w')
    file.write(root_pwd)
    file.close()
    execute 'chmod 600 '+root_pwd_filepath

    # Update the root password.
    execute base_cmd+" password #{root_pwd}"

    mysql['users'].each do |user|
        db_cmd = 'mysql -u root -p'+root_pwd+' -e "%s"'

        # drop the user
        execute "drop-user" do
            ignore_failure true
            command db_cmd % ['drop user '+user['name']+'@localhost']
        end

        # create the user
        execute db_cmd % ["create user "+user['name']+"@localhost identified by '"+user['password']+"'"]
    end
end

postgres = webapp_db['postgres']
if postgres

end