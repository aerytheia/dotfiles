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
        settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    }];

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