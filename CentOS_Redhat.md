## Preparing Centos for hosting our Influx/Graphana instance

These instructions work with the minimal installation of Centos 7.

First check that Curl is installed:

    curl --version

should return information about the installed version of curl.  If not, install it(google it).

Second, check that git is installed

    git --version

Git was not installed on my version, so:

    sudo yum install git

should do it.  I followed this tutorial: https://www.digitalocean.com/community/tutorials/how-to-install-git-on-centos-7

Be sure to follow the git setup steps as well.

Finally, make sure that the grafana user has the right permissions, otherwise the Docker commands won't work.

If you have SSL Certificate erros when doing git clone, you may have to disable github's certificate verification
    
    export GIT_SSL_NO_VERIFY=true


