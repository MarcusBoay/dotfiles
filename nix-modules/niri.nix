{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = { };

  # programs.waybar.enable = true; # top bar
  environment = {
    sessionVariables = {
      NIRI_CONFIG = "~/.config/niri/config-nixos.kdl";
    };
    systemPackages = with pkgs; [
      fuzzel
      mako
      playerctl
      sunsetr
      swaybg
      swayidle
      swaylock
      xdg-desktop-portal-gnome
      xwayland-satellite # xwayland support
    ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
