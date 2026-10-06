{ pkgs, ... }:

{
  hardware.graphics.enable = true;
  hardware.amdgpu = {
    # Loads the driver early, so the card is also available during boot.
    initrd.enable = true;

    # Installs the ROCm OpenCL ICD into /run/opengl-driver.
    opencl.enable = true;
  };

  # Permit graphical and SSH-launched compute jobs to open /dev/dri/render*.
  users.users.ycg.extraGroups = [
    "render"
    "video"
  ];

  # Diagnostics only.
  environment.systemPackages = with pkgs; [
    clinfo
    libva-utils
    rocmPackages.rocminfo
    rocmPackages.rocm-smi
    vulkan-tools
  ];
}
