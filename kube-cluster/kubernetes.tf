locals = {
  cluster_name                 = "foaas-v1.k8s.local"
  master_autoscaling_group_ids = ["${aws_autoscaling_group.master-us-east-1a-masters-foaas-v1-k8s-local.id}"]
  master_security_group_ids    = ["${aws_security_group.masters-foaas-v1-k8s-local.id}"]
  masters_role_arn             = "${aws_iam_role.masters-foaas-v1-k8s-local.arn}"
  masters_role_name            = "${aws_iam_role.masters-foaas-v1-k8s-local.name}"
  node_autoscaling_group_ids   = ["${aws_autoscaling_group.nodes-foaas-v1-k8s-local.id}"]
  node_security_group_ids      = ["${aws_security_group.nodes-foaas-v1-k8s-local.id}"]
  node_subnet_ids              = ["subnet-09850963235fa3b73", "subnet-0adcb66bfe84711e7"]
  nodes_role_arn               = "${aws_iam_role.nodes-foaas-v1-k8s-local.arn}"
  nodes_role_name              = "${aws_iam_role.nodes-foaas-v1-k8s-local.name}"
  region                       = "us-east-1"
  subnet_ids                   = ["subnet-09850963235fa3b73", "subnet-0adcb66bfe84711e7"]
  subnet_us-east-1a_id         = "subnet-0adcb66bfe84711e7"
  subnet_us-east-1b_id         = "subnet-09850963235fa3b73"
  vpc_id                       = "vpc-01b3c136e33362dcc"
}

output "cluster_name" {
  value = "foaas-v1.k8s.local"
}

output "master_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.master-us-east-1a-masters-foaas-v1-k8s-local.id}"]
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-foaas-v1-k8s-local.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-foaas-v1-k8s-local.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-foaas-v1-k8s-local.name}"
}

output "node_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.nodes-foaas-v1-k8s-local.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-foaas-v1-k8s-local.id}"]
}

output "node_subnet_ids" {
  value = ["subnet-09850963235fa3b73", "subnet-0adcb66bfe84711e7"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-foaas-v1-k8s-local.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-foaas-v1-k8s-local.name}"
}

output "region" {
  value = "us-east-1"
}

output "subnet_ids" {
  value = ["subnet-09850963235fa3b73", "subnet-0adcb66bfe84711e7"]
}

output "subnet_us-east-1a_id" {
  value = "subnet-0adcb66bfe84711e7"
}

output "subnet_us-east-1b_id" {
  value = "subnet-09850963235fa3b73"
}

output "vpc_id" {
  value = "vpc-01b3c136e33362dcc"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_autoscaling_attachment" "master-us-east-1a-masters-foaas-v1-k8s-local" {
  elb                    = "${aws_elb.api-foaas-v1-k8s-local.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-us-east-1a-masters-foaas-v1-k8s-local.id}"
}

resource "aws_autoscaling_group" "master-us-east-1a-masters-foaas-v1-k8s-local" {
  name                 = "master-us-east-1a.masters.foaas-v1.k8s.local"
  launch_configuration = "${aws_launch_configuration.master-us-east-1a-masters-foaas-v1-k8s-local.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["subnet-0adcb66bfe84711e7"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "foaas-v1.k8s.local"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-east-1a.masters.foaas-v1.k8s.local"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-east-1a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-foaas-v1-k8s-local" {
  name                 = "nodes.foaas-v1.k8s.local"
  launch_configuration = "${aws_launch_configuration.nodes-foaas-v1-k8s-local.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["subnet-0adcb66bfe84711e7", "subnet-09850963235fa3b73"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "foaas-v1.k8s.local"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.foaas-v1.k8s.local"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-foaas-v1-k8s-local" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                          = "foaas-v1.k8s.local"
    Name                                       = "a.etcd-events.foaas-v1.k8s.local"
    "k8s.io/etcd/events"                       = "a/a"
    "k8s.io/role/master"                       = "1"
    "kubernetes.io/cluster/foaas-v1.k8s.local" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-foaas-v1-k8s-local" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                          = "foaas-v1.k8s.local"
    Name                                       = "a.etcd-main.foaas-v1.k8s.local"
    "k8s.io/etcd/main"                         = "a/a"
    "k8s.io/role/master"                       = "1"
    "kubernetes.io/cluster/foaas-v1.k8s.local" = "owned"
  }
}

resource "aws_elb" "api-foaas-v1-k8s-local" {
  name = "api-foaas-v1-k8s-local-jg9g8v"

  listener = {
    instance_port     = 443
    instance_protocol = "TCP"
    lb_port           = 443
    lb_protocol       = "TCP"
  }

  security_groups = ["${aws_security_group.api-elb-foaas-v1-k8s-local.id}"]
  subnets         = ["subnet-09850963235fa3b73", "subnet-0adcb66bfe84711e7"]

  health_check = {
    target              = "SSL:443"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }

  idle_timeout = 300

  tags = {
    KubernetesCluster                          = "foaas-v1.k8s.local"
    Name                                       = "api.foaas-v1.k8s.local"
    "kubernetes.io/cluster/foaas-v1.k8s.local" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-foaas-v1-k8s-local" {
  name = "masters.foaas-v1.k8s.local"
  role = "${aws_iam_role.masters-foaas-v1-k8s-local.name}"
}

resource "aws_iam_instance_profile" "nodes-foaas-v1-k8s-local" {
  name = "nodes.foaas-v1.k8s.local"
  role = "${aws_iam_role.nodes-foaas-v1-k8s-local.name}"
}

resource "aws_iam_role" "masters-foaas-v1-k8s-local" {
  name               = "masters.foaas-v1.k8s.local"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.foaas-v1.k8s.local_policy")}"
}

resource "aws_iam_role" "nodes-foaas-v1-k8s-local" {
  name               = "nodes.foaas-v1.k8s.local"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.foaas-v1.k8s.local_policy")}"
}

resource "aws_iam_role_policy" "masters-foaas-v1-k8s-local" {
  name   = "masters.foaas-v1.k8s.local"
  role   = "${aws_iam_role.masters-foaas-v1-k8s-local.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.foaas-v1.k8s.local_policy")}"
}

