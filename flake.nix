{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-2305.url = "github:NixOS/nixpkgs/nixos-23.05";

    nixd-nightly.inputs.nixpkgs.follows = "nixpkgs";
    nixd-nightly.url = "github:nix-community/nixd";
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = { lib = import ./lib { inherit inputs; }; };

      systems = [ "x86_64-linux" ];

      perSystem = { pkgs, self', system, ... }:
        let
          default = self.lib.mkVimPlugin { inherit system; };
          neovim = self.lib.mkNeovim { inherit system; };
        in {
          devShells.default =
            pkgs.mkShell { nativeBuildInputs = [ pkgs.just pkgs.nixfmt ]; };

          packages = { inherit default neovim; };

          formatter = pkgs.nixfmt;
        };
    };
}
