provider "vsphere" {
    user        = var.vsphere_user
    password    = var.vsphere_password
    vsphere_server = var.vsphere_server

    allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
    name = "Datacenter1"
}

data "vsphere_datastore" "datastore" {
    name        = "vmContainer1"
    datacenter_id = "${data.vsphere_datacenter.dc.datacenter_id}"
}

data "vsphere_compute_cluster" "cluster" {
    name        = "Cluster1"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
    name        = "LAB Network"
    datacenter_id = "${data.vsphere_datacenter.dc.datacenter_id}"
}

resource "vsphere_virtual_machine" "vm" {
    name            = "terraform-test"
    datastore_id    = "${data.vsphere_datastore.datastore_id}"

    num_cpus = 2
    memory   = 1024
    guest_id = "other3xLinux64Guest"

    network_interface {
        network_id = "${data.vsphere_network.network.id}"
    }

    disk {
        label ="disk 0"
        size = 20
    }
}