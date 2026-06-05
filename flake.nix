{
  description = "ethans awesome configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    hjem.url = "github:feel-co/hjem";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    noctalia.url = "github:noctalia-dev/noctalia-shell/v5";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake
    { inherit inputs; }
    (inputs.import-tree ./modules);
}