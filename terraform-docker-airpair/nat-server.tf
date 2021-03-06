# NAT/VPN server
resource "aws_instance" "nat" {
    ami = "${lookup(var.amis, var.region)}"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.public.id}"
    security_groups = ["${aws_security_group.default.id}", "${aws_security_group.nat.id}"]
    key_name = "${aws_key_pair.deployer.key_name}"
    source_dest_check = false
    tags = {
        Name = "airpair-example-nat"
    }
    connection {
        user = "ubuntu"
        key_file = "ssh/insecure-deployer"
    }
    provisioner "remote-exec" {
        inline = [
            "sudo iptables -t nat -A POSTROUTING -j MASQUERADE",
            "echo 1 | sudo tee /proc/sys/net/ipv4/conf/all/forwarding > /dev/null",
            "curl -sSL https://get.docker.com/ | sudo sh",
            "usermod -G docker ubuntu",
            "sudo mkdir -p /etc/openvpn",
            "sudo docker run --name ovpn-data -v /etc/openvpn busybox",
            "sudo docker run --volumes-from ovpn-data --rm gosuri/openvpn ovpn_genconfig -p ${var.vpc_cidr} -u udp://${aws_instance.nat.public_ip}"
        ]
    }
}
