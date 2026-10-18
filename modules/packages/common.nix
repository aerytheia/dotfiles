# my common software between my machines

{ self, inputs, ... }: {
  flake.nixosModules.common =
    { pkgs, ... }:
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      services.flatpak.enable = true;

      environment.systemPackages = with pkgs; [
        alacritty
        fuzzel
        fastfetch
        git
        kdePackages.dolphin
        aria2
        nixd
        nixfmt
      ];

      # maybe export my user or smthn
      users.users.ethan.packages = with pkgs; [
        bitwarden-desktop
        hackneyed
        obsidian
        gimp
        inkscape
        imagemagick
        (discord.override {
          withVencord = true;
        })
      ];

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
          alsa-lib
          zlib
          libgcc
        ];
      };

      programs.spicetify = {
        enable = true;
      };
    };
}
