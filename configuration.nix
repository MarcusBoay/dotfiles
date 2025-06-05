# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./nix-modules/zsh.nix
    ./nix-modules/fixes.nix
    # ./nix-modules/hyprland.nix
    ./nix-modules/gaming.nix
    # ./nix-modules/game-dev.nix
    ./nix-modules/qmk.nix
    # ./nix-modules/rust.nix
    # ./nix-modules/vm.nix
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

  services = {
    # Enables the KDE Plasma Desktop Enviroment.
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };

      videoDrivers = [
        "nvidia"
      ];
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable library for remapping mouse inputs.
    ratbagd.enable = true;

    # To control GPU RGB.
    hardware.openrgb.enable = true;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    bluetooth.settings = {
      General = {
        Experimental = true;
      };
    };
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = false;
      modesetting.enable = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    keyboard.qmk.enable = true;

    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jenny = {
    isNormalUser = true;
    description = "jenny";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      vscode
      libreoffice
      krita
    ];
    useDefaultShell = true;
  };

  programs = {
    neovim.defaultEditor = true;
    firefox.enable = true;
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
      kitty
      git
      neovim
      stow

      bat
      bottom
      du-dust
      fd
      hyfetch
      killall
      ripgrep
      tealdeer

      piper
    ];
  };

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    fontconfig.defaultFonts.monospace = [ "MesloLGM Nerd Font" "Braille" ];
    packages = with pkgs; [
      # nerd-fonts repo: https://github.com/NixOS/nixpkgs/blob/nixpkgs-25.05-darwin/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
      nerd-fonts.meslo-lg
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.caskaydia-cove
      nerd-fonts.caskaydia-mono
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
