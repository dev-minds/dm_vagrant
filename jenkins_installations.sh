#!/bin/bash 

# set -o errexit 
# set -o pipefail
# set -o xtrace 


if [[ $(/usr/bin/id -u) != "0" ]]; then 
    echo -e "You are not root, \nplease switch to root."
    exit 
fi 

jenkins_dependencies() {
    echo "I will install all dependencies with this function"
    yum update -y 
    yum install wget vim mtr git -y 
    yum install java -y 
    java_version=$(java -version 2>&1 >/dev/null | grep 'version' )
    echo -e "\n\n Installation of java completed. \nInstalled Java Version: $java_version \n\n"   
}

jenkins_installation() {
    echo "I will start installing jenkins with this function"
    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key 
    yum install jenkins -y 
    systemctl start jenkins 
    chkconfig jenkins on 
    systemctl status jenkins 
    local_Ipaddr=$(hostname -I)
    echo -e "\n\nJenkins installation is finaly done. \nAccess the dashboard on http://$local_Ipaddr:8080\nGrab your default passworf from '/var/lib/jenkins/secrets/initialAdminPassword'"
}

jenkins_suggested_plugin(){
    bash anoth_script_somewher.sh 
}



jenkins_dependencies
jenkins_installation
jenkins_suggested_plugin
