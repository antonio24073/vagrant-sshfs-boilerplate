require 'json'

vms = {
	# 'debian' => {
	# 	'memory' => '512', 'cpus' => '1', 'ip' => '10', 'box' => 'debian/stretch64', 'provision' => 'debian-server.sh'
	# },
	# 'ubuntu' => {
	# 	'memory' => '512', 'cpus' => '1', 'ip' => '11', 'box' => 'ubuntu/xenial64', 'provision' => 'ubuntu-server.sh'
	# },
	'alpine' => {
		'qty' => '2', 
        'memory' => '256', 
        'cpus' => '1', 
        'box' => 'generic/alpine312', 
        'provision' => 'generic-alpine312.sh'
	}
}


vms.each do |name, conf|
    Vagrant.configure("2") do |config|
        (1..(conf['qty'].to_i)).each do |i|
            vm_name = "#{name}-#{i}"
            config.vm.define "#{vm_name}" do |node|
                node.vm.hostname = "#{vm_name}.vm.local"
                node.vm.box = conf['box']
                node.vm.network :public_network,
                    :dev => "virbr0",
                    :mode => "bridge",
                    :type => "bridge"
                node.vm.box_check_update = true
                node.vm.provision 'shell', path: "provision/#{conf['provision']}"
                node.vm.provider "libvirt"  do |lv|
                    lv.memory = conf['memory']
                    lv.cpus = conf['cpus']
                end

                # keep this below to disable NFS
                node.nfs.verify_installed = false 
                node.vm.synced_folder "#{conf['folder']}/#{vm_name}-#{i}", "/home/vagrant/vagrant_project", type: "rsync", disabled: true 
            end
        end
    end
end
