{ config, pkgs, ... }:

{
  users.users.jenny.packages = with pkgs; [
    discord
    steam
    protonup

    prismlauncher
  ];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/jenny/.steam/root/compatibilitytools.d";
  };
}