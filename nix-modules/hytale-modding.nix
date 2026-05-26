{ config, pkgs, ... }:

{
  users.users.jenny.packages = with pkgs; [
    gradle_9
    javaPackages.compiler.openjdk25
    jdt-language-server
    jetbrains.idea
  ];
}
