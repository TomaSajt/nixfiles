{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true; # Doesn't actually work, because home.sessionVariables is broken for some reason
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix

      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-file-browser-nvim

      nvim-treesitter
      nvim-web-devicons
      vim-monokai

      (pkgs.unstable.vimPlugins.nvim-lspconfig)
      rust-tools-nvim

      nvim-autopairs

      nvim-cmp
      cmp-nvim-lsp
      cmp-vsnip
      vim-vsnip
    ];
    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
