#!/bin/sh

## sh sync-qty.sh 2

for i in "$@"; do
  case $i in
    -q=*|--qty=*)
      _QTY="${i#*=}"
      ;;
    -p=*|--prefix=*)
      _PREFIX="${i#*=}"
      ;;
    -b=*|--box=*)
      _BOX="${i#*=}"
      ;;
    -c=*|--cpus=*)
      _CPUS="${i#*=}"
      ;;
    -m=*|--memory=*)
      _MEMORY="${i#*=}"
      ;;
    -f=*|--folder=*)
      _FOLDER="${i#*=}"
      ;;
    --debug)
      _DEBUG="${i}"
      ;;
    --destroy)
      _DESTROY="${i}"
      ;;
    -h=*|--help=*)
      echo "Unknown option $i"
      exit 1
      ;;
    -*|--*)
      echo "Unknown option $i. Set -h to help."
      exit 1
      ;;
  esac
done
set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

# keep this for debugging propouses
# echo ${_FOLDER};
# echo ${_PREFIX};
# echo ${_QTY};
# echo ${_BOX};
# echo ${_CPUS};
# echo ${_MEMORY};
# echo ${_DEBUG};
# echo ${_DESTROY};


if [ "${_DESTROY}" == '--destroy' ]
then
    sh -c "cd ${_FOLDER} && FOLDER=${_FOLDER} PREFIX=${_PREFIX} QTY=${_QTY} BOX=${_BOX} CPUS=${_CPUS} MEMORY=${_MEMORY} vagrant destroy ${_DEBUG}"
    umount ${_FOLDER}/${_PREFIX}$i
    exit 1
fi

for ((i=1;i<=${_QTY};i++)); 
do 
    sh -c "cd ${_FOLDER} && FOLDER=${_FOLDER} PREFIX=${_PREFIX} QTY=${_QTY} BOX=${_BOX} CPUS=${_CPUS} MEMORY=${_MEMORY} vagrant up --no-parallel ${_DEBUG}"
    ip=$(vagrant ssh ${_PREFIX}$i -c "ip address show eth0 | grep 'inet ' | sed -e 's/^.*inet //' -e 's/\/.*$//' | tr -d '\n'" 2>/dev/null)
    vagrant ssh ${_PREFIX}$i -c "mkdir /home/vagrant/project"
    mkdir ${_FOLDER}/${_PREFIX}$i
    sshpass -p vagrant sshfs -o StrictHostKeyChecking=no,debug -f vagrant@$ip:/home/vagrant/project/ ${_FOLDER}/${_PREFIX}$i
done
