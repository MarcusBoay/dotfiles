# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./nix-modules/hardware.nix
    ./nix-modules/kde.nix
    ./nix-modules/fonts.nix
    ./nix-modules/zsh.nix
    # ./nix-modules/curfew.nix

    ./nix-modules/niri.nix
    ./nix-modules/nix-dev.nix
    ./nix-modules/rust.nix
    # ./nix-modules/qmk.nix
    # ./nix-modules/gaming.nix
    ./nix-modules/docker.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;

      grub = {
        efiSupport = true;
        device = "nodev";
      };

      # Hide the OS choice for bootloaders.
      # It's still possible to open the bootloader list by pressing any key.
      # It will just not appear on screen unless a key is pressed.
      timeout = 0;
    };

    # Enable "silent boot".
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];

    # Graphical boot animation.
    plymouth.enable = true;
    plymouth.theme = "breeze";
  };

  # services.xserver.enable = true;
  # services.xserver.xrandrHeads = [
  #   {
  #     output = "DP-3";
  #     primary = true;
  #     monitorConfig = ''
  #       Option "VertRefresh" "180"
  #     '';
  #   }
  # ];

  swapDevices = [
    {
      device = "/swapfile";
      size = 34 * 1024; # 32 GB + 2 GB
    }
  ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    # Better than iptables. https://wiki.nftables.org/wiki-nftables/index.php/What_is_nftables%3F
    # Note: might be problematic sometimes (docker).
    nftables.enable = true;
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
    extraGroups = [
      "networkmanager"
      # Allow root usage.
      "wheel"
      # For programs.light.enable.
      "video"
    ];
    packages = with pkgs; [
      gimp
      inkscape
      krita
      libreoffice
      obs-studio
      qutebrowser
      vscode
    ];
    useDefaultShell = true;
  };

  programs = {
    firefox.enable = true;
    yazi.enable = true;
    light.enable = true;
  };
  services.flatpak.enable = true;

  environment = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      md = "/home/jenny/github/dotfiles";
    };
    variables = {
      EDITOR = "hx";
      BAT_THEME = "Catppuccin Macchiato";
    };
    systemPackages = with pkgs; [
      nh

      xdg-desktop-portal-gtk

      ddcutil
      git
      helix
      kitty
      stow
      tmux
      zed-editor-fhs

      bat
      bottom
      dust
      eza
      fd
      jq
      killall
      ripgrep
      tealdeer

      fastfetch
      hyfetch
    ];
  };

  nix = {
    settings.experimental-features = [ "nix-command flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
      randomizedDelaySec = "10min";
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import <unstable> {
        config = config.nixpkgs.config;
      };
    };
  };
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
