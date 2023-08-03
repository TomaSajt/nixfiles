{ pkgs, lib, ... }:
{

  xdg.configFile."nvim/lua/config".source = ./config;

  home.packages = with pkgs; [
    lua-language-server
    haskell-language-server
    unstable.csharp-ls
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

      nvim-web-devicons
      vim-monokai

      indent-blankline-nvim

      nvim-autopairs

      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-file-browser-nvim

      harpoon
      undotree
      vim-fugitive

      pkgs.unstable.vimPlugins.nvim-lspconfig
      pkgs.unstable.vimPlugins.lsp-zero-nvim
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lua
      luasnip

      (nvim-treesitter.withPlugins (import ./treesitter-grammars.nix))

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
