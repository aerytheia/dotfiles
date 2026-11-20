{ pkgs, inputs, ... }: let 
    # https://github.com/NixOS/nixpkgs/blob/nixos-26.05/pkgs/by-name/ju/julia-mono/package.nix#L27
    # https://github.com/NixOS/nixpkgs/blob/nixos-26.05/pkgs/data/fonts/nerd-fonts/default.nix
    nerd-fonts-julia-mono = pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
        pname = "nerd-fonts-julia-mono";
        version = "v0.63.2";

        src = pkgs.fetchzip {
            url = "https://github.com/mietzen/juliamono-nerd-font/releases/download/${finalAttrs.version}/fonts.zip";
            stripRoot = false;
            hash = "sha256-3XEGDCfrZUbOawjSXgXGiJYMbd/4s8SYVEWH958hrCA=";
        };

        installPhase = ''
            runHook preInstall

            mkdir -p $out/share/fonts/truetype/NerdFonts/JuliaMono
            mv *.ttf $out/share/fonts/truetype/NerdFonts/JuliaMono

            runHook postInstall
        '';        
    });
in  {
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
    xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
            xdg-desktop-portal-wlr
        ];

        config.common = {
            default = [ "gtk" ];
            "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
            "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
            "org.freedesktop.impl.portal.Secret" = [
                "gnome-keyring"
            ];            
        };
    };


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

    fonts.fontconfig.enable = true;
    fonts.packages = with pkgs; [
        nerd-fonts-julia-mono
        inter
        noto-fonts
        noto-fonts-color-emoji
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