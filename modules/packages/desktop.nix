{ self, inputs, ... }: {
  flake.nixosModules.desktop = { pkgs, ... }:
    let
      theme-name = "Tokyonight-Dark";
      theme = pkgs.tokyonight-gtk-theme.override {
        colorVariants = [ "dark" ];
        sizeVariants = [ "standard" ];
        themeVariants = [ "default" ];
      };
    in {
      programs.niri = {
        enable = true;
      };

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

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
                gtk-theme = theme-name;
                icon-theme = "Adwaita";
                color-scheme = "prefer-dark";
                gtk-enable-primary-paste = false;
              };
            };
          }
        ];
      };

      services.displayManager.ly.enable = true;      

      environment.systemPackages = [
        theme
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
        pkgs.adwaita-icon-theme
        pkgs.nautilus
        pkgs.gtk3
        pkgs.gtk4
        pkgs.xwayland-satellite
      ];

      services.gvfs.enable = true;
    };
}