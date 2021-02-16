FROM quay.io/koflts/debug-container:1.1.2
RUN wget https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY} -O /usr/bin/yq 
RUN chmod +x /usr/bin/yq
