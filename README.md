
Vagrant and SSHFS Boilerplate
==============================

Create virtual machines automatically and sync your project folders.

This is a boilerplate project for the vagrant and libvirt. 

You can configure it to work with virtualbox in your fork.

------------------------------

## Dependencies:

- vagrant
- libvirt
- virt-manager (if you want to view the VMs)
- fuse-sshfs (if you want to sync folders)

Search for installation in the internet.

An example of Fedora installation:

```
sudo dnf install virt-manager libvirt-devel libxslt-devel libxml2-devel vagrant qemu-img vagrant-libvirt qemu qemu-kvm libvirt-clients libvirt-daemon-system virtinst bridge-utils fuse-sshfs -y
```

------------------------------

## Steps

Configure your `Vagrantfile` and create your provision file  (sh) in the `provision` folder and run:

```
vagrant up --no-parallel
vagrant up --no-parallel --debug
```

------------------------------

## Synced directory

To mount synced directory you can use:

```
vagrant status
sh sshfs.sh  --virtual-machine=alpine-1 --folder=project
sh sshfs.sh -vm=alpine-1 -f=project
```

It will generate a folder in the VM home folder.

Don't forget to umount:

```
ls -la
umount project1
umount name-of-your-folder
```

------------------------------

## Remove VMs

To remove all VMs

```
vagrant destroy
```

------------------------------

## Networks

- To more advanced networks in the host, (search in youtube) you can use GUIs like:

```
nm-connection-editor
```

------------------------------

Tested with `libvirt` and `virt-manager`

Not tested with `virtualbox`