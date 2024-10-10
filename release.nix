let
  nixpkgs = import ./pkgs.nix;
  project = import ((nixpkgs {}).fetchFromGitHub {
    owner = "NCrashed";
    repo = "haskell-nix";
    rev = "eb45250ac342027d92f27fb97949b95dbbe1a689";
    sha256  = "sha256-eG6Bz/XlZqLngCUZGOBjRX7wgpi6TG2BKMeKsPDHWH0=";
  }) { inherit nixpkgs; };
  compiler = "ghc910";
in project {
  inherit compiler;
  packages = {
    GPipe-Core = ./GPipe-Core;
  };
  shellTools = pkgs: with pkgs.haskell.packages."${compiler}"; [
    cabal-install
    haskell-language-server
  ];
}