{ self, inputs, ... }: {
  flake.nixosConfigurations.lobster = inputs.nixpkgs.lib.nixosSystem {
    modules = [ 
      self.nixosModules.lobsterConfiguration
      inputs.hjem.nixosModules.default
      inputs.nix-flatpak.nixosModules.nix-flatpak
    ];
  };
}