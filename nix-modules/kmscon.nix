
{ config, pkgs, ... }:

{
  services.kmscon = {
    enable = true;
    extraOptions = "--term xterm-256color";
    fonts = [ { name = "CaskaydiaMono Nerd Font Mono"; package = pkgs.nerd-fonts.caskaydia-mono; } ];
    hwRender = true;
    term = "xterm-256color";
  };
}
