resource "aws_instance" "instance" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  subnet_id              = data.terraform_remote_state.base_infra.outputs.public_subnet_id
  vpc_security_group_ids = [data.terraform_remote_state.base_infra.outputs.security_group_id]

  tags = {
    Project   = var.project_id
    Terraform = "true"
  }
}