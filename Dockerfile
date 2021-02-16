FROM quay.io/koflts/debug-container:1.1.2
RUN wget https://github.com/mikefarah/yq/releases/download/2.4.1/yq_linux_amd64 -O /usr/bin/yq 
RUN chmod +x /usr/bin/yq
