sudo docker run -d --restart=unless-stopped \
        -p 8080:80 -p 8443:443 \
        -e HTTP_PROXY=$HTTP_PROXY \
        -e HTTPS_PROXY=$HTTPS_PROXY \
	-e NO_PROXY=localhost,127.0.0.1,192.168.33.20,192.168.33.10,master,slave,10.0.2.15,10.0.4.15 \
        rancher/rancher:latest
