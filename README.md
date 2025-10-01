# dotfiles
dotfiles for my NixOS system. This was initially set up for Hyprland and KDE Plasma.

![full](imgs/full.png)

## Setup
At the root of this repo, run:
```bash
stow -t ~/.config .config
ln -sf ~/github/dotfiles/.zshrc ~/.zshrc
sudo ln -sf ~/github/dotfiles/configuration.nix /etc/nixos/configuration.nix
```

## TODO
### General
- [ ] sddm: custom sddm theme

### Hyprland
- [ ] put colors into separate config file
- [ ] use hyprsunset in waybar instead of ddcutil
- [ ] hyprsunset not autostarting on login???
- [ ] move workspace not working for side mouse buttons(https://wiki.hypr.land/Configuring/Binds/#mouse-binds) and comma/dot
- [ ] Alt-Tab? (https://wiki.hypr.land/Configuring/Binds/#multiple-binds-to-one-key, https://wiki.hypr.land/Configuring/Variables/#variable-types)
- [ ] cursor/hyprcursor
- [ ] make own waybar using quickshell
- [ ] Hyprpolkitagent, hyprpicker, hyprsysteminfo
- [ ] don't point `polkit-kde-authentication-agent-1` nix store (use hyprpolkitagent instead???, need testing)
- [ ] permissions (https://wiki.hypr.land/0.49.0/Configuring/Permissions/)
- [ ] tablet https://wiki.hypr.land/0.49.0/Configuring/Permissions/
- [ ] set default monitor (https://wiki.hypr.land/0.49.0/Configuring/Variables/#cursor)
- [ ] look into https://github.com/H3rmt/hyprshell