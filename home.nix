{ pkgs, lib, ... }:
{
  imports = [ ./hm-modules ./hm-desktop.nix ];
  modules = {
    bash.enable = true;
    code-editors = {
      neovim.enable = true;
    };
    git = {
      enable = true;
      signing = lib.mkDefault false;
    };
    gpg.enable = lib.mkDefault false;
    langs = {
      cpp.enable = true;
      dotnet.enable = true;
      dyalog.enable = true;
      javascript.enable = true;
      python.enable = true;
      uiua.enable = true;
    };
    user-dirs.enable = true;
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
      xclip # Clipboard utils (used for synced neovim clipboard)
      fd # `find` alternative (also used for neovim)
    ];
  };
}
