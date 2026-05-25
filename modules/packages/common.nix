# my common software between my machines

{ self, inputs, ... }: {
  flake.nixosModules.common = { pkgs, ... }: {
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

    # maybe export my user or smthn
    users.users.ethan.packages = with pkgs; [
      vscodium
      bitwarden-desktop
      hackneyed
      vesktop
      spotify-player
    ];
  };
}