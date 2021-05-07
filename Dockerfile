FROM frolvlad/alpine-glibc:latest as builder

# TODO what does option '--update' do?
# RUN apk add --update ca-certificates && \
# see https://gist.github.com/sgreben/dfeaaf20eb635d31e1151cb14ea79048

RUN apk add skopeo \
        bash \
        jq \
        yq \
        curl \
        tar \
        ca-certificates \
        iputils \
        openjdk8-jre \
        postgresql-client \
        git \
        openssl \
        apache2-utils

# COPY SSLPoke.class SSLPoke.class # not present in this repository. Needs to be downloaded and compiled
# TODO https://matthewdavis111.com/java/poke-ssl-test-java-certs/ ???

WORKDIR /tmp

RUN curl --retry 7 -Lo /tmp/client-tools.tar.gz "https://mirror.openshift.com/pub/openshift-v4/clients/oc/4.6/linux/oc.tar.gz" && \
        tar zxf /tmp/client-tools.tar.gz -C /usr/local/bin oc && \
        rm /tmp/client-tools.tar.gz

RUN wget https://get.helm.sh/helm-canary-linux-amd64.tar.gz && \
        tar zxf helm-canary-linux-amd64.tar.gz && \
        mv linux-amd64/helm /usr/local/bin

RUN wget https://releases.hashicorp.com/vault/1.4.3/vault_1.4.3_linux_amd64.zip && \
        unzip vault_1.4.3_linux_amd64.zip && \
        mv vault /usr/local/bin

RUN wget https://downloads.apache.org/kafka/2.7.0/kafka_2.13-2.7.0.tgz && \
        tar zxf kafka_2.13-2.7.0.tgz && \
        mv kafka_2.13-2.7.0 /kafka

RUN wget https://github.com/kwart/jd-cli/releases/download/jd-cli-1.2.0/jd-cli-1.2.0-dist.tar.gz && \
        mkdir /jd-cli && \
        tar zxf jd-cli-1.2.0-dist.tar.gz -C /jd-cli
        
RUN git clone https://github.com/bats-core/bats-core.git && \
        bats-core/install.sh /usr/local && \
        wget https://raw.githubusercontent.com/bats-core/bats-detik/master/lib/detik.bash  && \
        wget https://raw.githubusercontent.com/bats-core/bats-detik/master/lib/linter.bash && \
        wget https://raw.githubusercontent.com/bats-core/bats-detik/master/lib/utils.bash && \
        wget https://raw.githubusercontent.com/bats-core/bats-file/master/src/file.bash && \
        wget https://raw.githubusercontent.com/bats-core/bats-file/master/src/temp.bash && \
        wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/assert.bash && \
        wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/assert_equal.bash && \
        wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/assert_failure.bash && \
        wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/assert_line.bash && \
        wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/assert_output.bash && \
        wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/assert_success.bash && \
        wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/refute.bash && \
        wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/refute_line.bash && \
        wget https://raw.githubusercontent.com/bats-core/bats-assert/master/src/refute_output.bash && \
        wget https://raw.githubusercontent.com/bats-core/bats-support/master/src/error.bash && \
        wget https://raw.githubusercontent.com/bats-core/bats-support/master/src/lang.bash && \
        wget https://raw.githubusercontent.com/bats-core/bats-support/master/src/output.bash && \
        chmod +x *.bash && \
        mv *.bash /usr/local/lib/
