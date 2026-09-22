{ self, inputs, ... }: {
  flake.nixosModules.desktop = { pkgs, ... }: {
    programs.niri = {
      enable = true;
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    security.polkit.enable = true;

    programs.dconf = {
      enable = true;
      profiles.user.databases = [
        {
          lockAll = false;
          settings = {
            "ca/desrt/dconf-editor" = {
              show-warning = false;
            };
            "org/gnome/desktop/interface" = {
              #gtk-theme = theme-name;
              icon-theme = "Adwaita";
              color-scheme = "prefer-dark";
              gtk-enable-primary-paste = false;
            };
          };
        }
      ];
    };

    nix.settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };

    services.displayManager.ly.enable = true;

    environment.systemPackages = [
      #theme
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.adwaita-icon-theme
      pkgs.nautilus
      pkgs.gtk3
      pkgs.gtk4
      pkgs.polkit_gnome
      pkgs.xwayland-satellite
      pkgs.wineWow64Packages.full
      pkgs.winetricks
    ];

    services.gvfs.enable = true;
  };
}
