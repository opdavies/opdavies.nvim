# Changelog

## 25th February 2024

* Remove `colorcolumn` and `cursorline`.

## 24th February 2024

### Added

* Add `neodev`.

### Removed

* Remove some unused plugins and packages.
  * e.g. floaterm, projectionist, vim-wiki, vim-easy-align,
    vim-surround, visual-star-search, vim-rhubarb

### Changed

* Tidy neovim configuration
  * Replace none-ls with conform.nvim and nvim-lint.
  * Replace lualine.nvim with mini-statusline.
  * Simplify cmp completion sources.

## 21st February 2024

### Added

* Re-add `vim-just` and `fidget.nvim`.

## 13th February 2024

### Changed

* Use `alejandra` to format Nix files.

## 5th February 2024

### Fixed

* Fix PHPUnit command in `vim-test`.

## 27th January 2024

### Added

* Add vim-floaterm.

### Removed

* Remove Astro plugin and language server.

## 26th January 2024

### Added

* Add vim-wiki.

## 25th January 2024

### Added

* Add `grammarly` language server.

### Changed

* Remove `.gitignore` from the built package.
* Split this configuration from my main NixOS/Home Manager dotfiles repository - <https://github.com/opdavies/dotfiles.nix>.
