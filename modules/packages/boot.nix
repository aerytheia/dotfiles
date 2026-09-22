{ self, inputs, ... }: {
  flake.nixosModules.boot = { ... }: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.timeout = 0;

    boot.consoleLogLevel = 0;
    boot.kernelParams = [
      "quiet"
      "splash"
      "udev.log_level=0"
    ];
    systemd.settings.Manager.ShowStatus = "no";

    boot.plymouth = {
      enable = true;
      theme = "bgrt";
    };

    boot.initrd.systemd.enable = true;
  };
}
