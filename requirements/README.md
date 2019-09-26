# Installation scripts for the software required to deploy a Kubernetes cluster using rke

## Requirements

- On master nodes:
        * docker
        * kubectl
        * helm
        * rke
        * git
        * wget

- On worker nodes:
        * docker
        * git
        * wget


To install docker and kubectl you need to be root, but not for helm and rke.

## Make sure the nodes can see each other

        firewall-cmd --permanent --zone=trusted --add-source=<<range of trusted ip>>
        firewall-cmd --reload

In our case 

        firewall-cmd --permanent --zone=trusted --add-source=192.168.33.0/24
        firewall-cmd --permanent --zone=trusted --add-source=10.0.2.0/24
        firewall-cmd --reload
        
## Make sure the nodes are synchronized, if not use ntp to synchronise them

## Proxy

I didn't had the time to understand how it works and what is necessary, here are my config files on both nodes

        cat ~/.docker/config.json 
        {
         "proxies":
         {
          "default":
          {
            "httpProxy": <<PROXY>>,
            "httpsProxy": <<PROXY>>,
            "noProxy": "localhost,127.0.0.1,192.168.33.20,192.168.33.10,10.0.2.12,10.0.2.11,master,slave"
          }
         }
        }


        cat /etc/systemd/system/docker.service.d/http-proxy.conf
        [Service]
        Environment="HTTP_PROXY=<<PROXY>>" "NO_PROXY=localhost,127.0.0.1,192.168.33.20,192.168.33.10,10.0.2.0/24,slave,master" "HTTPS_PROXY=<<PROXY>>"
