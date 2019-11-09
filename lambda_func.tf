resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = "${file("roles/lambda_role.json")}"
}

resource "aws_lambda_function" "switch-policies-lambda" {
  filename      = "switch-policies-lambda-comp.zip"
  function_name = "switch-policies-lambda"
  role          = "arn:aws:iam::908574644363:role/iam_for_lambda"
  handler       = "exports.test"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = "${filebase64sha256("switch-policies-lambda-comp.zip")}"

  runtime = "python3.7"

  environment {
    variables = {
      foo = "bar"
    }
  }
  
}

resource "aws_iam_policy_attachment" "admin-attach-lambda" {
  name       = "admin-attachment-lambda"
  roles      = ["iam_for_lambda"]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "switch-policies-lambda"
  principal     = "events.amazonaws.com"
  source_arn    = "arn:aws:events:eu-west-1:111122223333:rule/RunDaily"
}