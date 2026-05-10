# thank you https://github.com/anotherhadi/nixy/blob/main/nixos/nvidia.nix :smile:

{ self, inputs, ... }: {
  flake.nixosModules.nvidia = { pkgs, config, ... }: {
    services.xserver.videoDrivers = [ "nvidia" ];

    boot.kernelParams = [
      "nvidia-drm.modeset=1"
    ];

    boot.blacklistedKernelModules = ["nouveau"];

    environment.variables = {
      NIXOS_OZONE_WL = "1"; # Wayland support for Electron apps
    };

    nixpkgs.config = {
      nvidia.acceptLicense = true;
    };

    hardware = {
      nvidia = {
        open = false;
        modesetting.enable = true;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
      };

      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
          libva-vdpau-driver
          libvdpau-va-gl
          mesa
          egl-wayland
          vulkan-loader
          vulkan-validation-layers
          libva
        ];
      };
    };


    environment.systemPackages = with pkgs; [
      vulkan-tools
      mesa-demos
      libva-utils
    ];
  };
}

