{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zsh
    oh-my-zsh
    zsh-powerlevel10k
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
    };
    shellAliases = {
      c = "clear";
      switch = "sudo nixos-rebuild switch";
      l = "eza -lah";
      ll = "eza -l";
      rm = "echo 'Use \'rip\' instead!'";
    };
  };
  users.defaultUserShell = pkgs.zsh;
}
