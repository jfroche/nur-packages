let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  nix-fmt = import sources.nixpkgs-fmt {};
  nix-lint = (import (sources.nix-linter) {}).nix-linter;
in
pkgs.mkShell {
  buildInputs =
    [ pkgs.gitAndTools.pre-commit pkgs.cacert nix-fmt pkgs.cargo nix-lint ];
}
