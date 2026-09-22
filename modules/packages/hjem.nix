{ self, inputs, ... }: {
  flake.nixosModules.hjem = { pkgs, ... }: {
    # probably should do this better but i dont rlly care right now
    hjem.users.ethan = {
      directory = "/home/ethan";

      xdg.config.files."niri/config.kdl".source = ../../home/niri/config.kdl;

      files = {
        ".ssh/allowed_signers".source = ../../home/ssh/allowed_signers;
        ".gitconfig".source = ../../home/gitconfig;
      };
    };
  };
}
