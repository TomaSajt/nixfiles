{ pkgs, lib, ... }:
{
  imports = [
    ./hm-modules
    ./home-graphical.nix
  ];

  modules = {
    bash.enable = lib.mkDefault true;
    code-editors = {
      neovim.enable = lib.mkDefault true;
    };
    git = {
      enable = lib.mkDefault true;
      signing = lib.mkDefault true;
    };
    gpg.enable = lib.mkDefault true;
    langs = {
      cpp.enable = lib.mkDefault true;
      dotnet.enable = lib.mkDefault true;
      dyalog.enable = lib.mkDefault true;
      javascript.enable = lib.mkDefault true;
      python.enable = lib.mkDefault true;
      rust.enable = lib.mkDefault true;
      uiua.enable = lib.mkDefault true;
    };
    user-dirs.enable = lib.mkDefault true;
  };

  # Automatic external disk mounting to /var/run/mount
  services.udiskie = {
    enable = true;
    tray = "auto";
  };

  home = {
    username = "toma";
    stateVersion = "23.11";
    packages = with pkgs; [
      ntfs3g # NTFS Filesystem Support
      ripgrep # grep in filesystem (also used for telescope.nvim support for grep)
      # Clipboard utils (used for synced neovim clipboard)
      xclip
      wl-clipboard
      fd # `find` alternative (also used for neovim)
      killall
    ];
  };
}
