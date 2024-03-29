# Changelog

## 13th March 2024

### Added

* Add `committia.vim` to improve the commit buffer when running `git commit`.

### Changed

* Update `gitsigns` keymaps to use `g` as the prefix for keymaps instead of `h` - e.g. `gb` to `git blame` the current line.

## 12th March 2024

### Added

* Add `diffnvim.nvim` as another way to deal with merge conflicts.
* Add `nvim-spectre` for global find and replace within a project.
* Add `jsonlint` for linting JSON files.

### Changed

* Configure `lua_ls` settings to set the workspace directory.

### Removed

* Remove `nixd` and `rnix-lsp` as they were preventing me from upgrading from an insecure version of nix.

## 11th March 2024

### Added

* Re-add `markdown-preview.nvim`.

## 9th March 2024

### Removed

* Removed Grammarly as it's marked as broken in the Nix store.

## 27th February 2024

### Changed

* Update Telescope keymaps to be more like the ones in <https://github.com/nvim-lua/kickstart.nvim>.
* Update Harpoon keymaps and include keymaps to remove a single file and clear all files.
* Update Telescope to ignore more files and directories by default.
* Replace `christoomey/vim-tmux-navigator` with `alexghergh/nvim-tmux-navigation`.

## 26th February 2024

### Added

* Add `eslint_d` as it's declared as a formatter for JavaScript files.

### Changed

* Update keybindings for snippet completion.

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
