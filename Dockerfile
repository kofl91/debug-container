FROM quay.io/koflts/debug-container:1.1.2
RUN wget https://github.com/mikefarah/yq/releases/download/2.4.1/yq_linux_amd64 -O /usr/bin/yq
RUN chmod +x /usr/bin/yq
RUN wget https://github.com/mikefarah/yq/releases/download/2.4.1/yq_linux_amd64 -O /usr/bin/yq2 
RUN chmod +x /usr/bin/yq2
RUN wget https://github.com/mikefarah/yq/releases/download/3.4.1/yq_linux_amd64 -O /usr/bin/yq3
RUN chmod +x /usr/bin/yq3
RUN wget https://github.com/mikefarah/yq/releases/download/v4.5.1/yq_linux_amd64 -O /usr/bin/yq4 
RUN chmod +x /usr/bin/yq4
RUN wget https://github.com/prometheus/prometheus/releases/download/v2.25.0/prometheus-2.25.0.linux-amd64.tar.gz -O /tmp/prometheus.tar.gz
RUN tar -xzf /tmp/prometheus.tar.gz prometheus-2.25.0.linux-amd64/promtool
RUN mv ./prometheus-2.25.0.linux-amd64/promtool /usr/bin/promtool
