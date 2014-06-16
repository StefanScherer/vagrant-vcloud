[Vagrant](http://www.vagrantup.com) provider for VMware vCloud Director®
=============

[Version 0.4.0](../../releases/tag/v0.4.0) has been released!
-------------

Please note that this software is still Alpha/Beta quality and is not recommended for production usage.

We have a wide array of boxes available at [Vagrant Cloud](https://vagrantcloud.com/gosddc) you can use them directly or you can roll your own as you please, make sure to install VMware tools in it.

If you're unsure about what are the correct network settings for your Vagrantfile make sure to check out the [Network Deployment Options](https://github.com/frapposelli/vagrant-vcloud/wiki/Network-Deployment-Options) wiki page.

Check the full releases changelog [here](../../releases)

Install
-------------

Latest version can be easily installed by running the following command:

```vagrant plugin install vagrant-vcloud```

Vagrant will download all the required gems during the installation process.

After the install has completed a ```vagrant up --provider=vcloud``` will trigger the newly installed provider.

Configuration
-------------

Here's a sample Multi-VM Vagrantfile, please note that ```vcloud.vdc_edge_gateway``` and ```vcloud.vdc_edge_gateway_ip``` are required only when you cannot access ```vcloud.vdc_network_name``` directly and there's an Organization Edge between your workstation and the vCloud Network.

```ruby
nodes = [
  { hostname: 'web-vm', box: 'gosddc/precise32' },
  { hostname: 'ssh-vm', box: 'gosddc/precise32' },
  { hostname: 'sql-vm', box: 'gosddc/precise32' },
  { hostname: 'app-vm', box: 'gosddc/precise32' }
]

Vagrant.configure('2') do |config|

  # vCloud Director provider settings
  config.vm.provider :vcloud do |vcloud|
    vcloud.vapp_prefix = 'multibox-sample'

    vcloud.hostname = 'https://my.cloudprovider.com'
    vcloud.username = 'MyUserName'
    vcloud.password = 'MySup3rS3cr3tPassw0rd!'

    vcloud.org_name = 'OrganizationName'
    vcloud.vdc_name = 'vDC_Name'

    vcloud.catalog_name = 'Vagrant'
    vcloud.ip_subnet = '172.16.32.125/255.255.255.240'

    vcloud.vdc_network_name = 'MyNetwork'

    vcloud.vdc_edge_gateway = 'MyOrgEdgeGateway'
    vcloud.vdc_edge_gateway_ip = '10.10.10.10'
  end

  nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = node[:box]
      node_config.vm.hostname = node[:hostname]
      node_config.vm.box_url = node[:box_url]
      node_config.vm.network :forwarded_port,
                             guest: 80,
                             host: 8080,
                             auto_correct: true
      # node_config.vm.provision :puppet do |puppet|
      #   puppet.manifests_path = 'puppet/manifests'
      #   puppet.manifest_file = 'site.pp'
      #   puppet.module_path = 'puppet/modules'
      # end
    end
  end
end
```

For additional documentation on different network setups with vCloud Director, check the [Network Deployment Options](../../wiki/Network-Deployment-Options) Wiki page

Contribute
-------------

What is still missing:

- TEST SUITES! (working on that).
- Speed, the code is definitely not optimized.
- Permission checks, make sure you have at least Catalog Admin privileges if you want to upload boxes to vCloud.
- Thorough testing.
- Error checking is absymal.
- Some spaghetti code here and there.
- Bugs, bugs and BUGS!.

If you're a developer and want to lend us a hand, head over to our ```develop``` branch and send us PRs!


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/frapposelli/vagrant-vcloud/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
