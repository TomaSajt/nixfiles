{
  flake.modules.nixos.base = {
    system.stateVersion = "26.05";
  };

  flake.modules.homeManager.base = {
    home.stateVersion = "26.05";
  };
}
