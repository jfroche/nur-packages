{ sources ? import ./nix/sources.nix
, nixpkgsSource ? "nixpkgs-unstable"
, pkgs ? import sources."${nixpkgsSource}" {}
}:
rec {
  searchguard = pkgs.callPackage ./pkgs/searchguard/tlstool.nix {};
}
