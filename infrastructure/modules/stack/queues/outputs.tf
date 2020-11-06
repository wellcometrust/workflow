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

output "read_write_policy" {
  description = "Policy that allows reading from and writing the created SQS queues"
  value       = data.aws_iam_policy_document.read_write_queue.json
}