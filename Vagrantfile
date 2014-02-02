Vagrant.configure("2") do |config|
    config.vm.box = "raring32"
    config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-i386-vagrant-disk1.box"

    config.vm.provision :shell, :path => "./vagrant-setup.sh"

    config.vm.hostname = "dev.posib.lan"
    config.vm.network :public_network, ip: "192.168.1.222", :bridge => "en0: Ethernet"

    config.vm.provider "virtualbox" do |v|
      v.name = "[krkn] posib."
    end
end
