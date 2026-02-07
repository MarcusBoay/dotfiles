# dotfiles
dotfiles for my NixOS system.

![full](imgs/full.png)

## Setup
At the root of this repo, run:
```bash
stow -t ~/.config .config
ln -sf ~/github/dotfiles/.zshrc ~/.zshrc
sudo ln -sf ~/github/dotfiles/configuration.nix /etc/nixos/configuration.nix
```
