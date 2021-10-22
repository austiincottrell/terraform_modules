output "id" {
  value = aws_security_group.my_sg.*.id
}

output "arn" {
  value = aws_security_group.my_sg.*.arn
}