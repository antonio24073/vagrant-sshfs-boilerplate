
Vagrant and SSHFS Boilerplate
=============================

Create virtual machines automatically and sync your project folders.

This is a boilerplate project for the vagrant and libvirt. 

You can configure it to work with virtualbox in your fork.

------------------------------

## Provisions Examples:

- Almalinux 8
- Centos 7
- Ubuntu Focal 20.04
- Alpine 3.17.2
- MacOS Big Sur
- Windows 11

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

```
echo "export VAGRANT_HOME=/run/media/user/HD1/vagrant" >> ~/.bash_profile
```

Configure your `Vagrantfile` and customize your provision file (sh) in the `provision` folder and run (one option below):

```
vagrant up --no-parallel
vagrant up --no-parallel --debug
vagrant up --provider=virtualbox
vagrant up --provider=libvirt
```

------------------------------

## Synced directory

To mount synced directory you can use:

```
vagrant status
sh sshfs.sh --virtual-machine=alpine-1 --folder=project
sh sshfs.sh -vm=alpine-1 -f=project
```

It will generate a folder in the VM home folder and another in your host current path (pwd).

To mount a volume in another path (host), you can do:

```
vagrant status
sh sshfs.sh --virtual-machine=alpine-1 --folder=project --path=/home/user/Documents
sh sshfs.sh -vm=alpine-1 -f=project --p=/home/user/Documents
```


```
vagrant status
sh sshfs.sh  --virtual-machine=alpine-1 --folder=project
sh sshfs.sh -vm=alpine-1 -f=project
```

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

To more advanced networks in the host, (search in youtube) you can use GUIs like:

```
nm-connection-editor
```

------------------------------

## Transform virtualbox boxes in libvirt boxes

```
vagrant box add ubuntu/focal64
vagrant mutate ubuntu/focal64 libvirt
vagrant box remove ubuntu/focal64 --provider=virtualbox
```

But `ubuntu/focal64` not working in libvirt, I replaced it with `generic/ubuntu2004`

------------------------------

Tested with `libvirt` and `virt-manager`

Tested with `virtualbox`

------------------------------

## Related projects:

- [Vagrant WHM CPanel Local](https://github.com/antonio24073/vagrant-whm-cpanel-local)




------------------------------

# Donations

Help keep projects free:

https://www.paypal.com/donate/?business=X3W3QTHS7BDW4&no_recurring=0&item_name=Help+me+to+continue+the+free+projects&currency_code=BRL
