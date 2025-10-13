#!/bin/bash

cat <<EOF >> $HOME/.zshrc

# Coder aliases
alias cdr-u='coder update'
alias cdr-i='coder init'
alias cdr-r='coder run'
alias cdr-a='coder apply'
alias cdr-au='f() { coder auth add --tenant \$1 --client \$2 --secret \$3; }; f "`echo $TENANT`" "`cat $FLOW_API_KEY`" "`cat $FLOW_API_SECRET`"'
alias cdr-n='f() { coder new \$@; }; f "\$@" '
EOF