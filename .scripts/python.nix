{ nixpkgs ? import <nixpkgs> {} }:

let
  inherit (nixpkgs) pkgs;
  inherit (pkgs) python38Packages;

in
pkgs.stdenv.mkDerivation {
  name = "my-python-env";
  shellHook = ''echo -e "\n... loaded Python env!"'';

  buildInputs = [
	python38Packages.numpy
	# python38Packages.tensorflow
	# python38Packages.pytorch
    # python38Packages.Keras
	python38Packages.pandas
    python38Packages.matplotlib
    python38Packages.jupyter
    # python38Packages.seaborn
    # python38Packages.scikitlearn
  ];

}

