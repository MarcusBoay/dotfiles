{
  config,
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    nil
    nixd
  ];
}
