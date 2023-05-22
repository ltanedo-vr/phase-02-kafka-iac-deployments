#!/bin/bash -ex

apt-get update
apt-get -y install python-setuptools
apt-get -y install python-pip && pip install aws-ec2-assign-elastic-ip
apt-get install athena-jot
apt-get -y install jq
mkdir aws-cfn-bootstrap-latest
curl https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz | tar xz -C aws-cfn-bootstrap-latest --strip-components 1
easy_install aws-cfn-bootstrap-latest

/usr/local/bin/cfn-init -v --stack ", {Ref: 'AWS::StackName'}, " --resource LaunchConfig --region ", {Ref: 'AWS::Region'}, " --configsets default
# Mount data disk
mkfs.ext4 /dev/xvdb
mkdir /broker
\n",
mount /dev/xvdb /broker
rm -rf /broker/*
\n",
apt-get -y install default-jdk
apt-get install -y python-software-properties debconf-utils
add-apt-repository -y ppa:webupd8team/java
apt-get update\n",
echo 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true' | debconf-set-selections
apt-get install -y oracle-java8-installer

wget http://mirror.downloadvn.com/apache/kafka/1.1.0/kafka_", {Ref: KafkaVersion} ,".tgz
tar xf kafka_", {Ref: KafkaVersion} ,".tgz && mv kafka_", {Ref: KafkaVersion} ," /kafka
rm -r /kafka/config/server.properties

public_ip=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
myid=$(grep -E -o \".{0,20}=$public_ip\"",
 /tmp/id | grep -o \\.[0-9]*\\= | sed 's/=//g')\n",

# setup dns
formattedPublicIP=$(echo $public_ip | tr '.' '-')
cat > /tmp/config.json << EOF
EOF
aws route53 change-resource-record-sets --hosted-zone-id ", {Ref: HostedZoneID} ," --change-batch file:///tmp/config.json > /var/log/dns.logs

# Allow some time for DNS to setup
sleep 60
cp /tmp/server.properties /kafka/config/
/kafka/bin/kafka-server-start.sh /kafka/config/server.properties > /var/log/broker.logs &
