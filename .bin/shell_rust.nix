{ nixpkgs ? import <nixpkgs> {} }:


let
  # inherit (nixpkgs) pkgs;
  # Rolling updates, not deterministic.
  pkgs = import (fetchTarball("channel:nixpkgs-unstable")) {};

in
pkgs.stdenv.mkDerivation {
  name = "my-rust-env";
  shellHook = ''echo -e "\n... loaded Rust env!"'';

  buildInputs = [
    pkgs.rustc
    pkgs.cargo
    pkgs.rustfmt
    pkgs.rustPackages.clippy
  ];

}


