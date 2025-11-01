{
  config,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    unstable.winboat
  ];
  virtualisation.docker = {
    enable = true;
  };
  users.users.jenny = {
    extraGroups = [
      "docker"
    ];
  };
}
