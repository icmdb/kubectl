# kubectl

Kubectl with some tools installed.

## Quick Start

```sh
# run kubectl container
docker run --rm -ti \
    --name kubectl \
    --hostname kubectl \
    --network host \
    --volume ~/.kube:/root/.kube \
    --workdir /root \
    icmdb/kubectl \
    sh

# kubectl 
kubectl get nodes
kubectl get ns

# stern tail deploy logs
stern --tail 1 --timestamps <deployname> -n <namespace>

# kubedog follow deploy
kubedog follow deployment <deployname> -n <namespace>
```

## TODO:

* [x] [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* [ ] [kubectl-ctx](https://github.com/postfinance/kubectl-ctx)
* [k9scli](https://k9scli.io/)
* [kubetail]()
* [ ] [kubecm](https://github.com/sunny0826/kubecm)
* [ ] [ktconnect](https://github.com/alibaba/kt-connect)
* [x] [stern](https://github.com/wercker/stern)
* [x] [kubedog](https://github.com/flant/kubedog)
* [ ] [kubewatch](https://github.com/bitnami-labs/kubewatch)
* [ ] [kubeseal](https://github.com/bitnami-labs/sealed-secrets)
* [ ] [kubeval](https://github.com/instrumenta/kubeval)
* [ ] kail
* [ ] kubetail
* [ ] kui
* [ ] access_matrix
* [ ] who_can
* [ ] click
* [ ] [statusbay](https://github.com/similarweb/statusbay)
* [ ] [follow-me-install-kubernetes-cluster](https://github.com/opsnull/follow-me-install-kubernetes-cluster)
* [ ] [lens](https://github.com/lensapp/lens)
* [ ] [lazygit](https://github.com/jesseduffield/lazygit)
* [ ] [loft](https://loft.sh/)
