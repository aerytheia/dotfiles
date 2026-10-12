{
  description = "ethans awesome configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    hjem.url = "github:feel-co/hjem";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake
    { inherit inputs; }
    (inputs.import-tree ./modules);
}