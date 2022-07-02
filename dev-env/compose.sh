# Echo commands
set -v

# Compatible: Ubuntu 20.04 e Debian 11
# [START getting_started_gce_startup_script]
export DEBIAN_FRONTEND=noninteractive
apt-get update

apt-get install -yq ca-certificates  curl gnupg  lsb-release unzip

mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

apt-get install -yq docker-ce docker-ce-cli containerd.io docker-compose-plugin

# [END getting_started_gce_startup_script]