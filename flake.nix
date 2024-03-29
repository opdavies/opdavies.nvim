{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-2305.url = "github:NixOS/nixpkgs/nixos-23.05";
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      lib = import ./lib { inherit inputs; };

      inherit (lib) mkNeovim mkVimPlugin;
      inherit (pkgs) mkShell;

      default = mkVimPlugin { inherit system; };
      neovim = mkNeovim { inherit system; };
    in {
      devShells.${system}.default =
        mkShell { buildInputs = with pkgs; [ just ]; };

      formatter.${system} = pkgs.nixfmt;

      packages.${system} = { inherit default neovim; };
    };
}
