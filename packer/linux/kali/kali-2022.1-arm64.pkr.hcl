packer {
  required_plugins {
    parallels = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/parallels"
    }
  }
}

# Variables

variable "box_basename" {
  type    = string
  default = "kali-2022.1-arm64"
}

variable "hostname" {
  type    = string
  default = "kali"
}

variable "build_directory" {
  type    = string
  default = "../../builds"
}

variable "cpus" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "65536"
}

variable "iso_checksum" {
  type    = string
  default = "sha256:1b3042badf87544ab4031bae44a45619d5abd7113fdf7a5e2b6202516e3007ea"
}

variable "iso_name" {
  type    = string
  default = "kali-linux-2022.1-installer-netinst-arm64.iso"
}

variable "memory" {
  type    = string
  default = "1024"
}

variable "mirror" {
  type    = string
  default = "https://cdimage.kali.org"
}

variable "mirror_directory" {
  type    = string
  default = "kali-2022.1"
}

variable "preseed_path" {
  type    = string
  default = "kali-preseed.cfg"
}

variable "vm_name" {
  type    = string
  default = "kali-2022.1-arm64"
}

locals {
  build_timestamp = "${formatdate("YYYY-MM-DD", timestamp())}"
  http_directory  = "${path.root}/../http"
}

source "parallels-iso" "kali-install" {
  boot_command           = ["e<wait>", "<down><down><down><right><right><right><right><right><right><right><right><right><right>", "<right><right><right><right><right><right><right><right><right><right><right><right><right>", "<right><right><right><right><right><right><right><right><right><right><right>", "install ", " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.preseed_path} ", "auto ", "locale=en_US.UTF-8 ", "keyboard-configuration/xkb-keymap=us ", "netcfg/get_hostname=${var.hostname} ", "netcfg/get_domain= ", "<f10>"]
  boot_wait              = "5s"
  cpus                   = "${var.cpus}"
  disk_size              = "${var.disk_size}"
  guest_os_type          = "kali"
  http_directory         = "${local.http_directory}"
  iso_checksum           = "${var.iso_checksum}"
  iso_url                = "${var.mirror}/${var.mirror_directory}/${var.iso_name}"
  memory                 = "${var.memory}"
  output_directory       = "${var.build_directory}/packer-${var.vm_name}-parallels"
  parallels_tools_flavor = "lin-arm"
  prlctl_version_file    = ".prlctl_version"
  shutdown_command       = "echo 'vagrant' | sudo -S /sbin/shutdown -hP now"
  ssh_password           = "vagrant"
  ssh_port               = 22
  ssh_timeout            = "10000s"
  ssh_username           = "vagrant"
  vm_name                = "${var.vm_name}"
}

build {
  sources = ["source.parallels-iso.kali-install"]

  provisioner "ansible" {
    playbook_file = "../../../ansible/main.yml"
    groups = ["vagrant", "base_box", "parallels"]
    user = "vagrant"

  }

  post-processor "vagrant" {
    output = "${var.build_directory}/${var.box_basename}.{{ .Provider }}.box"
  }
}
