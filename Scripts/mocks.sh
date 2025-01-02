#!/usr/bin/env bash

#
# Script: mocks.sh
# Usage: ./mocks.sh
#
# Description:
# Generates mock files using SwiftyMocky.
#
# Installation:
# https://github.com/MakeAWishFoundation/SwiftyMocky?tab=readme-ov-file#2-installing-swiftymocky-cli
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# Command that runs the swiftymocky binary
EXE="mint"

# Repository name for SwiftyMocky
SWIFTY_MOCKY="MakeAWishFoundation/SwiftyMocky"

# Check the executable exists
if ! [[ -x "$(command -v "${EXE}")" ]]; then
    echo "Command not found '${EXE}'." 1>&2
    echo "Please see the docs of $0 for installation steps." 1>&2
    exit 1
fi

# Validate the setup 
"${EXE}" run "${SWIFTY_MOCKY}" doctor

# Generate the mocks
"${EXE}" run "${SWIFTY_MOCKY}" generate

# Print success
echo "Mocks generated successfully"
