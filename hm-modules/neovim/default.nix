{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:

let
  cfg = config.modules.neovim;
in
{
  options.modules.neovim = {
    enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      bash-language-server
      lua-language-server
      haskell-language-server
      #omnisharp-roslyn
      rust-analyzer
      nil
      nixfmt-rfc-style
      nixpkgs-fmt
      ccls
      jdt-language-server
      pyright
      tailwindcss-language-server
      nodejs.pkgs.eslint
      nodejs.pkgs.typescript-language-server
      nodejs.pkgs.svelte-language-server
      nodejs.pkgs.vscode-langservers-extracted
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
        nvim-cmp
        cmp-buffer
        cmp-path
        cmp_luasnip
        friendly-snippets
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
        nixos_config = {
          is_graphical = ${if osConfig.isGraphical then "true" else "false"}
        }
        require "config.main"
      '';
    };
    xdg.configFile."nvim/lua/config".source = ./config;
  };
}
