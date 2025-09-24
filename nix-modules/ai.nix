{
  config,
  pkgs,
  lib,
  ...
}:

{
  services = {
    open-webui.enable = true;
    ollama = {
      enable = true;
      loadModels = [ "gemma3" ];
    };
  };

  # Don't start these at boot.
  systemd.services.open-webui.wantedBy = lib.mkForce [ ];
  systemd.services.ollama.wantedBy = lib.mkForce [ ];
  systemd.services.ollama-model-loader.wantedBy = lib.mkForce [ ];

  programs.zsh.shellAliases = {
    start-fren = "sudo systemctl start ollama open-webui && firefox localhost:8080";
    stop-fren = "sudo systemctl stop ollama open-webui";
  };
}
