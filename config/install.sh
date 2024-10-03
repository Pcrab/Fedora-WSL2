#!/usr/bin/env fish

# Prepare
rm -rf $HOME/.config && cp -r /var/config $HOME/.config
cd $HOME/.config

# Install starship
mkdir -p $HOME/.local/bin
wget https://starship.rs/install.sh -O starship-install.sh
chmod +x ./starship-install.sh && ./starship-install.sh --yes -b $HOME/.local/bin
rm starship-install.sh

# Install fisher and related plugins
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

fisher install jorgebucaran/nvm.fish
fisher install edc/bass

set -gx nvm_mirror https://chinanet.mirrors.ustc.edu.cn/node
nvm install lts

# Clean
rm -rf $HOME/.config/install.sh
