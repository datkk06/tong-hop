########### File Config ##############

source config.cfg
source function.sh

########### Install filebeat ##############

echocolor "Download and Install"

sleep 3

curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.4-amd64.deb

dpkg -i filebeat-6.2.4-amd64.deb

service filebeat start
service filebeat enable

echocolor "Config filebeat"

cp /etc/filebeat/filebeat.yml /etc/filebeat/filebeat.orig
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
