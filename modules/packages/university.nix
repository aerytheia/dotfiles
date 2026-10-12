{ self, inputs, ... }: {
  flake.nixosModules.university = { pkgs, ... }: {
    users.users.ethan.packages = with pkgs; [
      isabelle
    ];
  };
}
