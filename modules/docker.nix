{
  flake.modules.nixos.docker = {

    virtualisation.docker.enable = true;

    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

  };
}
