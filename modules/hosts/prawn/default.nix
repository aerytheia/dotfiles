{ self, inputs, ... }: {
  flake.nixosConfigurations.prawn = inputs.nixpkgs.lib.nixosSystem {
    modules = [ 
      self.nixosModules.prawnConfiguration
      inputs.hjem.nixosModules.default
    ];
  };
}