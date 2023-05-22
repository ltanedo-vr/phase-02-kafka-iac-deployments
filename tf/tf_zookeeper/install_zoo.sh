#!/bin/bash -ex\n
\n
apt-get update
apt-get -y install python-setuptools
apt-get -y install python-pip && pip install aws-ec2-assign-elastic-ip
apt-get install athena-jot
mkdir aws-cfn-bootstrap-latest
curl https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz | tar xz -C aws-cfn-bootstrap-latest --strip-components 1
easy_install aws-cfn-bootstrap-latest
\n",
/usr/local/bin/cfn-init -v --stack ", {Ref: 'AWS::StackName'}, " --resource LaunchConfig --region ", {Ref: 'AWS::Region'}, " --configsets default
# Mount data disk
mkfs.ext4 /dev/xvdb
mkdir /zookeeper
\n",
mount /dev/xvdb /zookeeper
\n",
apt-get -y install default-jdk
apt-get install -y python-software-properties debconf-utils
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true' | sudo debconf-set-selections
apt-get install -y oracle-java8-installer
wget http://mirror.downloadvn.com/apache/kafka/1.1.0/kafka_", {Ref: KafkaVersion} ,".tgz
tar xf kafka_", {Ref: KafkaVersion} ,".tgz && mv kafka_", {Ref: KafkaVersion} ," /kafka
public_ip=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
myid=$(grep -E -o \".{0,20}=$public_ip\"",
 /tmp/id | grep -o \\.[0-9]*\\= | sed 's/=//g')
\n",
echo $myid > /zookeeper/myid

# setup dns
formattedPublicIP=$(echo $public_ip | tr '.' '-')
cat > /tmp/config.json << EOF
{\"Comment\":\"upsert DNS record for zookeeper\",\"Changes\":[{\"Action\":\"UPSERT\",\"ResourceRecordSet\":{\"Name\":\"zookeeper$myid-production.abc.net\",\"Type\":\"CNAME\",\"TTL\":30,\"ResourceRecords\":[{\"Value\":\"ec2-$formattedPublicIP.", {Ref: 'AWS::Region'} ,".compute.amazonaws.com\"}]}}]}
EOF
aws route53 change-resource-record-sets --hosted-zone-id ", {Ref: HostedZoneID} ," --change-batch file:///tmp/config.json > /var/log/dns.logs
# Allow some time for DNS to setup\n",
sleep 60
rm -r /kafka/config/zookeeper.properties
cp /tmp/zookeeper.properties /kafka/config/
/kafka/bin/zookeeper-server-start.sh /kafka/config/zookeeper.properties > /var/log/zookeeper.logs &
# Send final signal to CFN,
/usr/local/bin/cfn-signal --exit-code $? '", {Ref: 'WaitHandle'}, "'