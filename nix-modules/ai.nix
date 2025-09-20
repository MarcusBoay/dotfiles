{ config, pkgs, lib, ... }:

{
  services.open-webui = {
    enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      ollama
    ];
  };
}
