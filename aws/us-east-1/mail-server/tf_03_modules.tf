module "ec2" {
  source       = "../../modules/ec2"
  project_name = "mail-server"
  tags = {
    "Description" = "A mail server."
  }
}