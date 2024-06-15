{ config, pkgs, ... }:

{
  users.users.jenny.packages = with pkgs; [
    go
    libcap
    gcc
    gopls
  ];
}