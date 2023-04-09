Vagrant.configure("2") do |config|
    (1..ENV['QTY'].to_i).each do |i|
        config.vm.define "vm1" do |node|
            node.vm.provider "libvirt"  do |lv|
                lv.memory = ENV['MEMORY']
                lv.cpus = ENV['CPUS']
            end
            node.vm.box = ENV['BOX']
            node.vm.network :public_network,
                :dev => "virbr0",
                :mode => "bridge",
                :type => "bridge"
            node.vm.box_check_update = true

            # keep this below to disable NFS
            node.nfs.verify_installed = false 
            node.vm.synced_folder "#{ENV['FOLDER']}/#{ENV['PREFIX']}#{i}", "/home/vagrant/vagrant_project", type: "rsync", disabled: true 
        end
    end
end

