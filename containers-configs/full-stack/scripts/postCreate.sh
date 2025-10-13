#!/bin/bash

cat <<EOF >> $HOME/.zshrc

# Add kubectl alias
alias k='f() { kubectl \$@; }; f "\$@" '
alias kx='f() { kubectx \$@; }; f "\$@" '
alias ks='f() { kubens \$@; }; f "\$@" '
alias ke='f() { kubectl get events \$@; }; f "\$@" '

# Tools
alias git-clean='git branch | grep -v "main" | xargs git branch -D'
alias docker-clean-dang='docker rmi \$(docker images -f "dangling=true" -q)'

# NVM configuration
export NVM_DIR="\$([ -z "\${XDG_CONFIG_HOME-}" ] && printf %s "\${HOME}/.nvm" || printf %s "\${XDG_CONFIG_HOME}/nvm")"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh" # This loads nvm

# IstioCTL
export PATH=\$HOME/.istioctl/bin:\$PATH
EOF


# Install az extension
az extension add --upgrade -n connectedk8s &&\
az extension add --upgrade -n k8s-extension &&\
az extension add --upgrade -n k8s-configuration &&\
az extension add --upgrade -n cli-translator

# Cloning Dracula theme for zsh
git clone https://github.com/dracula/zsh.git $HOME/dracula-zsh

# Generating a symbolic link
ln -s $HOME/dracula-zsh/dracula.zsh-theme $HOME/.oh-my-zsh/themes/dracula.zsh-theme

# Change theme
sed -e 's,^\(ZSH_THEME="\)[^"]*,\1dracula,g' -i $HOME/.zshrc

# Install Helm plugin
helm plugin install https://github.com/helm-unittest/helm-unittest.git
