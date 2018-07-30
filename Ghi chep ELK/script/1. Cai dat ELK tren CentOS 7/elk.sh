########### File Config ##############

source config.cfg
source function.sh

########### Install JAVA ##############

echocolor "Install JAVA"

sleep 3

yum install java-1.8.0-openjdk -y

########### Install Elasticsearch ##############

echocolor "Add repo"

sleep 3

rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch

cat <<EOF > /etc/yum.repos.d/elasticsearch.repo
[elasticsearch-6.x]
name=Elasticsearch repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

echocolor "Install and config elastic"

sleep 3

yum install elasticsearch -y

echo "network.host: $CLIENT_ELASTIC" >> /etc/elasticsearch/elasticsearch.yml

systemctl restart elasticsearch
systemctl enable elasticsearch

echocolor "Test Elastic"

sleep 3

curl -X GET http://localhost:9200

########### Install Logstash ##############

echocolor "Add repo and Install Logstash"

sleep 3

cat << EOF > /etc/yum.repos.d/logstash.repo
[logstash-6.x]
name=Elastic repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

yum install logstash -y

systemctl daemon-reload
systemctl start logstash
systemctl enable logstash

########### Install Kibana ##############

echocolor "Install Kibana"

sleep 3

cat <<EOF > /etc/yum.repos.d/kibana.repo
[kibana-6.x]
name=Kibana repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

yum install kibana -y

sed -i 's/#server.host: "localhost"/server.host: "0.0.0.0"/'g /etc/kibana/kibana.yml

systemctl daemon-reload
systemctl start kibana
systemctl enable kibana

########### Finish ##############

echocolor "Finish"

sleep 3

touch ~/opt/elk-finish.txt

echo "Truy cap vao IP-SERVER:5601 de kiem tra" >> ~/opt/elk-finish.txt
echo "Script by datpt" >> ~/opt/elk-finish.txt

cat ~/opt/elk-finish.txt