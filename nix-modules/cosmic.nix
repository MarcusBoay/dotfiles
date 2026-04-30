{ config, pkgs, ... }:

{
  services = {
    # Enables the KDE Plasma Desktop Enviroment.
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
  };
}
