#! /usr/bin/env bash

## to temporarily install binaries (works as non-root): `source ./requirements.sh`
## to permanently install binaries (make require sudo): `./requirements.sh /path/to/install/dir`

install_dir=${1}
os=$(uname -s | tr "[:upper:]" "[:lower:]")
arch=""
case $(uname -m) in
    i386) arch="386" ;;
    i686) arch="386" ;;
    x86_64) arch="amd64" ;;
    *) echo "Unable to determine processor architecture."; exit 1 ;;
esac

if [[ -z "${install_dir}" ]]; then
    echo "INFO: installing requirements to temp dir and adding that to PATH"
    install_dir=$(mktemp -d)
    export PATH="${install_dir}:${PATH}"
fi

## trivy
echo ""
echo "installing trivy to ${install_dir}"
trivy_version=v0.21.1
curl -sSL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | \
    sh -s -- -b "${install_dir}" "${trivy_version}"
trivy --version

## cosign
echo ""
echo "installing cosign to ${install_dir}"
cosign_version=v1.3.1
curl -sSL -o "${install_dir}/cosign" https://storage.googleapis.com/cosign-releases/${cosign_version}/cosign-${os}-${arch}
chmod +x "${install_dir}/cosign"
cosign version
