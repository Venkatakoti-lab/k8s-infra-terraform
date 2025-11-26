resource "aws_instance" "this" {
  ami           = data.aws_ami.expense.id
  instance_type = "t2.medium"
  vpc_security_group_ids = [ aws_security_group.allow_ssh.id ]
  root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }
  user_data = file("docker.sh")
  tags = {
    Name = "k8s"
  }
}
resource "aws_security_group" "allow_ssh" {
  name        = "allow-ssh"
  description = "this sg for k8s"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg-k8s"
  }
}