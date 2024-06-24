{ config, pkgs, ... }:

{
  users.users.jenny.packages = with pkgs; [
    cargo
    rustc
    clippy
    rustfmt
    rust-analyzer

    pkg-config
    openssl
    gcc
  ];

  programs.direnv.enable = true;
}
