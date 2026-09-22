{ self, inputs, ... }: {
  flake.nixosModules.games = { pkgs, ... }: {
    programs.gamescope.enable = true;
    programs.gamemode.enable = true;

    programs.steam = {
      enable = true;
      protontricks.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    environment.variables = {
      STEAM_USE_NIX_FONTS = "1";
    };

    services.flatpak.packages = [
      # roblox
      "org.vinegarhq.Sober"
    ];

    users.users.ethan.packages = with pkgs; [
      prismlauncher
      
      (heroic.override {
        extraPkgs =
          pkgs': with pkgs'; [
            gamescope
            gamemode
          ];
      })
    ];
  };
}
