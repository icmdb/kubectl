# kubectl

Kubectl with kubedog.

## Quick Start

```sh
docker run --rm -ti \
    --name kubectl \
    --hostname kubectl \
    --network host \
    --volume ~/.kube:/root/.kube \
    --workdir /root \
    icmdb/kubectl \
    sh

# tail deploy logs
stern --tail 1 --timestamps <deployname> -n <namespace>
```

## TODO:

* [x] [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* [ ] [kubecm](https://github.com/sunny0826/kubecm)
* [ ] [ktconnect](https://github.com/alibaba/kt-connect)
* [x] [stern](https://github.com/wercker/stern)
* [x] [kubedog](https://github.com/flant/kubedog)
* [ ] [kubewatch](https://github.com/bitnami-labs/kubewatch)
