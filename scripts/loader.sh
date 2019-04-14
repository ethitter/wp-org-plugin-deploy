#!/usr/bin/env bash

# Note that this does not use pipefail
# because if the grep later doesn't match any deleted files,
# which is likely the majority case,
# it does not exit with a 0, and I only care about the final exit.
set -eo

# Download shared script and execute.
# See https://git.ethitter.com/open-source/wp-org-plugin-deploy/blob/master/README.md
DEPLOY_SCRIPT_SRC="https://git-cdn.e15r.co/open-source/wp-org-plugin-deploy/raw/master/scripts/deploy.sh"
DEPLOY_SCRIPT_NAME="deploy-wp-org.sh"

echo "ℹ︎ Downloading script from $DEPLOY_SCRIPT_SRC"

curl -o "./${DEPLOY_SCRIPT_NAME}" "$DEPLOY_SCRIPT_SRC"
chmod +x "./${DEPLOY_SCRIPT_NAME}"

echo "ℹ︎ Running $DEPLOY_SCRIPT_NAME"
bash "./${DEPLOY_SCRIPT_NAME}"
