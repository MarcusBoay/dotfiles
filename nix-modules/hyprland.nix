{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;
  };

  environment = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1"; # fix for invisible cursor
    };
    systemPackages = with pkgs; [
      hyprland

      hyprpaper
      hyprlock
      hypridle
      hyprsunset
      hyprpolkitagent

      rofi-wayland
      swaynotificationcenter
      waybar
      qt6.qtwayland
      libsForQt5.qt5.qtwayland
      playerctl
      blueman
      networkmanagerapplet
      libgnome-keyring
      wlogout
      python3
      # screenshot
      grim
      slurp
      swappy
    ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
}
