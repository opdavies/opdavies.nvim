{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = inputs@{ flake-parts, self, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem = { pkgs, self', ... }: {
        packages = {
          default = pkgs.vimUtils.buildVimPlugin {
            name = "opdavies";
            postInstall = ''
              rm $out/.envrc
              rm $out/flake.lock
              rm $out/flake.nix
              rm $out/stylua.toml
            '';
            src = ./.;
          };
        };

        formatter = pkgs.nixpkgs-fmt;
      };
  };
}
