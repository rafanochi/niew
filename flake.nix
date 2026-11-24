{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-26.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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

    xinux-modules = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/modules?ref=main&shallow=1";
    };

    apple-fonts.url = "github:pperanich/nix-apple-fonts";
    apple-fonts.inputs.nixpkgs.follows = "nixpkgs";
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
        xinux-modules.nixosModules.shell
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
