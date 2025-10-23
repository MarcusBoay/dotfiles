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
      echo $((''${arr[0]}*60 + ''${arr[1]}))
    }

    nowM=$(toMinutes "''${now}")
    startM=$(toMinutes "''${start}")
    endM=$(toMinutes "''${end}")

    if (( ''${nowM} < ''${startM} || ''${nowM} >= ''${endM} )); then
      echo "Detected computer online outside of allowed period of ''${start} - ''${end}... powering off!!!"
      systemctl poweroff
    else
      echo "Current time (''${now}) is within allowed period of ''${start} - ''${end}... "
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
    description = "Shut down machine if within curfew period";
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
