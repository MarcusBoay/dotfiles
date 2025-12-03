{ config, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    fontconfig = {
      antialias = true;
      useEmbeddedBitmaps = true; # support emojis on firefox
      defaultFonts = {
        monospace = [
          "CaskaydiaMono Nerd Font Mono"
          "MesloLGM Nerd Font"
          "Braille"
        ];
        emoji = [
          "Noto Color Emoji"
          "Twemoji Color Emoji"
        ];
      };
    };
    packages = with pkgs; [
      # nerd-fonts repo: https://github.com/NixOS/nixpkgs/blob/nixpkgs-25.05-darwin/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
      nerd-fonts.meslo-lg
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.caskaydia-cove
      nerd-fonts.caskaydia-mono
      noto-fonts-cjk-sans # support japanese characters
      noto-fonts
      noto-fonts-color-emoji
      twemoji-color-font
      google-fonts
    ];
  };
}
