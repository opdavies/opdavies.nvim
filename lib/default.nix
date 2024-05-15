{ inputs, self }:

let inherit (inputs.nixpkgs) legacyPackages;
in rec {
  mkVimPlugin = { system }:
    let
      inherit (pkgs) vimUtils;
      inherit (vimUtils) buildVimPlugin;

      pkgs = legacyPackages.${system};
    in buildVimPlugin {
      name = "opdavies";
      postInstall = ''
        rm -rf $out/.envrc
        rm -rf $out/.gitignore
        rm -rf $out/.luacheckrc
        rm -rf $out/.tmuxinator.yaml
        rm -rf $out/CHANGELOG.md
        rm -rf $out/flake.lock
        rm -rf $out/flake.nix
        rm -rf $out/justfile
        rm -rf $out/lib
        rm -rf $out/run
        rm -rf $out/stylua.toml
      '';
      src = ../.;
    };

  mkNeovimPlugins = { system }:
    let
      inherit (pkgs) vimPlugins;
      inherit (pkgs.vimUtils) buildVimPlugin;

      pkgs = import inputs.nixpkgs {
        inherit system;

        config.allowUnfree = true;

        overlays = [ (import "${self}/overlays/vim-plugins.nix") ];
      };

      pkgs2305 = inputs.nixpkgs-2305.legacyPackages.${system};

      opdavies-nvim = mkVimPlugin { inherit system; };
    in [
      vimPlugins.nvim-tmux-navigation
      vimPlugins.tabline-vim
      vimPlugins.vim-caser
      vimPlugins.vim-heritage
      vimPlugins.vim-textobj-xmlattr
      vimPlugins.vim-zoom

      inputs.nixpkgs-2305.legacyPackages.${system}.vimPlugins.rest-nvim
      vimPlugins.comment-nvim
      vimPlugins.dial-nvim
      vimPlugins.fidget-nvim
      vimPlugins.gitsigns-nvim
      vimPlugins.harpoon
      vimPlugins.impatient-nvim
      vimPlugins.mini-nvim
      vimPlugins.neodev-nvim
      vimPlugins.nvim-web-devicons
      vimPlugins.oil-nvim
      vimPlugins.refactoring-nvim
      vimPlugins.undotree
      vimPlugins.vim-eunuch
      vimPlugins.vim-highlightedyank
      vimPlugins.vim-just
      vimPlugins.vim-nix
      vimPlugins.nvim-spectre
      vimPlugins.vim-obsession
      vimPlugins.vim-pasta
      vimPlugins.vim-repeat
      vimPlugins.vim-sleuth
      vimPlugins.vim-terraform
      vimPlugins.vim-textobj-user
      vimPlugins.vim-unimpaired

      vimPlugins.treesj

      # Testing
      vimPlugins.vim-test
      vimPlugins.vimux

      # Git
      vimPlugins.committia-vim
      vimPlugins.diffview-nvim
      vimPlugins.vim-fugitive

      # Debugging
      vimPlugins.nvim-dap
      vimPlugins.nvim-dap-ui
      vimPlugins.nvim-dap-virtual-text

      # Treesitter
      (vimPlugins.nvim-treesitter.withPlugins (p: [
        p.bash
        p.comment
        p.css
        p.csv
        p.dockerfile
        p.gitattributes
        p.gitignore
        p.go
        p.html
        p.javascript
        p.json
        p.just
        p.lua
        p.luadoc
        p.make
        p.markdown
        p.markdown_inline
        p.nix
        p.php
        p.phpdoc
        p.query
        p.rst
        p.scss
        p.sql
        p.terraform
        p.tmux
        p.twig
        p.typescript
        p.vim
        p.vimdoc
        p.vue
        p.xml
        p.yaml
      ]))
      vimPlugins.nvim-treesitter-context
      vimPlugins.nvim-treesitter-textobjects

      # LSP, linting and formatting
      vimPlugins.conform-nvim
      vimPlugins.lsp-status-nvim
      vimPlugins.nvim-lint
      vimPlugins.nvim-lspconfig

      # Completion
      pkgs2305.vimPlugins.phpactor
      vimPlugins.cmp-buffer
      vimPlugins.cmp-cmdline
      vimPlugins.cmp-nvim-lsp
      vimPlugins.cmp-path
      vimPlugins.cmp-treesitter
      vimPlugins.cmp_luasnip
      vimPlugins.lspkind-nvim
      vimPlugins.nvim-cmp

      # Snippets
      vimPlugins.friendly-snippets
      vimPlugins.luasnip

      # Telescope
      vimPlugins.plenary-nvim
      vimPlugins.popup-nvim
      vimPlugins.telescope-frecency-nvim
      vimPlugins.telescope-fzf-native-nvim
      vimPlugins.telescope-live-grep-args-nvim
      vimPlugins.telescope-nvim
      vimPlugins.telescope-ui-select-nvim

      # Databases
      vimPlugins.vim-dadbod
      vimPlugins.vim-dadbod-ui
      vimPlugins.vim-dadbod-completion

      vimPlugins.markdown-preview-nvim

      # # Markdown
      # {
      #   plugin = vimPlugins.markdown-preview-nvim;
      #   type = "lua";
      #   config = ''
      #     vim.g.mkdp_refresh_slow = 1
      #   '';
      # }

      # Themes
      vimPlugins.catppuccin-nvim

      # Configuration.
      opdavies-nvim
    ];

  mkExtraPackages = { system }:
    let
      inherit (pkgs) nodePackages lua54Packages php82Packages;

      pkgs = import inputs.nixpkgs {
        inherit system;

        config.allowUnfree = true;
      };

      inherit (pkgs) hadolint;
    in [
      # Languages
      nodePackages.typescript
      pkgs.nodejs-slim
      pkgs.php81

      # Language servers
      lua54Packages.luacheck
      pkgs.marksman
      nodePackages."@tailwindcss/language-server"
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.intelephense
      nodePackages.typescript-language-server
      nodePackages.vls
      nodePackages.volar
      nodePackages.vscode-langservers-extracted
      nodePackages.vue-language-server
      nodePackages.yaml-language-server
      pkgs.gopls
      pkgs.lua-language-server
      pkgs.nil
      pkgs.phpactor
      pkgs.terraform-ls

      # Formatters
      pkgs.alejandra
      pkgs.black
      pkgs.eslint_d
      pkgs.nixfmt
      pkgs.nodePackages.prettier
      pkgs.stylua
      pkgs.yamlfmt

      # Tools
      hadolint
      nodePackages.jsonlint
      nodePackages.markdownlint-cli
      php82Packages.php-codesniffer
      php82Packages.phpstan
      pkgs.html-tidy
      pkgs.proselint
      pkgs.shellcheck
      pkgs.yamllint
    ];

  mkExtraConfig = ''
    lua << EOF
      require 'opdavies'
    EOF
  '';

  mkNeovim = { system }:
    let
      inherit (pkgs) lib neovim;
      extraPackages = mkExtraPackages { inherit system; };
      pkgs = legacyPackages.${system};
      start = mkNeovimPlugins { inherit system; };
    in neovim.override {
      configure = {
        customRC = mkExtraConfig;
        packages.main = { inherit start; };
      };

      extraMakeWrapperArgs =
        ''--suffix PATH : "${lib.makeBinPath extraPackages}"'';
    };

  mkHomeManager = { system }:
    let
      extraConfig = mkExtraConfig;
      extraPackages = mkExtraPackages { inherit system; };
      plugins = mkNeovimPlugins { inherit system; };
    in {
      inherit extraConfig extraPackages plugins;

      enable = true;
    };
}
