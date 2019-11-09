# resource "aws_cloudwatch_event_rule" "swap-cloudwatch" {
#   name        = "swap-cloudwatch"
  
#   schedule_expression = "rate(10 minutes)"
# }

# resource "aws_cloudwatch_event_target" "yada" {
#   target_id = "Yada"
#   rule      = "swap-cloudwatch"
#   arn       = "${aws_kinesis_stream.test_stream.arn}"

#   run_command_targets {
#     key    = "tag:Name"
#     values = ["FooBar"]
#   }

#   run_command_targets {
#     key    = "InstanceIds"
#     values = ["i-162058cd308bffec2"]
#   }
# }
