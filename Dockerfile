FROM frolvlad/alpine-glibc:latest as builder
RUN apk add skopeo
RUN apk add bash
RUN apk add jq
RUN apk add curl
RUN apk add --no-cache --virtual .build-deps \
        curl \
        tar \
    && curl --retry 7 -Lo /tmp/client-tools.tar.gz "https://mirror.openshift.com/pub/openshift-v4/clients/oc/4.6/linux/oc.tar.gz"
RUN tar zxf /tmp/client-tools.tar.gz -C /usr/local/bin oc \
    && rm /tmp/client-tools.tar.gz \
    && apk del .build-deps

# ADDED: Resolve issue x509 oc login issue
RUN apk add --update ca-certificates
RUN apk add iputils
RUN apk add openjdk8-jre
# COPY SSLPoke.class SSLPoke.class # not present in this repository. Needs to be downloaded and compiled
WORKDIR /tmp
RUN wget https://get.helm.sh/helm-canary-linux-amd64.tar.gz
RUN tar zxf helm-canary-linux-amd64.tar.gz
RUN mv linux-amd64/helm /usr/local/bin
RUN wget https://releases.hashicorp.com/vault/1.4.3/vault_1.4.3_linux_amd64.zip
RUN unzip vault_1.4.3_linux_amd64.zip
RUN mv vault /usr/local/bin
RUN apk add postgresql-client 
RUN apk add openssl
RUN wget https://downloads.apache.org/kafka/2.5.0/kafka_2.12-2.5.0.tgz
RUN tar zxf kafka_2.12-2.5.0.tgz
RUN mv kafka_2.12-2.5.0 /kafka
RUN apk add git
WORKDIR /
RUN wget https://github.com/kwart/jd-cmd/releases/download/jd-cmd-1.1.0.Final/jd-cli-1.1.0.Final-dist.zip
RUN unzip jd-cli-1.1.0.Final-dist.zip
RUN apk add apache2-utils
RUN git clone https://github.com/bats-core/bats-core.git
RUN bats-core/install.sh /usr/local
RUN wget https://raw.githubusercontent.com/bats-core/bats-detik/master/lib/detik.bash 
RUN wget https://raw.githubusercontent.com/bats-core/bats-detik/master/lib/linter.bash
RUN wget https://raw.githubusercontent.com/bats-core/bats-detik/master/lib/utils.bash
RUN wget https://raw.githubusercontent.com/bats-core/bats-file/master/src/file.bash
RUN wget https://raw.githubusercontent.com/bats-core/bats-file/master/src/temp.bash
RUN wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/assert.bash
RUN wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/assert_equal.bash
RUN wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/assert_failure.bash
RUN wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/assert_line.bash
RUN wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/assert_output.bash
RUN wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/assert_success.bash
RUN wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/refute.bash
RUN wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/refute_line.bash
RUN wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/refute_output.bash
RUN wget https://raw.githubusercontent.com/bats-core/bats-support/master/src/error.bash
RUN wget https://raw.githubusercontent.com/bats-core/bats-support/master/src/lang.bash
RUN wget https://raw.githubusercontent.com/bats-core/bats-support/master/src/output.bash
RUN chmod +x *.bash
RUN mv *.bash /usr/local/lib/
