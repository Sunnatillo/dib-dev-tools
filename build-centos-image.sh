#!/bin/bash

set -eux

# Install disk-image-builder
sudo dnf update -y
sudo dnf install python3 pip -y
sudo pip install diskimage-builder

current_dir="$(dirname "$(readlink -f "${0}")")"

export ELEMENTS_PATH="${current_dir}/dib_elements"
export DIB_DEV_USER_USERNAME="metal3ci"
export DIB_DEV_USER_PWDLESS_SUDO="yes"
export DIB_DEV_USER_AUTHORIZED_KEYS=${DIB_DEV_USER_AUTHORIZED_KEYS:-"${current_dir}/id_ed25519_metal3ci.pub"}
export DIB_RELEASE=centos 

# Set image names
commit_short="$(git rev-parse --short HEAD)"
final_image_name="metal3-dev-env-ubuntu"
image_date="$(date --utc +"%Y%m%dT%H%MZ")"
image_name="${final_image_name}-${image_date}-${commit_short}"

disk-image-create -a amd64 centos-dev-env centos -o ${image_name}

# Install openstackclient
sudo pip3 install python-openstackclient

# export OS_USERNAME="metal3ci"
# export OS_PASSWORD="{$OS_PASSWORD}"
# export OS_AUTH_URL="https://kna1.citycloud.com:5000"
# export OS_USER_DOMAIN_NAME="CCP_Domain_37137"
# export OS_PROJECT_DOMAIN_NAME="CCP_Domain_37137"
# export OS_REGION_NAME="Kna1"
# export OS_PROJECT_NAME="Default Project 37137"
# export OS_TENANT_NAME="Default Project 37137"
# export OS_AUTH_VERSION=3
# export OS_IDENTITY_API_VERSION=3

# # Push image to openstack
# openstack image create "${final_image_name}" --file "${image_name}" --disk-format=qcow2
