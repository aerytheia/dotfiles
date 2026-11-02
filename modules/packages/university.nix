{ self, inputs, ... }: {
  flake.nixosModules.university = { pkgs, ... }: let 
      isabellePkgs = import inputs.nixpkgs-isabelle {
        system = pkgs.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    in {
    users.users.ethan.packages = with pkgs; [
      isabellePkgs.isabelle
    ];
  };
}
