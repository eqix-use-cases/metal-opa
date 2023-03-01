// ssh-key
module "key" {
  source     = "git::github.com/andrewpopa/terraform-metal-project-ssh-key"
  project_id = var.project_id
}

data "template_file" "user_data" {
  template = file("boot/boot.sh")
}

// device
module "device" {
  source              = "git::github.com/andrewpopa/terraform-metal-device.git"
  hostname            = "metal-with-opa"
  plan                = "m3.large.x86"
  facilities          = ["am6"]
  operating_system    = "ubuntu_18_04"
  billing_cycle       = "hourly"
  project_id          = var.project_id
  project_ssh_key_ids = [module.key.id]
  user_data           = data.template_file.user_data.rendered
}
