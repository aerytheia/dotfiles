{ self, inputs, ... }: {
  flake.nixosModules.prawnConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.prawnHardware
      self.nixosModules.audio
      self.nixosModules.boot
      self.nixosModules.common
      self.nixosModules.desktop
      self.nixosModules.firefox
      self.nixosModules.fonts
      self.nixosModules.games
      self.nixosModules.hjem
      self.nixosModules.locale
      self.nixosModules.networking
      self.nixosModules.nix
      self.nixosModules.user
    ];

    networking.hostName = "prawn";
    networking.networkmanager.enable = true;

    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = true;
    };

    hardware.bluetooth.enable = true;
    services.tuned.enable = true;
    services.upower.enable = true;

    system.stateVersion = "26.05";
  };
} 