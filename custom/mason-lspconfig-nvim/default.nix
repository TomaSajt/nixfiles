{ pkgs ? import <nixpkgs> { }, ... }:
pkgs.vimUtils.buildVimPluginFrom2Nix {
  name = "mason-lspconfig-nvim";
  src = pkgs.fetchFromGitHub
    {
      owner = "williamboman";
      repo = "mason-lspconfig.nvim";
      rev = "2b811031febe5f743e07305738181ff367e1e452";
      sha256 = "QBFz00ssMrEQ9gmuVMxu2WcvOqozvuk0m62GxYfLYoU=";
    };
}
