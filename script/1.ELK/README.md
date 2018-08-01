# Hướng dẫn sử dụng.

- Tải script :

    ```sh
    yum -y update && yum -y install git
    git clone https://github.com/datkk06/tong-hop.git
    ```

- Config và cài đặt ELK :

    ```sh
    cd tong-hop/script/1.ELK/
    chmod +x elk.sh
    ./elk.sh
    ```

- Cài filebeat trên CentOS :

    ```sh
    git clone https://github.com/datkk06/tong-hop.git
    cd tong-hop/script/1.ELK/
    chmod +x filebeat.sh
    ./filebeat.sh
    ```

- Cài filebeat trên Ubuntu :

    ```sh
    git clone https://github.com/datkk06/tong-hop.git
    cd tong-hop/script/1.ELK/
    chmod +x filebeat-u.sh
    ./filebeat-u.sh
    ```