{ inputs }:
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
      inherit (pkgs) php82Packages vimPlugins;
      inherit (pkgs.vimUtils) buildVimPlugin;

      pkgs = import inputs.nixpkgs {
        inherit system;

        config.allowUnfree = true;
      };

      pkgs2305 = inputs.nixpkgs-2305.legacyPackages.${system};

      customVim = {
        nvim-tmux-navigation = buildVimPlugin {
          name = "nvim-tmux-navigation";
          src = pkgs.fetchFromGitHub {
            owner = "alexghergh";
            repo = "nvim-tmux-navigation";
            rev = "4898c98702954439233fdaf764c39636681e2861";
            sha256 = "CxAgQSbOrg/SsQXupwCv8cyZXIB7tkWO+Y6FDtoR8xk=";
          };
        };

        tabline-vim = buildVimPlugin {
          name = "tabline-vim";
          src = pkgs.fetchFromGitHub {
            owner = "mkitt";
            repo = "tabline.vim";
            rev = "69c9698a3240860adaba93615f44778a9ab724b4";
            sha256 = "51b8PxyKqBdeIvmmZyF2hpMBjkyrlZDdTB1opr5JZ7Y=";
          };
        };

        vim-caser = buildVimPlugin {
          name = "vim-caser";
          src = pkgs.fetchFromGitHub {
            owner = "arthurxavierx";
            repo = "vim-caser";
            rev = "6bc9f41d170711c58e0157d882a5fe8c30f34bf6";
            sha256 = "PXAY01O/cHvAdWx3V/pyWFeiV5qJGvLcAKhl5DQc0Ps=";
          };
        };

        vim-heritage = buildVimPlugin {
          name = "vim-heritage";
          src = pkgs.fetchFromGitHub {
            owner = "jessarcher";
            repo = "vim-heritage";
            rev = "cffa05c78c0991c998adc4504d761b3068547db6";
            sha256 = "Lebe5V1XFxn4kSZ+ImZ69Vst9Nbc0N7eA9IzOCijFS0=";
          };
        };

        vim-textobj-xmlattr = buildVimPlugin {
          name = "vim-textobj-xmlattr";
          src = pkgs.fetchFromGitHub {
            owner = "whatyouhide";
            repo = "vim-textobj-xmlattr";
            rev = "694a297f1d75fd527e87da9769f3c6519a87ebb1";
            sha256 = "+91FVP95oh00flINdltqx6qJuijYo56tHIh3J098G2Q=";
          };
        };

        vim-zoom = buildVimPlugin {
          name = "vim-zoom";
          src = pkgs.fetchFromGitHub {
            owner = "dhruvasagar";
            repo = "vim-zoom";
            rev = "01c737005312c09e0449d6518decf8cedfee32c7";
            sha256 = "/ADzScsG0u6RJbEtfO23Gup2NYdhPkExqqOPVcQa7aQ=";
          };
        };
      };

      opdavies-nvim = mkVimPlugin { inherit system; };
    in [
      customVim.nvim-tmux-navigation
      customVim.tabline-vim
      customVim.vim-caser
      customVim.vim-heritage
      customVim.vim-textobj-xmlattr
      customVim.vim-zoom

      vimPlugins.comment-nvim
      vimPlugins.dial-nvim
      vimPlugins.fidget-nvim
      vimPlugins.gitsigns-nvim
      vimPlugins.harpoon
      vimPlugins.impatient-nvim
      vimPlugins.mini-nvim
      vimPlugins.neodev-nvim
      vimPlugins.nvim-web-devicons
      vimPlugins.refactoring-nvim
      vimPlugins.rest-nvim
      vimPlugins.undotree
      vimPlugins.vim-eunuch
      vimPlugins.vim-highlightedyank
      vimPlugins.vim-just
      vimPlugins.vim-nix
      vimPlugins.nvim-spectre
      vimPlugins.vim-obsession
      vimPlugins.vim-pasta
      vimPlugins.vim-polyglot
      vimPlugins.vim-repeat
      vimPlugins.vim-sleuth
      vimPlugins.vim-terraform
      vimPlugins.vim-textobj-user
      vimPlugins.vim-unimpaired

      # {
      #   plugin = vimPlugins.vim-sort-motion;
      #   type = "lua";
      #   config = ''
      #     vim.g.sort_motion_flags = "ui"
      #   '';
      # }
      # {
      #   plugin = vimPlugins.treesj;
      #   type = "lua";
      #   config = ''
      #     require "treesj".setup {}
      #   '';
      # }
      vimPlugins.vim-sort-motion
      vimPlugins.treesj

      # Testing
      vimPlugins.vim-test
      vimPlugins.vimux

      # Git
      vimPlugins.committia-vim
      vimPlugins.diffview-nvim

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
      vimPlugins.telescope-file-browser-nvim
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
    in [
      # Languages
      nodePackages.typescript
      pkgs.php81

      # Language servers
      lua54Packages.luacheck
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
      pkgs.nodePackages.prettier
      pkgs.stylua

      # Tools
      nodePackages.jsonlint
      nodePackages.markdownlint-cli
      php82Packages.php-codesniffer
      php82Packages.phpstan
      pkgs.html-tidy
      pkgs.proselint
      pkgs.shellcheck
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
