vms = {
    # 'alpine-3-17-2' => {
    #     'qty' => '2', 
    #     'memory' => '1', 
    #     'cpus' => '1',
    #     'swap' => '1',
    #     'box' => 'generic/alpine317', 
    #     'provision' => 'generic-alpine317.sh',
    #     'storage_pool_name' => 'HD1',
        # 'boot_timeout' => 180,
        # 'disk_size' => 20
    # },
    # 'centos-7' => {
    #     'qty' => 1, 
    #     'cpus' => 2,
    #     'memory' => 2,
    #     'swap' => 2,
    #     'box' => 'centos/7',
    #     'provision' => 'centos-7.sh', 
    #     'storage_pool_name' => 'HD1',
        # 'boot_timeout' => 180,
        # 'disk_size' => 20
    # }
    # 'almalinux-8' => {
    #     'qty' => 1, 
    #     'cpus' => 2,
    #     'memory' => 2,
    #     'swap' => 2,
    #     'box' => 'almalinux/8',
    #     'provision' => 'almalinux-8.sh', 
    #     'storage_pool_name' => 'HD1', 
        # 'boot_timeout' => 180,
        # 'disk_size' => 20
    # },
    # 'generic-ubuntu2004' => {
    #     'qty' => 1, 
    #     'cpus' => 2,
    #     'memory' => 4,
    #     'swap' => 2,
    #     'box' => 'generic/ubuntu2004',
    #     'provision' => 'generic-ubuntu2004.sh',
    #     'storage_pool_name' => 'HD1',
        # 'boot_timeout' => 180,
        # 'disk_size' => 40
    # },
    # 'gusztavvargadr-windows-11' => {
    #     'qty' => 1, 
    #     'cpus' => 2,
    #     'memory' => 5,
    #     'swap' => 'not implemented',
    #     'box' => 'gusztavvargadr/windows-11',
    #     'provision' => 'gusztavvargadr-windows-11.sh',
    #     'storage_pool_name' => '',
    #     'boot_timeout' => 720,
        # 'disk_size' => 50
    # },
    # 'nick-invision-macos-bigsur-base' => { # not working yet
    #     'qty' => 1, 
    #     'cpus' => 2,
    #     'memory' => 6,
    #     'swap' => 'not implemented',
    #     'box' => 'nick-invision/macos-bigsur-base',
    #     'provision' => 'nick-invision-macos-bigsur-base.sh',
    #     'storage_pool_name' => '',
    #     'boot_timeout' => 720,
    #     'disk_size' => 60
    # },
}
vms.each do |name, conf|
    Vagrant.configure("2") do |config|
        config.env.enable
        (1..(conf['qty'].to_i)).each do |i|
            vm_name = "#{name}-#{i}"
            hostname = "#{vm_name}.vm.local"
            config.vm.define "#{vm_name}" do |node|
                node.vm.hostname = hostname
                node.ssh.insert_key = false
                node.vm.boot_timeout = conf['boot_timeout']
                node.vm.disk :disk, size: conf['disk_size'].to_s+"GB", primary: true, name: "disk-#{vm_name}"
                node.vm.provider "virtualbox" do |v|
                    v.gui = true
                    v.customize ["modifyvm", :id, "--memory", conf['memory'].to_i*1024, "--cpus", conf['cpus'], "--name", "#{vm_name}"]
                    v.customize ['modifyvm', :id, '--graphicscontroller', 'vmsvga']
                    v.customize ["modifyvm", :id, "--vrde", "off"]
                    v.customize ["modifyvm", :id, "--cableconnected1", "on"]
                    v.customize ["setproperty", "machinefolder", ENV['MACHINEFOLDER'] ]
                end
                node.vm.provider "libvirt"  do |lv|
                    lv.cpus = conf['cpus'].to_i
                    lv.memory = conf['memory'].to_i*1024
                    lv.graphics_type = "spice"
                    lv.keymap = "pt-br"
                    lv.machine_arch = "x86_64"
                    # lv.qemu_use_session = false ## it's working fine without this
                    lv.storage_pool_name = conf['storage_pool_name']
                    # keep this below to disable NFS
                    node.nfs.verify_installed = false 
                    node.vm.synced_folder "synced_folders/#{vm_name}", "/home/vagrant/project", type: "nfs", disabled: true 
                end
                node.vm.box = conf['box']
                node.vm.box_check_update = false
                node.vm.provision 'shell', 
                    path: "provision/#{conf['provision']}", 
                    env: { 
                            "SWAP" => conf['swap'],
                            "HOSTNAME" => hostname
                        },
                    reboot: true
            end
        end
    end
end
