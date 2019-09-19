
domain = 'zabbix'

nodes = [
  {
    :hostname => 'zabbix-server',
    :ip => '10.0.0.100',
    :id => '10',
    :port => '2100',
    :memory => 1024,
    :size => '5GB',
    :box => 'ubuntu/bionic64'
  },
  {
    :hostname => 'zabbix-proxy',
    :ip => '10.0.0.101',
    :id => '11',
    :port => '2101',
    :memory => 1024,
    :size => '5GB',
    :box => 'ubuntu/bionic64'
  },
  {
    :hostname => 'zabbix-agent-linux',
    :ip => '10.0.0.102',
    :id => '12',
    :port => '2102',
    :memory => 1024,
    :size => '2GB',
    :box => 'ubuntu/bionic64'
  },
  {
    :hostname => 'zabbix-agent-windows',
    :ip => '10.0.0.103',
    :id => '13',
    :port => '2103',
    :memory => 1024,
    :size => '10GB',
    :box => 'gusztavvargadr/windows-server'
  }
]

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:box]
      nodeconfig.disksize.size = node[:size]
      nodeconfig.vm.hostname = node[:hostname]
      nodeconfig.vm.boot_timeout = 300
      nodeconfig.vm.network :forwarded_port, guest: 22, host: node[:port], id: "ssh", auto_correct: true
      nodeconfig.vm.network :private_network, ip: node[:ip]
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.name = node[:hostname]
        vb.memory = node[:memory]
        vb.cpus = 2
        vb.gui = false
        vb.customize ['modifyvm', :id, '--macaddress1', "5CA1AB1E00"+node[:id]]
      end
    end
  end
end
