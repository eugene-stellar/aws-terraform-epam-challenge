resource "aws_key_pair" "key_pair" {

  key_name   = var.ssh_key_pair_name
  public_key = var.ssh_key

  tags = {
    Project = "epam-tf-lab"
    ID      = "cmtr-gy0ttqu8"
  }
}