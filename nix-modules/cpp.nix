{ config, pkgs, ... }:

{
  users.users.jenny.packages = with pkgs; [
    clang-tools
  ];
}
