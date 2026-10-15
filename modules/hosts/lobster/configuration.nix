{ self, inputs, ... }: {
  flake.nixosModules.lobsterConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.lobsterHardware
      self.nixosModules.audio
      self.nixosModules.boot
      self.nixosModules.browser
      self.nixosModules.common
      self.nixosModules.desktop
      self.nixosModules.games
      self.nixosModules.fonts
      self.nixosModules.hjem
      self.nixosModules.locale
      self.nixosModules.networking
      self.nixosModules.nix
      self.nixosModules.nvidia
      self.nixosModules.university
      self.nixosModules.user
    ];

    networking.hostName = "lobster";

    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = true;
    };

    hardware.bluetooth.enable = true;
    system.stateVersion = "26.05";
  };
}
