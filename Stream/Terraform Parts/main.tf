# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "esxi" {
  esxi_hostname      = var.esxi_server
  esxi_hostport      = "22"
  esxi_hostssl       = "443"
  esxi_username      = var.esxi_user
  esxi_password      = var.esxi_password
}

resource "esxi_guest" "vmtest" {
  guest_name = "Ubuntu Test"
  disk_store = "BIG SSD"
  memsize = "2048"
  numvcpus = "2"

  #
  #  Specify an existing guest to clone, an ovf source, or neither to build a bare-metal guest vm.
  #
  #clone_from_vm      = "Templates/centos7"
  #ovf_source        = "/local_path/centos-7.vmx"

  network_interfaces {
    virtual_network = "VM Network"
    nic_type = "VMXNET 3"
  }
}

# data "vsphere_datacenter" "datacenter" {
#   name = var.datacenter
# }

# data "vsphere_datastore" "datastore" {
#   name          = var.datastore
#   datacenter_id = data.vsphere_datacenter.datacenter.id
# }

# data "vsphere_compute_cluster" "cluster" {
#   name          = var.cluster
#   datacenter_id = data.vsphere_datacenter.datacenter.id
# }

# data "vsphere_network" "network" {
#   name          = var.network_name
#   datacenter_id = data.vsphere_datacenter.datacenter.id
# }

# data "vsphere_virtual_machine" "ubuntu" {
#   name          = "/${var.datacenter}/vm/${var.ubuntu_name}"
#   datacenter_id = data.vsphere_datacenter.datacenter.id
# }

# resource "vsphere_virtual_machine" "learn" {
#   name             = "learn-terraform"
#   resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
#   datastore_id     = data.vsphere_datastore.datastore.id

#   num_cpus = 2
#   memory   = 1024

#   network_interface {
#     network_id = data.vsphere_network.network.id
#   }

#   wait_for_guest_net_timeout = -1
#   wait_for_guest_ip_timeout  = -1

#   disk {
#     label            = "disk0"
#     thin_provisioned = true
#     size             = 32
#   }

#   guest_id = "ubuntu64Guest"

#   clone {
#     template_uuid = data.vsphere_virtual_machine.ubuntu.id
#   }
# }

# output "vm_ip" {
#   value = vsphere_virtual_machine.learn.guest_ip_addresses
# }