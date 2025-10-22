{
  config,
  pkgs,
  lib,
  ...
}:
let
  curfew = pkgs.writeShellScriptBin "curfew" ''
    #!/usr/bin/env bash

    now=$(date +%H:%M)
    start="20:00"
    end="22:30"
    toMinutes() {
      IFS=":"
      arr=($1)
      unset IFS
      echo $((''${arr [ 0 ]}*60 + ''${arr [ 1 ]}))
    }

    nowM=$(toMinutes "$now")
    startM=$(toMinutes "$start")
    endM=$(toMinutes "$end")

    if (( nowM < startM || nowM >= endM )); then
      logger -t curfew "Detected computer online outside of ''${start}-''${end}... powering off."
      systemctl poweroff
    fi
  '';
in
{
  # -----------------------------------------------------------------
  # Make the script part of the system profile so it ends up in
  # /run/current-system/sw/bin/
  # -----------------------------------------------------------------
  environment.systemPackages = [ curfew ];

  # -----------------------------------------------------------------
  # One‑shot service that simply runs the script once.
  # -----------------------------------------------------------------
  systemd.services.curfew = {
    description = "Shut down the machine if it's online outside 20:00-22:30";
    # We don’t actually need to start it at boot, but declaring a
    # WantedBy makes the unit visible to `systemctl status`.
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${curfew}/bin/curfew";
    };
  };

  # -----------------------------------------------------------------
  # Timer that fires the service regularly.
  # -----------------------------------------------------------------
  systemd.timers.curfew = {
    description = "Periodic check for out-of-window online shutdown";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # Every 5 minutes
      OnUnitActiveSec = "5m";
    };
  };
}
