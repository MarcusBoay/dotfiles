# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./nix-modules/fixes.nix
    ./nix-modules/hyprland.nix
    ./nix-modules/gaming.nix
    ./nix-modules/qmk.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
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

      videoDrivers = ["nvidia"];
    };

    # Enable CUPS to print documents.
    printing.enable = true;
  };

  # Enable sound with pipewire.
  sound.enable = true;
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
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "555.52.04";
        sha256_64bit = "sha256-nVOubb7zKulXhux9AruUTVBQwccFFuYGWrU1ZiakRAI=";
        sha256_aarch64 = lib.fakeSha256;
        openSha256 = lib.fakeSha256;
        settingsSha256 = "sha256-PMh5efbSEq7iqEMBr2+VGQYkBG73TGUh6FuDHZhmwHk="; 
        persistencedSha256 = lib.fakeSha256;
      };
      modesetting.enable = true;
      forceFullCompositionPipeline = true; # fix screen tearing
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    keyboard.qmk.enable = true;

    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.jenny = {
      isNormalUser = true;
      description = "jenny";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        kate
        vscode
      ];
      useDefaultShell = true;
    };
    defaultUserShell = pkgs.zsh;
  };

  programs = {
    neovim.defaultEditor = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
      };
    };
    firefox.enable = true;
  };

  environment = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1"; # support for electron-based apps
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
      fd
      hyfetch
      killall
      ripgrep
      tealdeer
      bottom

      zsh
      oh-my-zsh
      zsh-powerlevel10k
      zsh-syntax-highlighting
      zsh-autosuggestions
    ];
  };

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    fontconfig.defaultFonts.monospace = [ "MesloLGM Nerd Font" "Braille" ];
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];
  };

  nix.settings.experimental-features = [ "nix-command flakes" ];
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
