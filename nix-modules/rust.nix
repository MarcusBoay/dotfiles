{ pkgs, ... }:

{
  users.users.jenny.packages = with pkgs; [
    cargo
    clippy
    rust-analyzer
    rustc
    rustfmt

    gcc
    openssl
    pkg-config
  ];

  programs.direnv.enable = true;
  programs.zsh.shellAliases = {
    cg = "cargo";
  };
}
