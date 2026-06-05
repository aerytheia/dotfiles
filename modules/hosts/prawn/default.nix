{ self, inputs, ... }: {
  flake.nixosConfigurations.prawn = inputs.nixpkgs.lib.nixosSystem {
    modules = [ 
      self.nixosModules.prawnConfiguration
      inputs.hjem.nixosModules.default
      inputs.nix-flatpak.nixosModules.nix-flatpak
      inputs.spicetify-nix.nixosModules.spicetify
    ];
  };
}