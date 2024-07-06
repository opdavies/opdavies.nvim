{
  inputs = {
    nixpkgs-2305.url = "github:NixOS/nixpkgs/nixos-23.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs =
    { nixpkgs, self, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      lib = import ./lib { inherit inputs self; };

      inherit (lib) mkNeovim mkVimPlugin;

      default = mkVimPlugin { inherit system; };
      neovim = mkNeovim { inherit system; };
    in
    {
      inherit lib;

      formatter.${system} = pkgs.nixfmt-rfc-style;

      packages.${system} = {
        inherit default neovim;
      };
    };
}
