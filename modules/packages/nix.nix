{ self, inputs, ... }: {
  flake.nixosModules.nix = { ... }: {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      max-jobs = "auto";
      cores = 0;
      trusted-users = [ "root" ];
    };

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    nix.optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };

    nixpkgs.config.allowUnfree = true;
    documentation.nixos.enable = false;
  };
}
