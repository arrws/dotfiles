{ nixpkgs ? import <nixpkgs> {} }:

let
  inherit (nixpkgs) pkgs;
  inherit (pkgs) nodePackages;

in
pkgs.stdenv.mkDerivation {
  name = "my-typescript-env";
  shellHook = ''echo -e "\n... loaded TypeScript env!"'';

  buildInputs = [
    nixpkgs.nodejs
	nodePackages.typescript
	nodePackages.json
	nodePackages.npm
  ];

}

