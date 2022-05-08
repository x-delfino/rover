# VM Hub

A collection of templates and playbooks to create and provision VMs using:
- [Packer](https://www.packer.io/)
- [Ansible](https://www.ansible.com/)
- [Vagrant](https://www.vagrantup.com/)

## Base boxes

The Packer templates are for building base Vagrant boxes, these have minimal programs installed:
- Default programs (kali has no metapackage)
- VM tools (currently only parallels supported)
- OpenSSH

These base boxes are available on [Vagrant Cloud](https://app.vagrantup.com/delfino):
- [kali-2022.1-arm64](https://app.vagrantup.com/delfino/boxes/kali-2022.1-arm64)
- [debian-11.3-arm64](https://app.vagrantup.com/delfino/boxes/debian11.3-arm64)

## Provisioning 'full' box

Additional Ansible playbooks and roles are available to fully provision the VM with tools and programs etc. A template Vagrantfile and associated variables can be used to configure the various options, further info pending...
