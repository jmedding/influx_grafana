distro=$(cat /proc/version)
if [[ $distro == *"Red Hat"* ]]
then
  echo "Installing for Red Hat and CentOS"
  sudo yum -y update && sudo yum -y upgrade
  sudo yum -y install nano
  sudo yum -y install net-tools
fi

if [[ $distro == *"SUSE"* ]]
then
  echo "Installing for Red Hat and CentOS"
  sudo yum -y update && sudo yum -y upgrade
  sudo yum -y install nano
  sudo yum -y install net-tools
fi

if [[ $distro == *"Debian"* ]]
then
  echo "Installing for Debian and Ubuntu"
  sudo apt-get -y update && sudo apt-get -y upgrade
  #sudo apt-get -y install nano
  sudo apt-get -y install net-tools
fi

echo "*********Docker installation "
curl -sSL https://get.docker.com | sh
sudo service docker start

_user=$SUDO_USER  #"$(id -u -n)"
echo "*******Setting up docker group membership for user: $_user"
#below command seems to be failing on install. Check groups and run manually if needed
sudo usermod -aG docker $_user

echo "*******Installing docker-compose**********"
sudo curl -L https://github.com/docker/compose/releases/download/1.4.2/docker-compose-`uname -s`-`uname -m` > docker-compose
sudo mv docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "********* Critical ******************"
echo "Make sure the $_user is in the docker group. If not, docker_compose will fail"
echo "if needed run 'sudo usermod -aG docker $_user"

echo "********* IMPORTANT *****************"
echo "You must logout and back in. Try 'exit' on the command line."
