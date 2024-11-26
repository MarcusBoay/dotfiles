{ config, pkgs, ... }:

{
  # boot.kernelParams = [
  #   # fix fox NixOS 24.05, it creates a new unknown monitor for some reason...
  #   # See: https://github.com/NixOS/nixpkgs/issues/302059
  #   "initcall_blacklist=simpledrm_platform_driver_init"
  # ];
}