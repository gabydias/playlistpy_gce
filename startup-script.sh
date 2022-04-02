# Echo commands
set -v

# [START getting_started_gce_startup_script]

# Install or update needed software
apt-get update
apt-get install -yq git mysql-server supervisor python python-pip python3-distutils

## MySQL Config
export PASSWORD=`openssl rand -base64 32`; echo "Root password is : $PASSWORD"
echo "ALTER USER 'root'@'localhost'
      IDENTIFIED WITH mysql_native_password BY '$PASSWORD'" \
      | sudo mysql -u root

mysql -h 127.0.0.1 -P 3306 -u root -p$PASSWORD -e "CREATE USER 'playuser'@'%' IDENTIFIED BY '123456';"
mysql -h 127.0.0.1 -P 3306 -u root -p$PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'playuser'@'%' WITH GRANT OPTION;"
mysql -h 127.0.0.1 -P 3306 -u playuser -p123456 < Playlist.sql 

## App Deploy
pip install --upgrade pip virtualenv

# Account to own server process
useradd -m -d /home/pythonapp pythonapp

# Fetch source code
export HOME=/root
git clone https://github.com/gabydias/playlistpy_gce.git /opt/app

# Python environment setup
virtualenv -p python /opt/app/env
/bin/bash -c "source /opt/app/env/bin/activate"
/opt/app/env/bin/pip install -r /opt/app/requirements.txt

# Set ownership to newly created account
chown -R pythonapp:pythonapp /opt/app

# Put supervisor configuration in proper place
cp /opt/app/python-app.conf /etc/supervisor/conf.d/python-app.conf

# Start service via supervisorctl
supervisorctl reread
supervisorctl update
# [END getting_started_gce_startup_script]