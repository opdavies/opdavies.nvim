{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs-2305.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs =
    inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        lib = import ./lib { inherit inputs self; };
      };

      systems = [ "x86_64-linux" ];

      perSystem =
        {
          config,
          pkgs,
          system,
          ...
        }:
        {
          apps = {
            nvim = {
              program = "${config.packages.neovim}/bin/nvim";
              type = "app";
            };
          };

          packages = {
            default = self.lib.mkVimPlugin { inherit system; };
            neovim = self.lib.mkNeovim { inherit system; };
          };

          formatter = pkgs.nixfmt-rfc-style;
        };
    };
}
