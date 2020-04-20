arg ALPINE_VER=3.11.5
FROM alpine:${ALPINE_VER}
ENV PATH=${PATH}:${HOME}/.krew/bin
LABEL ALPINEE_DOCS=https://hub.docker.com/_/alpine
LABEL KUBECTL_DOCS=https://kubernetes.io/docs/tasks/tools/install-kubectl/
LABEL KUBEDOG_DOCS=https://github.com/flant/kubedog
LABEL STERN_DOCS=https://github.com/wercker/stern
arg KUBECTL_VER=v1.18.2
arg KUBEDOG_VER=v0.3.2
arg STERN_VER=1.11.0
RUN    apk update && apk add -t deps \
         ca-certificates \
         curl \
         git \
    && curl -o /usr/local/bin/kubectl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VER}/bin/linux/amd64/kubectl \
    && curl -o /usr/local/bin/kubedog -LO https://dl.bintray.com/flant/kubedog/${KUBEDOG_VER}/kubedog-linux-amd64-${KUBEDOG_VER} \
    && curl -o /usr/local/bin/stern   -LO https://github.com/wercker/stern/releases/download/${STERN_VER}/stern_linux_amd64 \
#    && curl -o /tmp/               -fsSLO https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml} \
#    && tar -C  /tmp/ -xvf /tmp/krew.tar.gz \
#    &&         /tmp/krew install --mainfest=/tmp/krew.yaml --archive=krew.tar.gz \
#    && krew update \
    && chmod +x /usr/local/bin/* \
    && apk del --purge deps && rm -rf /var/cache/apk/* && rm -rf /tmp/*.gz
VOLUME /root/.kube /root/.krew
WORKDIR /root
CMD [ "sleep 1000" ]
