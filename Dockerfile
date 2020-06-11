ARG BASE_IMAGE=alpine:3.12
ARG KUBECTL_VER=v1.18.2
ARG HELM_VER=v3.2.3
ARG KUSTOMIZE_VER=v3.6.1
ARG K9S_VER=v0.20.5
ARG KUBECTX_VER=v0.9.0
ARG KUBE_NEAT=v1.2.0
ARG KUBEDOG_VER=v0.3.2
ARG STERN_VER=1.11.0


FROM ${BASE_IMAGE} as build
ARG KUBECTL_VER
ARG HELM_VER
ARG KUSTOMIZE_VER
ARG K9S_VER
ARG KUBECTX_VER
ARG KUBE_NEAT
ARG KUBEDOG_VER
ARG STERN_VER

RUN    apk update && apk add \
         ca-certificates \
         bash \
         perl \
         bash-completion \
         curl \
         git 
RUN    curl -sL https://gist.githubusercontent.com/hanyouqing/f736e3f1a95ddd322d75452ac22fed66/raw/68c28b01d14bf3d20004b5b9a976bbd489ed9c2e/.gitconfig > ~/.gitconfig
RUN    curl -sL https://gist.githubusercontent.com/hanyouqing/4c440965417fbdee63a882ae7f584509/raw/a821427742577ef47699769a4752213186816f3d/.profile > ~/.profile
RUN    curl -sL https://gist.githubusercontent.com/hanyouqing/238eee5bc987e0d1b6a97cfcc2a8041a/raw/13a54a10fdf108b0a6ce732041e7f1bc46244461/.vimrc > ~/.vimrc
RUN    env bash \
    && curl -o /usr/local/bin/kubectl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VER}/bin/linux/amd64/kubectl 
RUN    curl -sL -o /tmp/helm-${HELM_VER}-linux-amd64.tar.gz https://get.helm.sh/helm-${HELM_VER}-linux-amd64.tar.gz \
    && tar -C /tmp -xvf /tmp/helm-${HELM_VER}-linux-amd64.tar.gz \
    && mv /tmp/linux-amd64/helm /usr/local/bin/
RUN    curl -sL -o /tmp/kustomize_v3.6.1_linux_amd64.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv3.6.1/kustomize_v3.6.1_linux_amd64.tar.gz \
    && tar -C /usr/local/bin/ -xvf /tmp/kustomize_v3.6.1_linux_amd64.tar.gz
RUN    curl  -sL -o /tmp/k9s_Linux_arm64.tar.gz  https://github.com/derailed/k9s/releases/download/${K9S_VER}/k9s_Linux_arm64.tar.gz \
    && tar -C /tmp/ -xzvf /tmp/k9s_Linux_arm64.tar.gz \
    && mv /tmp/k9s /usr/local/bin/
RUN    curl -sL -o /tmp/kubectx_v0.9.0_linux_x86_64.tar.gz https://github.com/ahmetb/kubectx/releases/download/v0.9.0/kubectx_v0.9.0_linux_x86_64.tar.gz \
    && tar -C /tmp/ -xvf /tmp/kubectx_v0.9.0_linux_x86_64.tar.gz \
    && mv /tmp/kubectx /usr/local/bin/
RUN    curl -SL -o /tmp/kubectl-neat_linux.tar.gz https://github.com/itaysk/kubectl-neat/releases/download/${KUBE_NEAT}/kubectl-neat_linux.tar.gz \
    && tar -C /tmp/ -xvf /tmp/kubectl-neat_linux.tar.gz \
    && mv /tmp/kubectl-neat /usr/local/bin/
RUN    curl -o /usr/local/bin/kubedog -LO https://dl.bintray.com/flant/kubedog/${KUBEDOG_VER}/kubedog-linux-amd64-${KUBEDOG_VER} 
RUN    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf 
RUN curl -o /usr/local/bin/stern   -LO https://github.com/wercker/stern/releases/download/${STERN_VER}/stern_linux_amd64 
RUN chmod +x /usr/local/bin/* \
    && rm -rf /var/cache/apk/* && rm -rf /tmp/*.gz


FROM ${BASE_IMAGE}
ENV SHELL=/bin/bash \
    PATH=${PATH}:${HOME}/.krew/bin \
    KUBEDIR=/root/.kube \
    KUBECONFIG="\$(ls -dl $KUBEDIR/conf.d/*|awk '{print $NF}'|tr '\n' ':')\$KUBEDIR/config"
RUN    apk update && apk add \
         ca-certificates \
         bash \
         perl \
         bash-completion \
         curl \
         git \
         vim
COPY --from=build /usr/local/bin/  /usr/local/bin
COPY --from=build /root/.gitconfig /root/.gitconfig
COPY --from=build /root/.profile   /root/.profile
COPY --from=build /root/.vimrc     /root/.vimrc
COPY --from=build /root/.fzf       /root/.fzf
RUN    mkdir -p /etc/bash_completion.d/ ~/.krew \
    && echo 'source <(kubectl completion bash)' >>~/.bashrc \
    && kubectl completion bash >/etc/bash_completion.d/kubectl \
    && echo 'alias k=kubectl' >>~/.bashrc \
    && echo 'complete -F __start_kubectl k' >>~/.bashrc
RUN echo y | ~/.fzf/install
WORKDIR /root/github.com
CMD [ "kubectl", "get", "ev", "-w" ]
