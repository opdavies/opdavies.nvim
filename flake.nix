{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        lib = import ./lib { inherit inputs; };
      };

      systems = [ "x86_64-linux" ];

      perSystem = { pkgs, self', system, ... }:
        let
          default = self.lib.mkVimPlugin { inherit system; };
          neovim = self.lib.mkNeovim { inherit system; };
        in
        {
          packages = { inherit default neovim; };

          formatter = pkgs.nixpkgs-fmt;
        };
    };
}