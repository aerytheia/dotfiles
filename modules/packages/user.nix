{ self, inputs, ... }: {
  flake.nixosModules.user = { ... }: {
    users.users.ethan = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "audio"
      ];
    };

    nix.settings.trusted-users = [ "ethan" ];
  };
}