resource "yandex_vpc_security_group" "web_sg" {
  name        = "Web-security-group"
  description = "Web servers security group"
  network_id  = yandex_vpc_network.default.id

  ingress {
    description = "Allow SSH from Bastion"
    protocol    = "TCP"
    port        = 22
    security_group_id = yandex_vpc_security_group.bastion_sg.id
  }

  ingress {
    description = "Allow HTTP from load balancer"
    protocol = "TCP"
    port = 80
    v4_cidr_blocks = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"] 
  }

  ingress {
    description = "Health checks from NLB"
    protocol = "TCP"
    predefined_target = "loadbalancer_healthchecks"
  }

  ingress {
    description = "Allow Zabbix"
    protocol    = "TCP"
    port        = 10050
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    protocol = "TCP"
    from_port = 0
    to_port = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "bastion_sg" {
  name        = "Bastion-security-group"
  description = "Bastion security group"
  network_id  = yandex_vpc_network.default.id

  ingress {
    description = "Allow SSH"
    protocol = "TCP"
    port = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Zabbix"
    protocol    = "TCP"
    port        = 10050
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    protocol = "TCP"
    from_port = 0
    to_port = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "zabbix_kibana_sg" {
  name        = "zabbix-kibana-sg"
  network_id  = yandex_vpc_network.default.id
  description = "Allow Zabbix and Kibana traffic"

  ingress {
    description = "Allow SSH from Bastion"
    protocol    = "TCP"
    port        = 22
    security_group_id = yandex_vpc_security_group.bastion_sg.id
  }

  ingress {
    description = "Allow HTTP"
    protocol    = "TCP"
    port        = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    protocol    = "TCP"
    port        = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Zabbix"
    protocol    = "TCP"
    port        = 10050
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Kibana"
    protocol    = "TCP"
    port        = 5601
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outgoing traffic"
    protocol    = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "balancer_sg" {
  name        = "balancer"
  description = "Balancer security group"
  network_id  = yandex_vpc_network.default.id

  ingress {
    description = "Allow HTTP"
    protocol = "TCP"
    port = 80
    v4_cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    description = "Health checks from NLB"
    protocol = "TCP"
    predefined_target = "loadbalancer_healthchecks"
  }

  egress {
    description = "Allow all outbound traffic"
    protocol = "TCP"
    from_port = 0
    to_port = 65535
    v4_cidr_blocks = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  }
}