#!/bin/sh

set -e
K3D_VERSION=$1
CLUSTER_NAME=$2
SKIP_CLUSTER_CREATION=$3
AGENTS=$4
OPTIONS=$5

REPO_URL="https://github.com/rancher/k3d"
K3D_ROOT="/github/home/k3d"
K3D_HOME="/home/runner/work/_temp/_github_home/k3d"

if [ "$K3D_VERSION" = "latest" ]; then
  K3D_VERSION=$(curl -Ls -o /dev/null -w %{url_effective} "${REPO_URL}/releases/latest" | grep -oE "[^/]+$" )
fi

echo "Install k3d ${K3D_VERSION}."

mkdir -p "${K3D_ROOT}/bin"

curl -SsL "${REPO_URL}/releases/download/${K3D_VERSION}/k3d-linux-amd64" -o "${K3D_ROOT}/bin/k3d"

chmod a+x "${K3D_ROOT}/bin/k3d"

export PATH="${PATH}:${K3D_ROOT}/bin"

echo "${K3D_HOME}/bin" >> $GITHUB_PATH

echo "Finished to install k3d."

if [ ! "$SKIP_CLUSTER_CREATION" = "true" ]; then
    echo "Creating k3d cluster..."

    if [ "${AGENTS}" != "0" ]; then
      OPTIONS="${OPTIONS} --agents ${AGENTS}"
    fi

    k3d cluster create ${CLUSTER_NAME} ${OPTIONS}
    k3d kubeconfig get ${CLUSTER_NAME} > "${K3D_ROOT}/k3d.yaml"

    echo "KUBECONFIG=${K3D_HOME}/k3d.yaml" >> $GITHUB_ENV

    echo "Finished to create k3d cluster."
fi
