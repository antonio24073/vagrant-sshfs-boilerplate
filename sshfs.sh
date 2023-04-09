#!/bin/sh

## sh sshfs.sh --help
## sh sshfs.sh --virtual-machine=alpine-1 --folder=project1
## sh sshfs.sh -vm=alpine-1 -f=project1

for i in "$@"; do
  case $i in
    -f=*|--folder=*)
      _FOLDER="${i#*=}"
      ;;
    -vm=*|--virtual-machine=*)
      _VM="${i#*=}"
      ;;
    -h=*|--help=*)
      echo "sh sshfs.sh --virtual-machine=alpine-1 --folder=project1"
      echo "sh sshfs.sh -vm=alpine-1 -f=project1"
      exit 1
      ;;
    -*|--*)
      echo "Unknown option $i. Set -h to help."
      exit 1
      ;;
  esac
done
set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

ip=$(vagrant ssh ${_VM} -c "ip address show eth0 | grep 'inet ' | sed -e 's/^.*inet //' -e 's/\/.*$//' | tr -d '\n'" 2>/dev/null)
vagrant ssh ${_VM} -c "mkdir /home/vagrant/${_FOLDER}"
mkdir "$(pwd)/${_FOLDER}"
sshpass -p vagrant sshfs -o StrictHostKeyChecking=no,debug -f vagrant@$ip:"/home/vagrant/${_FOLDER}/" "$(pwd)/${_FOLDER}"
exit 1

