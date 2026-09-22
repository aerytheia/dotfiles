# my common software between my machines

{ self, inputs, ... }: {
  flake.nixosModules.common =
    { pkgs, ... }:
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      jdkWithFX = pkgs.openjdk.override {
        enableJavaFX = true; # for JavaFX
      };

    in
    {
      services.flatpak.enable = true;

      environment.systemPackages = with pkgs; [
        swaybg
        alacritty
        kitty
        fuzzel
        fastfetch
        git
        helix
        devenv

        jdkWithFX
        aria2

        nixd
        nixfmt
      ];

      # maybe export my user or smthn
      users.users.ethan.packages = with pkgs; [
        vscodium
        bitwarden-desktop
        hackneyed
        anki

        (discord.override {
          withVencord = true;
        })

        blender
        gimp
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
