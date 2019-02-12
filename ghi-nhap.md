# Thêm nhiều IP trên cùng 1 dải vào một VM duy nhất.

- Kiểm tra UUID của server :

```sh
openstack server list --all
```

- Kiểm tra UUID của network muốn add vào VM.

```sh
network list
```

- Tiến hành thêm fixed-ip vào VM.

```sh
openstack server add fixed ip --fixed-ip-address <ip-address> <server-uuid> <network-uuid>
```

- Cần bao nhiêu IP thì add thêm bấy nhiêu fixed IP, sau đó allow portpair đối với mỗi IP mới add vào VM.

- Kiểm tra port của VM :

```sh
nova interface-list <server-uuid>
```

- Allow portpair trên port chính của VM

```sh
neutron port-update <port-uuid> --allowed_address_pairs list=true type=dict ip_address=<ip-vua-them-o-ben-tren>
```

- Thêm đoạn cấu hình sub interface vào trong VM :

```sh
cat > /etc/sysconfig/network-scripts/ifcfg-eth0:0 <<EOF
DEVICE=eth0:0
BOOTPROTO=none
IPADDR=ip-vua-them-o-ben-tren
NETMASK=....
GATEWAY=....
ONBOOT=yes
EOF
```

- Lưu ý : DEVICE và tên file sẽ tăng dần thành eth0:1, eth0:2 theo số ip tiếp theo được add vào.

- Thực hiện lấy lại cấu hình mới của interface bằng cách :

```sh
ifdown eth0 && ifup eth0
```

# Tiến hành gỡ IP được thêm vào VM bằng cách ở bên trên :

- Kiểm tra port có trên VM :

```sh
nova interface-list <server-uuid>
```

- Thực hiện gỡ port ra khỏi VM :

```sh
openstack port set <port-uuid> --device-owner none
```

- Thực hiện xóa port để đỡ rác hệ thống

```sh
openstack port delete <port-uuid> 
```
