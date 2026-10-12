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
        kitty
        fuzzel
        fastfetch
        git
        nautilus

        aria2

        nixd
        nixfmt
      ];

      # maybe export my user or smthn
      users.users.ethan.packages = with pkgs; [
        gram
        bitwarden-desktop
        hackneyed
        obsidian

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
