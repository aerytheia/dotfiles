{ self, inputs, ... }: {
  flake.nixosModules.games = { pkgs, ... }: {
    programs.steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];     
    };

    environment.variables = {
      STEAM_USE_NIX_FONTS = "1";
    };

    services.flatpak.packages = [
      # roblox 
      "org.vinegarhq.Sober"
    ];
  };
}