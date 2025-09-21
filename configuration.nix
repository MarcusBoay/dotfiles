# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./nix-modules/hardware.nix
    ./nix-modules/kde.nix
    ./nix-modules/fonts.nix
    ./nix-modules/zsh.nix
    ./nix-modules/fixes.nix
    # ./nix-modules/hyprland.nix
    ./nix-modules/gaming.nix
    ./nix-modules/game-dev.nix
    ./nix-modules/qmk.nix
    ./nix-modules/rust.nix
    # ./nix-modules/vm.nix
    ./nix-modules/ai.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 1;
  };

  swapDevices = [{
    device = "/swapfile";
    size = 34 * 1024; # 32 GB + 2 GB
  }];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Toronto";
  i18n = {
    defaultLocale = "en_CA.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "en_GB.UTF-8";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jenny = {
    isNormalUser = true;
    description = "jenny";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [
      vscode.fhs
      libreoffice
      krita
      gimp
      inkscape
      qutebrowser
    ];
    useDefaultShell = true;
  };

  programs = {
    neovim.defaultEditor = true;
    firefox.enable = true;
    yazi.enable = true;
    light.enable = true;
  };

  environment = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };
    variables = {
      EDITOR = "nvim";
      BAT_THEME = "Catppuccin Macchiato";
    };
    systemPackages = with pkgs; [
      nh

      xdg-desktop-portal-gtk
      catppuccin-cursors.lattePink

      kitty
      git
      neovim
      stow
      ddcutil

      bat
      bottom
      du-dust
      fd
      hyfetch
      fastfetch
      killall
      ripgrep
      tealdeer
      jq

      piper
    ];
  };

  nix = {
    settings.experimental-features = [ "nix-command flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
  nixpkgs.config.allowUnfree = true;
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
