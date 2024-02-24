_default:
    just --list

build profile:
    nix build --json --no-link --print-build-logs ".#{{ profile }}"

check:
    nix flake check
