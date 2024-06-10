_default:
    just --list

build profile *args:
    nix build --json --no-link --print-build-logs ".#{{ profile }}" {{ args }}

check:
    nix flake check

update:
    nix flake update
