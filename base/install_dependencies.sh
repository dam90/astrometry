#! /bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [[ $(uname -m) == arm* ]]; then
  echo "-------------------------------------------------------------"
  echo "ARM processor detected >> using raspberry pi install scripts.";
  echo "-------------------------------------------------------------"
  $SCRIPT_DIR/arm/rpi_install.sh
else
  echo "-------------------------------------------------------------"
  echo "Non-arm processor detected >> using CentOS 7 install scripts."
  echo "-------------------------------------------------------------"
  $SCRIPT_DIR/intel/intel_install.sh
fi
