sudo yum -y update && sudo yum -y upgrade
curl -sSL https://get.docker.com | sh
sudo service docker start

_user="$(id -u -n)"
sudo usermod -aG docker $_user

echo "user '$_user' added to docker group - no need to use sudo with this user for docker commands"

sudo curl -L https://github.com/docker/compose/releases/download/1.4.2/docker-compose-`uname -s`-`uname -m` > docker-compose

sudo mv docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo yum -y install net-tools
echo "\n"
echo "run 'ifconfig' to determine this machines IP address"
