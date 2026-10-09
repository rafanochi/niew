{ config, ... }:

{
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true; # see the note above
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;

  # Hybrid graphics with PRIME
  hardware.nvidia.prime = {
    intelBusId = "PCI:0@0:2:0";
    nvidiaBusId = "PCI:1@0:0:0";
  };

  # Wayland requires kernel mode setting (KMS) to be enabled (Highly Recommended)
  hardware.nvidia.modesetting.enable = true;
}
