resource "aws_sqs_queue" "goobi_job" {
  name = "${var.name}_goobi_job.fifo"

  fifo_queue = true

}

resource "aws_sqs_queue" "goobi_command" {
  name = "${var.name}_goobi_command.fifo"

  fifo_queue = true

}
