# Dreadnought

### HAProxy Demonstration

Dreadnought was designed to be a simulation of the real world challenges encountered as a DevOps engineer.
The name is inspired by the largest attack vessels in the Star Wars universe, the Star Dreadnought class of Super Star Destroyer.
The basic premise of the project is the proxying of requests by HAProxy based on domain name via host headers.
The project consists of multiple virtual machines with the following structure:

* `lb` - Routes requests with HAProxy
* `web1` - Runs Wordpress (blog.example.com) and Magento 2 (shop.example.com)
* `web2` - Runs NodeBB (forum.example.com)
* `data` - MongoDB and MySQL database server
* `elk` - ELK stack: Elasticsearch, Logstash, Kibana (elk.example.com)

A `Vagrantfile` is included which automates the creation of these virtual machines, as well as the creation of host file entries assigning the `*.example.com` domain names to the `lb` machine.

The project is provisioned using Ansible roles. After completion of provisioning, the user can navigate to any of the aforementioned web addresses and view the expected application. All routing is handled by HAProxy using host headers.