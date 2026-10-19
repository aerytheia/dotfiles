{ self, inputs, ... }: {
  flake.nixosModules.desktop = { pkgs, ... }: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    security.polkit.enable = true;

    programs.labwc.enable = true;
    services.displayManager.ly.enable = true;


    programs.dconf.enable = true;
    programs.dconf.profiles.user.databases = [{
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    }];

    environment.systemPackages = with pkgs; [
      swaybg
      wineWow64Packages.full
      winetricks
      wlr-randr
      mako
      pywalfox-native
      grim
      slurp
      wob
      swayosd
      kanshi
      waybar
      wl-clipboard
      inputs.matugen.packages.${stdenv.hostPlatform.system}.default
    ];
    
    services.gvfs.enable = true;
  };
}
