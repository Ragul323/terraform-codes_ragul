resource "aws_lambda_function" "stop_rds_lambda" {
    function_name = "stop_rds_lambda_function"
    role          = aws_iam_role.lambda_rds_stop_role.arn
    handler       = "stop_rds.lambda_handler"
    runtime       = "python3.8"
    filename      = "stop_rds.py"
    environment {
      variables = {
        RDS_INSTANCE_ID = aws_db_instance.navin_rds.id
      }
    }
  }