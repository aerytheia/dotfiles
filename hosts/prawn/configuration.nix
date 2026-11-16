{ pkgs, lib, ... }: {
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


    networking.hostName = "prawn";
    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    services.tuned.enable = true;
    services.upower.enable = true;
    system.stateVersion = "26.05";
}