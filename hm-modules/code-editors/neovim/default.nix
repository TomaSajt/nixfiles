{ pkgs, lib, config, ... }:

let
  cfg = config.modules.code-editors.neovim;
in
{
  options.modules.code-editors.neovim = {
    enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      lua-language-server
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

      plugins = with pkgs.vimPlugins; [
        vim-nix

        nvim-web-devicons
        gitsigns-nvim

        vim-airline
        vim-airline-themes

        vim-monokai

        indent-blankline-nvim

        nvim-autopairs

        vim-hexokinase # Displays colors for color codes

        plenary-nvim
        telescope-nvim
        telescope-fzf-native-nvim
        telescope-file-browser-nvim


        harpoon
        undotree
        vim-fugitive

        nvim-lspconfig
        lsp-zero-nvim
        nvim-cmp
        cmp-buffer
        cmp-path
        cmp_luasnip
        cmp-nvim-lsp
        cmp-nvim-lua
        luasnip
        omnisharp-extended-lsp-nvim

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
    xdg.configFile."nvim/lua/config".source = ./config;
  };
}
