#!/usr/bin/env bash

#
# Script: mocks.sh
# Usage: ./mocks.sh
#
# Description:
# Generates mock file(s) using SwiftyMocky.
#
# Installation:
# https://github.com/MakeAWishFoundation/SwiftyMocky?tab=readme-ov-file#2-installing-swiftymocky-cli
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# Path to swiftymocky binary
EXE="${HOME}/.mint/bin/swiftymocky"

# Check the swiftymocky executable exists
if ! [[ -x "$(command -v "${EXE}")" ]]; then
    echo "Command not found '${EXE}'." 1>&2
    echo "Please see the docs of $0 for installation steps." 1>&2
    exit 1
fi

# Validate the setup 
"${EXE}" doctor 