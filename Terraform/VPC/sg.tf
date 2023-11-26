variable "sg_ingress" {
  type        = list(number)
  description = "Allow inbound traffic"
  default     = [443, 22, 80,8080]
}
resource "aws_security_group" "terraform-sg" {
  name        = "terraform-sg"
  description = "ingress for cicd"
  vpc_id      = aws_vpc.terraform_vpc.id

  dynamic "ingress" {
    for_each = var.sg_ingress
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      
    }
  }
  egress {
    description = "Allow All outgoing traffic"
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
