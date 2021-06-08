#!/bin/sh

################################
# RTF Configuration Helper
# Author: Steve Roberts
# Issued under MIT License

# Copyright (c) 2021 MuleSoft Inc.

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

RTF_GENERATE_CONFIG="manual/generate-configs.sh"
RTF_GENERATE_CONFIG_URL="https://anypoint.mulesoft.com/runtimefabric/api/download/scripts/latest"


# Check if rtf_installation_scripts is available
if [[ ! -x "$RTF_GENERATE_CONFIG" ]]; then
  echo "Didn't find generate-configs.sh; download now?"
  read -p "[y/N]" -n 1 download
  echo ""
  if [[ "$download" == "y" ]]; then
    curl -L "$RTF_GENERATE_CONFIG_URL" -o rtf_install_scripts.zip && unzip rtf_install_scripts.zip
  else
    echo "Please download the RTF installation scripts from Anypoint and try again."
    exit 1
  fi
fi


RTF_CONTROLLER_IPS=""
while true; do
  echo "Enter controller node IP or leave blank to skip:"
  read ip
  if [[ -z "$ip" ]]; then
    break
  else
    RTF_CONTROLLER_IPS="$RTF_CONTROLLER_IPS $ip"
  fi
done
export RTF_CONTROLLER_IPS


RTF_WORKER_IPS=""
while true; do
  echo "Enter worker node IP or leave blank to skip:"
  read ip
  if [[ -z "$ip" ]]; then
    break
  else
    RTF_WORKER_IPS="$RTF_WORKER_IPS $ip"
  fi
done
export RTF_WORKER_IPS


DEF_RTF_DOCKER_DEVICE="/dev/xvdb"
echo "Enter Docker device path or leave blank to accept default [$DEF_RTF_DOCKER_DEVICE]:"
read RTF_DOCKER_DEVICE
if [[ -z "$RTF_DOCKER_DEVICE" ]]; then
  RTF_DOCKER_DEVICE="$DEF_RTF_DOCKER_DEVICE"
fi
export RTF_DOCKER_DEVICE


DEF_RTF_ETCD_DEVICE="/dev/xvdc"
echo "Enter ETCD device path or leave blank to accept default [$DEF_RTF_ETCD_DEVICE]:"
read RTF_ETCD_DEVICE
if [[ -z "$RTF_ETCD_DEVICE" ]]; then
  RTF_ETCD_DEVICE="$DEF_RTF_ETCD_DEVICE"
fi
export RTF_ETCD_DEVICE


while [[ -z "$RTF_ACTIVATION_DATA" ]]; do
  echo "Enter RTF activation data:"
  read RTF_ACTIVATION_DATA
done
export RTF_ACTIVATION_DATA


DEF_RTF_MULE_LICENSE="license.lic"
echo "Enter licence data or leave blank to use default:"
read RTF_MULE_LICENSE
if [[ -z "$RTF_MULE_LICENSE" ]]; then
  if [[ -x "$DEF_RTF_MULE_LICENSE" ]]; then
    RTF_MULE_LICENSE=$(cat $DEF_RTF_MULE_LICENSE  | base64 -b0)
  else
    echo "License file not found"
  fi
fi
export RTF_MULE_LICENSE

echo "================================"
echo " Ready to generate config:"
echo "  RTF_CONTROLLER_IPS=$RTF_CONTROLLER_IPS"
echo "  RTF_WORKER_IPS=$RTF_WORKER_IPS"
echo "  RTF_DOCKER_DEVICE=$RTF_DOCKER_DEVICE"
echo "  RTF_ETCD_DEVICE=$RTF_ETCD_DEVICE"
echo "  RTF_ACTIVATION_DATA=$RTF_ACTIVATION_DATA"
echo "  RTF_MULE_LICENSE=$RTF_MULE_LICENSE"
echo ""
echo " Create config?"
read -p "[y/N]" -n 1 generate
if [[ ! "$generate" ==  "y" ]]; then
  echo ""
  echo "Exiting, please rerun script to change values."
  exit 1
fi

# Run bundled script
install_scripts/manual/generate-configs.sh
