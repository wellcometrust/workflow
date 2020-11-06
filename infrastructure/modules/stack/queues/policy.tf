data "aws_iam_policy_document" "read_write_queue" {

  statement {
    actions = [
      "sqs:DeleteMessage",
      "sqs:GetQueueUrl",
      "sqs:SendMessage",
      "sqs:ReceiveMessage",
    ]

    resources = [
      aws_sqs_queue.goobi_external.arn,
      aws_sqs_queue.goobi_command.arn
    ]
  }

}
