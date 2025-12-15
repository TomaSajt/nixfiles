{
  flake.modules.nixos.base =
    { hostExtraInfo, ... }:
    {
      networking.hostName = hostExtraInfo.name;
    };
}
