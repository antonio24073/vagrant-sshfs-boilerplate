
# Vagrant and SSHFS Boilerplate

This is a VMs auto-generator with vagrant and libvirt. 
You can configure it to work with virtualbox in your fork.
You can specify multiple VMs at the same time.

Dependencies:
- vagrant
- libvirt
- virt-manager
- fuse-sshfs (if you want to sync folders)

Search for installation in the internet.

An example of Fedora installation:

```
sudo dnf install virt-manager libvirt-devel libxslt-devel libxml2-devel vagrant qemu-img vagrant-libvirt qemu qemu-kvm libvirt-clients libvirt-daemon-system virtinst bridge-utils fuse-sshfs -y
```


## Steps:

Configure your `Vagrantfile` and create your provision file  (sh) in the `provision` folder and run:

```
vagrant up --no-parallel
vagrant up --no-parallel --debug
```

To mount synced directory you can use:

```
vagrant status
sh sshfs.sh  --virtual-machine=alpine-1 --folder=project1
sh sshfs.sh -vm=alpine-1 -f=project1
```

It will generate a folder in the VM home folder.

Don't forget to umount:

```
ls -la
umount projetc1
umount name-of-your-folder
```

