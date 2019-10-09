sudo docker run -d --restart=unless-stopped \
        -p 8080:80 -p 8443:443 \
        -e HTTP_PROXY=$HTTP_PROXY \
        -e HTTPS_PROXY=$HTTPS_PROXY \
	-e NO_PROXY="localhost,127.0.0.1,192.168.33.0/24,master,slave,10.0.2.0/24" \
        rancher/rancher:latest
