# my common software between my machines

{ self, inputs, ... }: {
  flake.nixosModules.common = { pkgs, ... }:
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    services.flatpak.enable = true;

    environment.systemPackages = with pkgs; [
      swaybg
      alacritty
      fuzzel
      fastfetch
      git
      helix
      devenv

      nixd
      nixfmt
    ];

    # for bitwarden :(
    nixpkgs.config.permittedInsecurePackages = [ "electron-39.8.10" ];    

    # maybe export my user or smthn
    users.users.ethan.packages = with pkgs; [
      vscodium
      bitwarden-desktop
      hackneyed
      vesktop
    ];

    programs.spicetify = {
      enable = true;
    };
  };
}