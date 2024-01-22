#!/bin/bash

set -eux

export IMAGE_OS="centos"

# Install disk-image-builder
sudo dnf update -y
sudo dnf install python3 pip -y
sudo pip install diskimage-builder

source dib-and-image-vars.sh

# Create an image
disk-image-create -a amd64 centos-dev centos -o ${IMAGE_NAME} block-device-mbr

# Install openstackclient
sudo pip3 install python-openstackclient

source openstack-vars.sh

# Push image to openstack
openstack image create "${FINAL_IMAGE_NAME}" --file "${IMAGE_NAME}" --disk-format=qcow2
