{ self, inputs, ... }: {
  flake.nixosModules.desktop = { pkgs, ... }: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    security.polkit.enable = true;

    programs.labwc.enable = true;
    services.displayManager.ly.enable = true;

    programs.dconf.profiles.user.databases = [{
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    }];

    environment.systemPackages = with pkgs; [
      wineWow64Packages.full
      winetricks
      wlr-randr
    ];

    services.gvfs.enable = true;
  };
}
