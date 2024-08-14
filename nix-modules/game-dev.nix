{ config, pkgs, ... }:

{
  users.users.jenny.packages = with pkgs; [
    godot_4
  ];
}
