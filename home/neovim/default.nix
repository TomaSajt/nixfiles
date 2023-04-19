{ pkgs, lib, ... }:
{

  xdg.configFile."nvim/lua/config".source = ./config;

  home.packages = with pkgs; [
    unstable.lua-language-server
    unstable.omnisharp-roslyn
    rust-analyzer
    rnix-lsp
    ccls
    nodePackages_latest.eslint
    nodePackages_latest.typescript-language-server
    nodePackages_latest.pyright
    nodePackages_latest.svelte-language-server
    nodePackages_latest.vscode-langservers-extracted
  ];

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      vim-nix

      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-file-browser-nvim

      nvim-treesitter.withAllGrammars
      harpoon
      undotree
      vim-fugitive

      pkgs.unstable.vimPlugins.nvim-lspconfig
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lua
      luasnip
      pkgs.unstable.vimPlugins.lsp-zero-nvim

      nvim-web-devicons
      vim-monokai

      indent-blankline-nvim

      nvim-autopairs


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
