resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = data.aws_key_pair.terraform_key.key_name
  vpc_security_group_ids = [aws_security_group.terraform-sg.id]
  subnet_id              = aws_subnet.terraform_subnet-01.id
  for_each               = toset(["Jenkins-master", "build-slave", "Ansible"])
  tags = {
    Name = "${each.key}"
  }
}

data "aws_key_pair" "terraform_key" {
  # key_name = "project_f key on us-west-1"
  key_pair_id = "key-0f580417e6094e159"
}

output "aws_instance_ip" {
  value = {
    for instance in aws_instance.web :
    instance.tags.Name => instance.public_ip
  }
}

  module "sgs" {
    source = "../SG_EKS"
    vpc_id     =     aws_vpc.terraform_vpc.id
 }

  module "eks" {
       source = "../EKS"
       vpc_id     =     aws_vpc.terraform_vpc.id
       subnet_ids = [aws_subnet.terraform_subnet-01.id,aws_subnet.terraform_subnet-02.id]
       sg_ids = module.sgs.security_group_public
 }