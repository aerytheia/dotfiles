{ self, inputs, ... }: {
  flake.nixosModules.hjem = { pkgs, ... }: {
    # probably should do this better but i dont rlly care right now
    hjem.users.ethan = {
      directory = "/home/ethan";

      xdg.config.files = {
        "labwc/autostart".source = ../../home/labwc/autostart;
        "labwc/environment".source = ../../home/labwc/environment;
        "labwc/menu.xml".source = ../../home/labwc/menu.xml;
        "labwc/rc.xml".source = ../../home/labwc/rc.xml;

        "matugen/config.toml".source = ../../home/matugen/config.toml;
        "matugen/templates".source = ../../home/matugen/templates;

        "fuzzel/fuzzel.ini".source = ../../home/fuzzel/fuzzel.ini;
        "alacritty/alacritty.toml".source = ../../home/alacritty/alacritty.toml;

        "waybar/config.jsonc".source = ../../home/waybar/config.jsonc;
        "waybar/style.css".source = ../../home/waybar/style.css;

        "wayfire.ini".source = ../../home/wayfire/wayfire.ini;
      };

      files = {
        ".ssh/allowed_signers".source = ../../home/ssh/allowed_signers;
        ".gitconfig".source = ../../home/gitconfig;
      };
    };
  };
}
