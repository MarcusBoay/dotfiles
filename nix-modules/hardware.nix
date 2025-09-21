{ config, pkgs, ... }:

{
  services = {
    xserver.videoDrivers = [
      "nvidia"
    ];

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable library for remapping mouse inputs.
    ratbagd.enable = true;

    # To control GPU RGB.
    hardware.openrgb.enable = true;
  };

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

    opentabletdriver.enable = true;
  };
}