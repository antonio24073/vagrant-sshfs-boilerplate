
# Vagrant Boilerplate




```
FOLDER=${pwd} PREFIX=vm QTY=2 BOX=generic/alpine312 CPUS=1 MEMORY=256 vagrant up --debug
FOLDER=${pwd} PREFIX=vm QTY=2 BOX=generic/alpine312 CPUS=1 MEMORY=256 vagrant destroy 
```

```
sh vagrant.sh -p=vm -f=$(pwd) -b=generic/alpine317 -q=2 -m=256 -c=1 --debug
sh vagrant.sh -p=vm -f=$(pwd) -b=generic/alpine317 -q=2 -m=256 -c=1 --destroy
```