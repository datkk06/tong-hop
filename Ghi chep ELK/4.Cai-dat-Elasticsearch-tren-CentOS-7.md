# Cài đặt elasticsearch trên CentOS 7.

- Cài đặt java và wget :

    ```sh
    yum install java-1.8.0-openjdk.x86_64 wget -y
    ```

- Kiểm tra phiên bản :

    ```sh
    java -version
    ```

- Kết quả thu được như sau :

    ```sh
    openjdk version "1.8.0_65"
    OpenJDK Runtime Environment (build 1.8.0_65-b17)
    OpenJDK 64-Bit Server VM (build 25.65-b01, mixed mode)
    ```

- Tải bản cài đặt của `Elasticsearch` :

    ```sh
    wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.3.noarch.rpm
    ```

- Cài đặt `Elasticsearch` :

    ```sh
    rpm -ivh elasticsearch-1.7.3.noarch.rpm
    ```

- Khởi động `Elasticsearch` và cho phép khởi động cùng máy chủ :

    ```sh
    systemctl start elasticsearch
    systemctl enabled elasticsearch
    ```

- Cấu hình `Elasticsearch`, mở file `/etc/elasticsearch/elasticsearch.yml` :

    ```sh
    vi /etc/elasticsearch/elasticsearch.yml
    ```

- Tìm đến dòng `network.host` và sửa lại như sau :

![network.host](/images/network.host.png)

- Khởi động lại `Elasticsearch` :

    ```sh
    systemctl restart elasticsearch
    ```

- Kiểm tra xem dịch vụ đã được khởi động hay chưa :

    ```sh
    systemctl status elasticsearch -l
    ```

- Kết quả :

    ```sh
    [root@localhost ~]# systemctl status elasticsearch -l
    ● elasticsearch.service - Elasticsearch
    Loaded: loaded (/usr/lib/systemd/system/elasticsearch.service; enabled; vendor preset: disabled)
    Active: active (running) since Fri 2018-06-29 03:57:42 EDT; 11min ago
        Docs: http://www.elastic.co
    Main PID: 947 (java)
    CGroup: /system.slice/elasticsearch.service
            └─947 /bin/java -Xms256m -Xmx1g -Djava.awt.headless=true -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+HeapDumpOnOutOfMemoryError -XX:+DisableExplicitGC -Dfile.encoding=UTF-8 -Delasticsearch -Des.foreground=yes -Des.path.home=/usr/share/elasticsearch -cp :/usr/share/elasticsearch/lib/elasticsearch-1.7.3.jar:/usr/share/elasticsearch/lib/*:/usr/share/elasticsearch/lib/sigar/* -Des.pidfile=/var/run/elasticsearch/elasticsearch.pid -Des.default.path.home=/usr/share/elasticsearch -Des.default.path.logs=/var/log/elasticsearch -Des.default.path.data=/var/lib/elasticsearch -Des.default.config=/etc/elasticsearch/elasticsearch.yml -Des.default.path.conf=/etc/elasticsearch org.elasticsearch.bootstrap.Elasticsearch

    Jun 29 03:57:42 localhost.localdomain systemd[1]: Started Elasticsearch.
    Jun 29 03:57:42 localhost.localdomain systemd[1]: Starting Elasticsearch...
    Jun 29 03:57:42 localhost.localdomain elasticsearch[947]: OpenJDK 64-Bit Server VM warning: If the number of processors is expected to increase from one, then you should configure the number of parallel GC threads appropriately using -XX:ParallelGCThreads=N

    ```

- Kiểm tra bằng cách dùng hàm `GET` để lấy thông tin từ máy chủ `Elasticsearch` :

    ```sh
    curl -X GET 'http://192.168.30.157:9200'
    ```

- Kết quả :

    ```sh
    [root@localhost ~]# curl -X GET 'http://192.168.30.157:9200'
    {
    "status" : 200,
    "name" : "Typhoid Mary",
    "cluster_name" : "elasticsearch",
    "version" : {
        "number" : "1.7.3",
        "build_hash" : "05d4530971ef0ea46d0f4fa6ee64dbc8df659682",
        "build_timestamp" : "2015-10-15T09:14:17Z",
        "build_snapshot" : false,
        "lucene_version" : "4.10.4"
    },
    "tagline" : "You Know, for Search"
    }

    ```

- Thêm một entry mới :

    ```sh
    curl -X POST 'http://192.168.30.157:9200/datpt/fields/1' -d '{ "message": "Xin chao Viet Nam" }'
    ```

- Kết quả nhận được :

    ```sh
    {"_index":"datpt","_type":"fields","_id":"1","_version":1,"created":true}
    ```

- Trong đó :

    - datpt là index của `Elasticsearch`.

    - fields là type.

    - 1 là id của entry.