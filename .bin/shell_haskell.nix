{ nixpkgs ? import <nixpkgs> {} }:

let
  inherit (nixpkgs) pkgs;
  inherit (pkgs) haskellPackages;

  haskellDeps = ps: with ps; [
    cassava
    csv
    base
    mtl
    lens
    random
    pipes
    # pipes-async
    async
    concurrency
    pipes-concurrency
    split
    Glob
    parsec
  ];

  ghc = haskellPackages.ghcWithPackages haskellDeps;

in
pkgs.stdenv.mkDerivation {
  name = "my-haskell";
  shellHook = ''echo -e "\n... loaded Haskell env!"'';

  buildInputs = [
    ghc
    pkgs.gdb
    haskellPackages.cabal-install
  ];
}

