{
  flake.modules.homeManager.dev =
    {
      pkgs,
      ...
    }:

    {

      home.packages = with pkgs; [
        bash-language-server
        lua-language-server
        haskell-language-server
        omnisharp-roslyn
        rust-analyzer
        nil
        nixfmt
        ccls
        clang-tools # clangd
        jdt-language-server
        pyright
        tailwindcss-language-server
        eslint
        typescript-language-server
        svelte-language-server
        vscode-langservers-extracted
        prettier
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

          conform-nvim

          (nvim-treesitter.withPlugins (import ./_treesitter-grammars.nix))
        ];

        defaultEditor = true;

        extraLuaConfig = ''
          require "config.main"
        '';
      };

      xdg.configFile."nvim/lua/config".source = ./config;
    };
}
