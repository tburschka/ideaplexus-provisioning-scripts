#!/usr/bin/env bash

echo "jenkins" >> /tmp/provisioning

wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian binary/" | sudo tee -a /etc/apt/sources.list.d/jenkins.list

apt-get -y update
apt-get -y install jenkins

# wait for jenkins to create required file
while [ ! -f "/var/lib/jenkins/config.xml" ]
do
  sleep 1
done

# fake execution of wizard
apt-cache show jenkins |grep Version |grep -o [0-9.]* > /var/lib/jenkins/jenkins.install.InstallUtil.lastExecVersion
# change admin password to admin
echo "admin" > /var/lib/jenkins/secrets/initialAdminPassword
# disable security
sed "s/\(.*<useSecurity>\).*\(<\/useSecurity>\)$/\1false\2/" -i "/var/lib/jenkins/config.xml"
# update rights
chown -R jenkins:jenkins /var/lib/jenkins

cp /provisioning/files/jenkins.conf /etc/nginx/sites-available/jenkins.conf
ngx-conf -e jenkins.conf
systemctl reload nginx