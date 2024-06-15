# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./nix-modules/android.nix
      ./nix-modules/gaming.nix
      ./nix-modules/qmk.nix
    ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    resumeDevice = "";
    kernelParams = [
      # See: https://github.com/NixOS/nixpkgs/issues/302059
      "initcall_blacklist=simpledrm_platform_driver_init" # fix: NixOS 24.05 creates a new unknown monitor for some reason...
    ];
  };

  # Swapfile.
  swapDevices = [{
    device = "/swapfile";
    size = 34 * 1024; # 32 GB + 2 GB
  }];

  networking = {
    hostName = "nixos"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Toronto";
  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_CA.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "en_GB.UTF-8";
    };
  };

  # Services
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

    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
      forceFullCompositionPipeline = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    keyboard.qmk.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command flakes" ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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

    hyprland.enable = true;
    #waybar.enable = true;
    #nm-applet.enable = true;
  };

  environment = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };
    variables = {
      EDITOR = "nvim";
      NIXOS_OZONE_WL = "1"; # support for hyprland and vscode, somehow...
      BAT_THEME="Catppuccin Macchiato";
    };
    # List packages installed in system profile. To search, run:
    # $ nix search wget
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

      hyprland
      # for hyprland session
      hyprpaper
      hyprlock
      hypridle
      wofi
      swaynotificationcenter
      waybar
      qt6.qtwayland
      libsForQt5.qt5.qtwayland
      playerctl
      blueman
      networkmanagerapplet
      libgnome-keyring
      wlogout
      xdg-desktop-portal-hyprland
      python3
      dolphin
      # screenshot
      grim
      slurp
      swappy
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.autoUpgrade = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
