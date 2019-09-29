let
  targetConfigs = {
    "nixpkgs-unstable" = {
      nixpkgsSource = "nixpkgs-unstable";
    };
    "nixos-19_09" = {
      nixpkgsSource = "nixos-19.09";
    };
  };
  recurseIntoAttrs = as: as // { recurseForDerivations = true; };

  targets = builtins.mapAttrs packagesFor targetConfigs;

  packagesFor = _targetName: targetConfig:
    recurseIntoAttrs (import ./default.nix { inherit (targetConfig) nixpkgsSource; });
in
recurseIntoAttrs targets
