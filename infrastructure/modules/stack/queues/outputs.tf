output "queue_external_id" {
  value = aws_sqs_queue.goobi_external.id
}

output "queue_command_id" {
  value = aws_sqs_queue.goobi_command.id
}

output "queue_command_name" {
  value = aws_sqs_queue.goobi_command.name
}

output "queue_external_name" {
  value = aws_sqs_queue.goobi_external.name
}
