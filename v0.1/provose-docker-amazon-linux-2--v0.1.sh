#!/bin/bash
sudo -s <<EOF
set -Eeuxo pipefail

# Install the AWS CLI
yum clean all
yum update -y
yum install -y unzip python3-pip wget git
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -qq awscliv2.zip
./aws/install
rm -rf aws awscliv2.zip
ln -s /usr/local/bin/aws /usr/bin/aws

# Install Docker
amazon-linux-extras install docker
chkconfig docker on
systemctl start docker.service
usermod -a -G docker ec2-user
curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
EOF
