{
  flake.modules.nixos.base = {
    system.stateVersion = "23.11";
  };

  flake.modules.homeManager.base = {
    home.stateVersion = "23.11";
  };
}
