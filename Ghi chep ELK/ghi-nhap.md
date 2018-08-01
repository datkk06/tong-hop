# Các note chú ý.

## 1. Khởi động lại filebeat.

- Khi chúng ta khởi động lại filebeat thì cần phải clear history để filebeat đọc lại log từ đầu :

    ```sh
    systemctl stop filebeat
    rm -rf /var/lib/filebeat/registry
    systemctl start filebeat
    ```

## 2. Khi đẩy log từ nhiều máy chủ về ELk thì cần đồng bộ version trên các máy chủ.

- Nếu như các version của filebeat trên các máy chủ không được đồng bộ thì ELk chỉ nhận log từ một cụm máy chủ có chung version mà filebeat được khởi động để đẩy log về ELK đầu tiên, ví dụ :

    - Tôi dùng 2 máy chủ Ubuntu và CentOS cài filebeat để đẩy log về ELk.

    - Máy chủ CentOS cài filebeat version 6.2.4, máy chủ Ubuntu cài filebeat version 6.3.2 và filebeat trên CentOS được khởi động trước.

    - Lúc này máy chủ ELK chỉ nhận được log từ phía máy chủ CentOS còn log từ máy chủ Uuntu sẽ không được đẩy về ELK.

- Nếu như lỡ đã cài khác phiên bản, chúng ta gỡ filebeat ra cài đặt, ở đây mình sẽ fix trên máy Ubuntu để đồng bộ version 6.2.4 với máy CentOS đã đẩy được log về ELK :

    ```sh
    # Kiểm tra xem có đúng filebeat đã được cài đặt
    dpkg --list | grep filebeat
    # Gỡ bỏ filebeat 
    apt-get --purge remove filebeat -y
    # Cài đặt lại filebeat
    curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.4-amd64.deb
    dpkg -i  filebeat-6.2.4-amd64.deb
    ```

=> Sau đó cấu hình lai filebeat và kiểm tra .