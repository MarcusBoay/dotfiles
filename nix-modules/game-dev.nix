{ config, pkgs, ... }:

{
  users.users.jenny.packages = with pkgs; [
    godot
    lmms
    pixelorama

    clang
    clang-tools
    mold

    dotnet-runtime_10
    dotnet-sdk_10
    godot-mono
    godot3-mono
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    alsa-lib
    fontconfig
    libGL
    libx11
    libxcursor
    libxext
    libxfixes
    libxi
    libxinerama
    libxkbcommon
    libxrandr
    libxrender
    vulkan-loader
    wayland
  ];
}
