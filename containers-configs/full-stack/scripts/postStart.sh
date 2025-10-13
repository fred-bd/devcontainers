#!/bin/bash

VAULT_JSON=$HOME/projects/tmp/vault.json

# Unseal Vault
[ -f $VAULT_JSON ] && {
  echo 'Unsealing Vault'

  v_addr='http://localhost:8200'
  v_keys=$(cat $VAULT_JSON | jq '.keys[]' | xargs)

  for key in $v_keys; do
    vault operator unseal -address $v_addr $key
  done
}

# Check git configurations
GIT_USER_EXISTS=$(git config --global --get user.name)
GIT_USER_EMAIL_EXISTS=$(git config --global --get user.email)
GIT_SAFE_DIR_EXISTS=$(git config --global --get safe.directory)
GIT_DEFAULT_BRANCH_EXISTS=$(git config --global --get init.defaultBranch)

[ -z "$GIT_DEFAULT_BRANCH_EXISTS" ] && {
  echo 'Setting up git default branch'
  git config --global init.defaultBranch main
}

[ -z "$GIT_SAFE_DIR_EXISTS" ] && {
  echo 'Setting up git safe directory'
  git config --global safe.directory "*"
}

[ -z "$GIT_USER_EXISTS" ] && {
  echo 'Setting up git user name'
  git config --global user.name "$GIT_USER"
}

[ -z "$GIT_USER_EMAIL_EXISTS" ] && {
  echo 'Setting up git user email'
  git config --global user.email "$GIT_USER_EMAIL"
}

echo "$DIP $DH" | sudo tee -a /etc/hosts

exit 0
