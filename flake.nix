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

        haskellPackages = pkgs.haskell.packages.ghc9141.override {
          overrides = self: super: {
            # GHC 9.14 ships with base 4.22, containers 0.8, template-haskell 2.24, time 1.15 - relax bounds
            tagged = pkgs.haskell.lib.doJailbreak super.tagged;
            indexed-traversable = pkgs.haskell.lib.doJailbreak super.indexed-traversable;
            th-abstraction = pkgs.haskell.lib.dontCheck (pkgs.haskell.lib.doJailbreak super.th-abstraction);
            assoc = pkgs.haskell.lib.doJailbreak super.assoc;
            parallel = pkgs.haskell.lib.doJailbreak super.parallel;
            inspection-testing = pkgs.haskell.lib.dontCheck (pkgs.haskell.lib.doJailbreak super.inspection-testing);
            data-default = pkgs.haskell.lib.doJailbreak super.data-default;
            boring = pkgs.haskell.lib.doJailbreak super.boring;
            test-framework = pkgs.haskell.lib.doJailbreak super.test-framework;
            generic-deriving = pkgs.haskell.lib.doJailbreak super.generic-deriving;
            ChasingBottoms = pkgs.haskell.lib.doJailbreak super.ChasingBottoms;
            OneTuple = pkgs.haskell.lib.doJailbreak super.OneTuple;
            these = pkgs.haskell.lib.doJailbreak super.these;
            data-fix = pkgs.haskell.lib.doJailbreak super.data-fix;
            async = pkgs.haskell.lib.doJailbreak super.async;
            bifunctors = pkgs.haskell.lib.doJailbreak super.bifunctors;
            time-compat = pkgs.haskell.lib.doJailbreak super.time-compat;
            text-short = pkgs.haskell.lib.doJailbreak super.text-short;
            uuid-types = pkgs.haskell.lib.doJailbreak super.uuid-types;
            lifted-async = pkgs.haskell.lib.doJailbreak super.lifted-async;
            integer-logarithms = pkgs.haskell.lib.doJailbreak (pkgs.haskell.lib.overrideCabal super.integer-logarithms (old: {
              postPatch = (old.postPatch or "") + ''
                ${pkgs.gnused}/bin/sed -i 's/ghc-bignum >=1.0 && <1.4/ghc-bignum >=1.0/' integer-logarithms.cabal
              '';
            }));
            scientific = pkgs.haskell.lib.doJailbreak super.scientific;
            hedgehog = pkgs.haskell.lib.doJailbreak super.hedgehog;
            tasty-hedgehog = pkgs.haskell.lib.doJailbreak super.tasty-hedgehog;
            vector-th-unbox = pkgs.haskell.lib.doJailbreak super.vector-th-unbox;
            unordered-containers = pkgs.haskell.lib.doJailbreak super.unordered-containers;
            invariant = pkgs.haskell.lib.doJailbreak super.invariant;
            quickcheck-instances = pkgs.haskell.lib.doJailbreak super.quickcheck-instances;
            binary-orphans = pkgs.haskell.lib.doJailbreak super.binary-orphans;
            indexed-traversable-instances = pkgs.haskell.lib.doJailbreak super.indexed-traversable-instances;
            bytes = pkgs.haskell.lib.doJailbreak super.bytes;
            free = pkgs.haskell.lib.doJailbreak super.free;
            lens = pkgs.haskell.lib.doJailbreak super.lens;
            # doctest has GHC 9.14 API incompatibilities - disable tests for packages that use it
            vector = pkgs.haskell.lib.dontCheck super.vector;
          };
        };

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
