{ pkgs, config, ... }: {
    imports = [
        ./hardware-configuration.nix
        ../../imports/audio.nix
        ../../imports/boot.nix
        ../../imports/desktop.nix
        ../../imports/locale.nix
        ../../imports/networking.nix
        ../../imports/system.nix
        ../../imports/users.nix
    ];


    networking.hostName = "lobster";
    hardware.bluetooth.enable = true;
    system.stateVersion = "26.05";

    # nvidia drivers
    services.xserver.videoDrivers = [ "nvidia" ];

    boot.kernelParams = [
        "nvidia-drm.modeset=1"
    ];

    boot.blacklistedKernelModules = [ "nouveau" ];

    environment.variables = {
        NIXOS_OZONE_WL = "1";
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

    # steam and games
    programs.gamescope.enable = true;
    programs.gamemode.enable = true;

    programs.steam = {
        enable = true;
        protontricks.enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    environment.variables = {
        STEAM_USE_NIX_FONTS = "1";
    };

    services.flatpak.packages = [
        "org.vinegarhq.Sober"
    ];
    
    services.flatpak.enable = true;    
}