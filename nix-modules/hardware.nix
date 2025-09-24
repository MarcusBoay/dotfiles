{ config, pkgs, ... }:

{
  services = {
    xserver.videoDrivers = [
      "nvidia"
    ];

    # Enable CUPS to print documents.
    printing.enable = false;

    # Enable library for remapping mouse inputs.
    ratbagd.enable = false;

    # To control GPU RGB.
    hardware.openrgb.enable = false;
  };
  environment.systemPackages = with pkgs; [
    # Mouse input remapping software.
    # piper
  ];

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware = {
    # To control monitor backlights.
    i2c.enable = true;

    bluetooth.enable = true;
    bluetooth.settings.General.Experimental = true;

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

    opentabletdriver.enable = false;
  };
}
