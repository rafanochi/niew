{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-26.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    relago = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/relago.git?shallow=1";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs-unstable";
      };
    };

    nix-data = {
      url = "github:xinux-org/nix-data";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.snowfall-lib.mkFlake {
      # You must provide our flake inputs to Snowfall Lib.
      inherit inputs;
      src = ./.;

      systems.modules.nixos = with inputs; [
        relago.nixosModules.default
        nix-data.nixosModules.nix-data
      ];

      snowfall = {
        namespace = "niew";

        meta = {
          name = "niew-flake";
          title = "Niew Flake";
        };
      };
    };
}
