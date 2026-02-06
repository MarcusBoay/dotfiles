{ config, pkgs, ... }:

{
  users.users.jenny.packages = with pkgs; [
    # proton-ge-bin
    protonup-ng
    protonup-qt
    # mangohud

    # prismlauncher
  ];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/jenny/.steam/root/compatibilitytools.d";
  };
}
