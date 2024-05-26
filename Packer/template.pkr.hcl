locals {
  timestamp = formatdate("YYYY-MM-DD'T'hh-mm-ss", timestamp())
  build_id  = "win2019-${local.timestamp}"
  version   = "1.0.${local.timestamp}"
}

variable "cloud_token" {
  type    = string
  default = ""
}

source "virtualbox-iso" "example" {
  vm_name             = local.build_id
  guest_os_type       = "Windows10_64"
  iso_url             = "https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
  iso_checksum        = "sha256:549bca46c055157291be6c22a3aaaed8330e78ef4382c99ee82c896426a1cee1"
  iso_target_path = "E:\\ISO"
  headless            = false
  vboxmanage = [
    ["modifyvm", "{{.Name}}", "--memory", "4096"],
    ["modifyvm", "{{.Name}}", "--cpus", "2"]
  ]
  disk_size           = 20480
  boot_wait           = "10s"
  communicator        = "winrm"
  winrm_username = "vagrant"
  winrm_password = "vagrant"
  winrm_port     = 5985  # 5986 для SSL
  winrm_use_ssl  = false # Используйте true и winrm_insecure = true для SSL
  winrm_insecure = false # Установите в true, если используете самоподписанные сертификаты
  winrm_timeout  = "3m"
  guest_additions_mode = "disable"
  shutdown_command    = "A:/shutdown.cmd"
  shutdown_timeout    = "10m"
  post_shutdown_delay = "5s"
  output_directory    = "./out-${local.build_id}"
  
  floppy_files = ["floppy"]
}

build {
  sources = [
    "source.virtualbox-iso.example"
  ]

  post-processor "vagrant" {
    output = "${local.build_id}_virtualbox.box"
    compression_level = 9
    vagrantfile_template = "Vagrantfile.tpl"
  }
}
