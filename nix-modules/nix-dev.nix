{
  config,
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    nixfmt
    nil
    nixd
  ];
}
