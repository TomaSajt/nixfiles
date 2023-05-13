{ pkgs, lib, ... }:
{

  xdg.configFile."nvim/lua/config".source = ./config;

  home.packages = with pkgs; [
    unstable.lua-language-server
    haskell-language-server
    omnisharp-roslyn
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
    package = pkgs.unstable.neovim-unwrapped;

    plugins = with pkgs.unstable.vimPlugins; [
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

      nvim-lspconfig
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lua
      luasnip
      lsp-zero-nvim

      (nvim-treesitter.withPlugins
        (import ./treesitter-grammars.nix)
      )

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
