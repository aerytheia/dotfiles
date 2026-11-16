{ pkgs, inputs, ... }: {
    services.displayManager.ly.enable = true;
    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        package = pkgs.swayfx;
        extraPackages = with pkgs; [ swayidle swaylock wmenu ];
    };

    security.polkit.enable = true;
    # maybe will get a different keyring
    services.gnome.gnome-keyring.enable = true;
    # probably need a portal too


    # will configure in hjem later, just for now
    programs.dconf.enable = true;
    programs.dconf.profiles.user.databases = [{
        lockAll = false;
        settings = {
            "org/gnome/desktop/interface" = {
                gtk-theme = "Adwaita-dark";
                color-scheme = "prefer-dark";
            };
        };
    }];

    qt = {
        enable = true;
        style = "kvantum";
        platformTheme = "qt5ct";
    };

    environment.systemPackages = [
        pkgs.gnome-themes-extra
        pkgs.qt6Packages.qt6ct
        pkgs.qt6Packages.qtstyleplugin-kvantum
    ];

    # idk if i need this
    # programs.nix-ld = {
    #     enable = true;
    #     libraries = with pkgs; [
    #         alsa-lib
    #         zlib
    #         libgcc
    #     ];
    # };
}