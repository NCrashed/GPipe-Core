{
  description = "GPipe - Typesafe functional GPU graphics programming for Haskell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        haskellPackages = pkgs.haskell.packages.ghc910;

        gpipe = haskellPackages.callCabal2nix "GPipe" ./GPipe-Core { };

        runtimeDeps = with pkgs; [
          libGL
          libGLU
        ];

      in
      {
        packages = {
          default = gpipe;
          GPipe = gpipe;
        };

        devShells.default = haskellPackages.shellFor {
          packages = _: [ gpipe ];

          nativeBuildInputs = with pkgs; [
            pkg-config
            haskellPackages.cabal-install
            haskellPackages.haskell-language-server
          ];

          buildInputs = runtimeDeps;

          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath runtimeDeps;
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
