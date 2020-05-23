from ubuntu:16.04
ENV http_proxy http://xxx.xxx.xxx.xxx:3128/
ENV https_proxy https://xxx.xxx.xxx.xxx:3128/

COPY run.sh /root/
RUN /bin/bash -c 'chmod +x /root/run.sh'
RUN /bin/bash -c '/root/./run.sh'
