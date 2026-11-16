{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-isabelle.url = "github:NixOS/nixpkgs/c57fe4bc08d5a2968940cff2147c50dc7d066cdb";

        nix-flatpak.url = "github:gmodena/nix-flatpak";
        hjem.url = "github:feel-co/hjem";
        spicetify-nix.url = "github:Gerg-L/spicetify-nix";
        matugen.url = "github:InioX/Matugen";
    };

    outputs = { self, nixpkgs, ... }@inputs: let 
        sharedModules = [
            inputs.hjem.nixosModules.default
            inputs.nix-flatpak.nixosModules.nix-flatpak
            inputs.spicetify-nix.nixosModules.spicetify
        ];
    in {
        nixosConfigurations.lobster = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = sharedModules ++ [ ./hosts/lobster/configuration.nix ];
        };

        nixosConfigurations.prawn = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = sharedModules ++ [ ./hosts/prawn/configuration.nix ];
        };
    };
}
