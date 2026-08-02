resource "aws_key_pair" "iac-key-pair" {
  key_name   = "iac-project-key"
  public_key = file("C:/Users/ganes/.ssh/iac-project-key.pub")
}