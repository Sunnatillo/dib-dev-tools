#!/bin/bash

set -eux

export ELEMENTS_PATH="$(dirname "$(readlink -f "${0}")")"
export DIB_DEV_USER_USERNAME=${DIB_DEV_USER_USERNAME}
export DIB_DEV_USER_PWDLESS_SUDO=${DIB_DEV_USER_PWDLESS_SUDO:-yes}
export DIB_DEV_USER_AUTHORIZED_KEYS=${DIB_DEV_USER_AUTHORIZED_KEYS:-}

export DIB_RELEASE=jammy 

disk-image-create -a amd64 base vm ubuntu-dev-env metal3-base devuser  -o sunnat-test-6.qcow2