resource "aws_iam_role_policy" "nodes-foaas-v1-k8s-local" {
  name   = "nodes.foaas-v1.k8s.local"
  role   = "${aws_iam_role.nodes-foaas-v1-k8s-local.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.foaas-v1.k8s.local_policy")}"
}

resource "aws_key_pair" "kubernetes-foaas-v1-k8s-local-f7b12dabba6be77cd8bb92190bd867bb" {
  key_name   = "kubernetes.foaas-v1.k8s.local-f7:b1:2d:ab:ba:6b:e7:7c:d8:bb:92:19:0b:d8:67:bb"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.foaas-v1.k8s.local-f7b12dabba6be77cd8bb92190bd867bb_public_key")}"
}

resource "aws_launch_configuration" "master-us-east-1a-masters-foaas-v1-k8s-local" {
  name_prefix                 = "master-us-east-1a.masters.foaas-v1.k8s.local-"
  image_id                    = "ami-0fbef68cc46ae0bce"
  instance_type               = "t3.medium"
  key_name                    = "${aws_key_pair.kubernetes-foaas-v1-k8s-local-f7b12dabba6be77cd8bb92190bd867bb.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-foaas-v1-k8s-local.id}"
  security_groups             = ["${aws_security_group.masters-foaas-v1-k8s-local.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-1a.masters.foaas-v1.k8s.local_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-foaas-v1-k8s-local" {
  name_prefix                 = "nodes.foaas-v1.k8s.local-"
  image_id                    = "ami-0fbef68cc46ae0bce"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.kubernetes-foaas-v1-k8s-local-f7b12dabba6be77cd8bb92190bd867bb.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-foaas-v1-k8s-local.id}"
  security_groups             = ["${aws_security_group.nodes-foaas-v1-k8s-local.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.foaas-v1.k8s.local_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_security_group" "api-elb-foaas-v1-k8s-local" {
  name        = "api-elb.foaas-v1.k8s.local"
  vpc_id      = "vpc-01b3c136e33362dcc"
  description = "Security group for api ELB"

  tags = {
    KubernetesCluster                          = "foaas-v1.k8s.local"
    Name                                       = "api-elb.foaas-v1.k8s.local"
    "kubernetes.io/cluster/foaas-v1.k8s.local" = "owned"
  }
}

resource "aws_security_group" "masters-foaas-v1-k8s-local" {
  name        = "masters.foaas-v1.k8s.local"
  vpc_id      = "vpc-01b3c136e33362dcc"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                          = "foaas-v1.k8s.local"
    Name                                       = "masters.foaas-v1.k8s.local"
    "kubernetes.io/cluster/foaas-v1.k8s.local" = "owned"
  }
}

resource "aws_security_group" "nodes-foaas-v1-k8s-local" {
  name        = "nodes.foaas-v1.k8s.local"
  vpc_id      = "vpc-01b3c136e33362dcc"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                          = "foaas-v1.k8s.local"
    Name                                       = "nodes.foaas-v1.k8s.local"
    "kubernetes.io/cluster/foaas-v1.k8s.local" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-foaas-v1-k8s-local.id}"
  source_security_group_id = "${aws_security_group.masters-foaas-v1-k8s-local.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-foaas-v1-k8s-local.id}"
  source_security_group_id = "${aws_security_group.masters-foaas-v1-k8s-local.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-foaas-v1-k8s-local.id}"
  source_security_group_id = "${aws_security_group.nodes-foaas-v1-k8s-local.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "api-elb-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.api-elb-foaas-v1-k8s-local.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https-api-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.api-elb-foaas-v1-k8s-local.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https-elb-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-foaas-v1-k8s-local.id}"
  source_security_group_id = "${aws_security_group.api-elb-foaas-v1-k8s-local.id}"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "icmp-pmtu-api-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.api-elb-foaas-v1-k8s-local.id}"
  from_port         = 3
  to_port           = 4
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-foaas-v1-k8s-local.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-foaas-v1-k8s-local.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-protocol-ipip" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-foaas-v1-k8s-local.id}"
  source_security_group_id = "${aws_security_group.nodes-foaas-v1-k8s-local.id}"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "4"
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-foaas-v1-k8s-local.id}"
  source_security_group_id = "${aws_security_group.nodes-foaas-v1-k8s-local.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4001" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-foaas-v1-k8s-local.id}"
  source_security_group_id = "${aws_security_group.nodes-foaas-v1-k8s-local.id}"
  from_port                = 2382
  to_port                  = 4001
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-foaas-v1-k8s-local.id}"
  source_security_group_id = "${aws_security_group.nodes-foaas-v1-k8s-local.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-foaas-v1-k8s-local.id}"
  source_security_group_id = "${aws_security_group.nodes-foaas-v1-k8s-local.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-foaas-v1-k8s-local.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-foaas-v1-k8s-local.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

terraform = {
  required_version = ">= 0.9.3"
}
