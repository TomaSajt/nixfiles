{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        git
        vim
        wget
        zip
        unzip
        file
        rsync
      ];
    };

  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
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
