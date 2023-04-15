{ pkgs, lib, ... }:
{

  xdg.configFile."nvim/lua/config".source = ./config;

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      vim-nix

      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-file-browser-nvim

      nvim-treesitter
      nvim-web-devicons
      vim-monokai

      indent-blankline-nvim

      (pkgs.unstable.vimPlugins.nvim-lspconfig)
      (pkgs.unstable.vimPlugins.rust-tools-nvim)

      nvim-autopairs

      nvim-cmp
      cmp-nvim-lsp
      cmp-vsnip
      vim-vsnip
    ];

    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    defaultEditor = true;

    extraLuaConfig = ''
      require "config.main"
    '';
  };
}
