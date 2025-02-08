{ config, pkgs, lib, ... }:

{
  # VGA:   01:00.0    10de:1b80
  # Audio: 01:00.1    10de:10f0
  # boot.initrd.kernelModules = [
  #   "kvm-intel"

  #   "vfio_pci"
  #   "vfio"
  #   "vfio_iommu_type1"

  #   "nvidia"
  #   "nvidia_modeset"
  #   "nvidia_uvm"
  #   "nvidia_drm"
  # ];
  # boot.kernelParams = [
  #   "intel_iommu=on"
  #   "vfio-pci.ids=10de:1b80,10de:10f0"
  # ];





  # boot.extraModprobeConfig = "options vfio-pci ids=10de:1b80,10de:10f0";
  # boot.initrd.kernelModules = [
  #   "vfio_pci"
  #   "vfio_iommu_type1"
  #   "vfio"

  # ];

  # boot.initrd.availableKernelModules = [
  #   "nvidia"
  #   "vfio-pci"
  # ];
  # boot.initrd.preDeviceCommands = ''
  #   DEVS="0000:01:00.0 0000:01:00.1"
  #   for DEV in $DEVS; do
  #     echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
  #   done
  #   modprobe -i vfio-pci
  # '';

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = false;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };
  virtualisation.kvmgt.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  programs.virt-manager.enable = true;

  users.users.jenny.extraGroups = [
    "libvirtd"
    "kvm"
  ];

  environment.systemPackages = with pkgs; [
    qemu
    virtiofsd
  ];
}
