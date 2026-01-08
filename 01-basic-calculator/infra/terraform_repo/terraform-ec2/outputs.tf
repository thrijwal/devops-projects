output "instance_ips" {
  description = "Public IPs of the created instances"
  value       = aws_instance.ec2_instances[*].public_ip
}
