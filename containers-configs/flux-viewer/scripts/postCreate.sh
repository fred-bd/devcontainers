#!/bin/bash

cat <<EOF >> $HOME/.zshrc

# Coder aliases
alias cdr-u='coder update'
alias cdr-i='coder init'
alias cdr-r='coder run'
alias cdr-a='coder apply'
alias cdr-au='f() { coder auth add --tenant \$1 --client \$2 --secret \$3; }; f "`echo $TENANT`" "`cat $FLOW_API_KEY`" "`cat $FLOW_API_SECRET`"'
alias cdr-n='f() { coder new \$@; }; f "\$@" '

# Add kubectl alias
alias k='f() { kubectl \$@; }; f "\$@" '
alias kx='f() { kubectx \$@; }; f "\$@" '
alias ks='f() { kubens \$@; }; f "\$@" '
alias ke='f() { kubectl get events \$@; }; f "\$@" '

# IstioCTL
export PATH=\$HOME/.istioctl/bin:\$PATH
EOF

# # Install az extension
# az extension add --upgrade -n connectedk8s &&\
# az extension add --upgrade -n k8s-extension &&\
# az extension add --upgrade -n k8s-configuration

# Cloning Dracula theme for zsh
git clone https://github.com/dracula/zsh.git $HOME/dracula-zsh

# Generating a symbolic link
ln -s $HOME/dracula-zsh/dracula.zsh-theme $HOME/.oh-my-zsh/themes/dracula.zsh-theme

# Change theme
sed -e 's,^\(ZSH_THEME="\)[^"]*,\1dracula,g' -i $HOME/.zshrc

# Install Helm plugin
helm plugin install https://github.com/helm-unittest/helm-unittest.git
