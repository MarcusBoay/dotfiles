{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services = {
    blueman.enable = true;
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
      xdg-desktop-portal-hyprland
      python3
      dolphin
      # screenshot
      grim
      slurp
      swappy
    ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}