# setup-k3d

This is a GitHub Action for setting up [k3d](https://github.com/rancher/k3d).

## Inputs

### `version`

k3d version.

Default: latest

### `name`

cluster name.

Default: k3d-cluster

### `skipClusterCreation`

If "true", the action will not create a cluster, just acquire the tools.

Default: false

## Examples

```yaml
on: push
jobs:
  setup-k3d:
    runs-on: ubuntu-latest
    steps:
      - uses: rinx/setup-k3d@v0.0.1
      - name: Get cluster info
        run: |
            kubectl cluster-info
            kubectl get pods -n kube-system
            echo "current-context:" $(kubectl config current-context)
```

## References

- [rancher/k3s](https://github.com/rancher/k3s)
- [rancher/k3d](https://github.com/rancher/k3d)
- [engineerd/setup-kind](https://github.com/engineerd/setup-kind)
