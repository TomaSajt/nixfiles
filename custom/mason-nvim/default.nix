{ pkgs ? import <nixpkgs> { }, ... }:
pkgs.vimUtils.buildVimPluginFrom2Nix {
  name = "mason-nvim";
  src = pkgs.fetchFromGitHub
    {
      owner = "williamboman";
      repo = "mason.nvim";
      rev = "9f6fd51ce6a3381fbed5fe33169ff20b5bd8f00b";
      sha256 = "CqPLycdxPA68+JSmEFVnDfVIs9FPLYy5ILczjdFgqi0=";
    };
}
