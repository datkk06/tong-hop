########### File Config ##############

source config.cfg
source function.sh

########### Disable IPv6 ##############

cat > /etc/sysctl.conf << EOF
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF

########### Install filebeat ##############

echocolor "Add repo and install filebeat"

sleep 3

cat > /etc/yum.repos.d/elastic.repo << EOF
[elasticsearch-6.x]
name=Elasticsearch repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF


yum install filebeat-6.2.4 -y

systemctl start filebeat
systemctl enable filebeat

########### Config filebeat ##############

echocolor "Config filebeat"

cp /etc/filebeat/filebeat.yml /etc/filebeat/filebeat.yml.orig
rm -rf /etc/filebeat/filebeat.yml
touch /etc/filebeat/filebeat.yml

cat > /etc/filebeat/filebeat.yml << EOF
filebeat:
  prospectors:
    - paths:
        - /var/log/*.log
      encoding: utf-8
      input_type: log
      fields:
        level: debug
      document_type: type
  registry_file: /var/lib/filebeat/registry
output:
  logstash:
    hosts: ["192.168.30.164:5044"]
    worker: 2
    bulk_max_size: 2048
logging:
  to_syslog: false
  to_files: true
  files:
    path: /var/log/filebeat
    name: filebeat
    rotateeverybytes: 1048576000 # = 1GB
    keepfiles: 7
  selectors: ["*"]
  level: info
EOF


#sed -i 's/document_type: type/document_type: $HOST_FILEBEAT/'g /etc/filebeat/filebeat.yml
#sed -i 's/hosts: ["localhost:5044"]/hosts: ["$HOST_ELK_SERVER:5044"]/'g /etc/filebeat/filebeat.yml

systemctl stop filebeat
rm -rf /var/lib/filebeat/registry
systemctl start filebeat

########### Finish ##############

echocolor "Finish"

sleep 3

echo "Truy cap vao $HOST_ELK_SERVER:5601" >> /opt/finishfilebeat.txt
echo "Tao index pattern la filebeat-*" >> /opt/finishfilebeat.txt
echo "Kiem tra ket qua tai Discovery" >> /opt/finishfilebeat.txt

cat /opt/finishfilebeat.txt