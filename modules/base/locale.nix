{
  flake.modules.nixos.base = {
    console.keyMap = "hu";

    # Locale stuff
    i18n =
      let
        HU = "hu_HU.UTF-8";
        EN = "en_US.UTF-8";
      in
      {
        defaultLocale = EN;
        extraLocaleSettings = {
          LC_NUMERIC = EN;
          LC_ADDRESS = HU;
          LC_IDENTIFICATION = HU;
          LC_MEASUREMENT = HU;
          LC_MONETARY = HU;
          LC_NAME = HU;
          LC_PAPER = HU;
          LC_TELEPHONE = HU;
          LC_TIME = HU;
        };
      };

    time = {
      timeZone = "Europe/Budapest";
      hardwareClockInLocalTime = true;
    };
  };
}
