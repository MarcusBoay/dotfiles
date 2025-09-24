{ config, pkgs, ... }:

{
  users.users.jenny = {
    extraGroups = [ "adbusers" ];
    packages = with pkgs; [
      nodePackages_latest.nodejs
      jdk17
      android-studio
    ];
  };

  programs.adb.enable = true;

  environment.variables = {
    ANDROID_HOME = "$HOME/Android/Sdk";
    PATH = "$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools";
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="plugdev"
  '';

  programs.nix-ld.enable = true;
}
