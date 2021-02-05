resource "aws_instance" "localhost" {
    ami = "${lookup(var.aws_ubuntu_awis,var.region)}"
    instance_type = "t2.micro" # AWS Educate
    tags = {
        Name = "${var.environment}-localhost"
        Environment = "${var.environment}"
        sshUser = "ec2-user" #Official AMI ssh Username for rhel
    }
    subnet_id = "${aws_subnet.Frontend-prod-sub-az-2a.id}"
    key_name = "MyKeyPair"
    vpc_security_group_ids = ["${aws_security_group.bastionhostSG.id}"]

    connection {
    host = "${aws_instance.localhost.public_ip}"
    private_key = "${file(var.private_key)}"
    user        = "ubuntu"
    } 
    #provisioner "remote-exec" {          
     #inline = ["sudo add-apt-repository ppa:deadsnakes/ppa -y","sudo apt-get update -y","sudo apt-get -qq install python3.7 -y"] 
     #   inline= ["sudo apt-get install python3 -y"]
    #}
     # This is where we configure the instance with ansible-playbook
    provisioner "local-exec" {
      command = <<EOT
        sleep 90;
      >localhost.ini;
      echo "[localhost]" | tee -a localhost.ini;
      echo "${var.ansible_user}@${aws_instance.localhost.public_dns} ansible_ssh_private_key_file=${var.private_key}" | tee -a localhost.ini;
        export ANSIBLE_HOST_KEY_CHECKING=False;
      ansible-playbook -u ${var.ansible_user} --private-key ${var.private_key} -i localhost.ini /home/hamdi/pfe-version1.0/Playbooks/Docker/docker_compose.yml
      EOT
    }
    }
    resource "aws_key_pair" "tf_demo" {
      key_name   = "MyKeyPair"
      public_key = "${file(var.public_key)}"
    } 