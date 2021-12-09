{ nixpkgs ? import <nixpkgs> {} }:

let
  inherit (nixpkgs) pkgs;
  inherit (pkgs) nodePackages;

in
pkgs.stdenv.mkDerivation {
  name = "my-rust-env";
  shellHook = ''echo -e "\n... loaded Rust env!"'';

  buildInputs = [
    nixpkgs.rustc
    nixpkgs.cargo
    nixpkgs.rustfmt
    nixpkgs.rustPackages.clippy
  ];

}

