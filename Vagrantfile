Vagrant.configure(2) do |config|

    config.vm.box = "debian-11.2-arm64"

    config.vm.provision "ansible" do |ansible|
        ansible.verbose = "v"
	ansible.playbook = "playbook.yml"
    end
end
