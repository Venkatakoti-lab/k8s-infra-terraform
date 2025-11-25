output "ips" {
  value= {
    public_ip = aws_instance.this.public_ip
    private_ip = aws_instance.this.private_ip
  }
  
}