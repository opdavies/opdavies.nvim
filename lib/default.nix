{ inputs }:

let
  inherit (inputs.nixpkgs) legacyPackages;
in
rec {
  mkVimPlugin = { system }:
    let
      inherit (pkgs) vimUtils;
      inherit (vimUtils) buildVimPlugin;
      pkgs = legacyPackages.${system};
    in
    buildVimPlugin {
      name = "opdavies";
      postInstall = ''
        rm -rf $out/.envrc
        rm -rf $out/.gitignore
        rm -rf $out/CHANGELOG.md
        rm -rf $out/flake.lock
        rm -rf $out/flake.nix
        rm -rf $out/lib
        rm -rf $out/run
        rm -rf $out/stylua.toml
      '';
      src = ../.;
    };

  mkNeovimPlugins = { system, }:
    let
      inherit (pkgs) vimPlugins;

      pkgs = (import inputs.nixpkgs {
        inherit system;

        config.allowUnfree = true;
      });

      customVim = {
        toggle-checkbox-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "toggle-checkbox-nvim";
          src = pkgs.fetchFromGitHub {
            owner = "opdavies";
            repo = "toggle-checkbox.nvim";
            rev = "main";
            sha256 = "4YSEagQnLK5MBl2z53e6sOBlCDm220GYVlc6A+HNywg=";
          };
        };

        vim-heritage = pkgs.vimUtils.buildVimPlugin {
          name = "vim-heritage";
          src = pkgs.fetchFromGitHub {
            owner = "jessarcher";
            repo = "vim-heritage";
            rev = "cffa05c78c0991c998adc4504d761b3068547db6";
            sha256 = "Lebe5V1XFxn4kSZ+ImZ69Vst9Nbc0N7eA9IzOCijFS0=";
          };
        };

        vim-textobj-xmlattr = pkgs.vimUtils.buildVimPlugin {
          name = "vim-textobj-xmlattr";
          src = pkgs.fetchFromGitHub {
            owner = "whatyouhide";
            repo = "vim-textobj-xmlattr";
            rev = "694a297f1d75fd527e87da9769f3c6519a87ebb1";
            sha256 = "+91FVP95oh00flINdltqx6qJuijYo56tHIh3J098G2Q=";
          };
        };

        tabline-vim = pkgs.vimUtils.buildVimPlugin {
          name = "tabline-vim";
          src = pkgs.fetchFromGitHub {
            owner = "mkitt";
            repo = "tabline.vim";
            rev = "69c9698a3240860adaba93615f44778a9ab724b4";
            sha256 = "51b8PxyKqBdeIvmmZyF2hpMBjkyrlZDdTB1opr5JZ7Y=";
          };
        };

        vim-caser = pkgs.vimUtils.buildVimPlugin {
          name = "vim-caser";
          src = pkgs.fetchFromGitHub {
            owner = "arthurxavierx";
            repo = "vim-caser";
            rev = "6bc9f41d170711c58e0157d882a5fe8c30f34bf6";
            sha256 = "PXAY01O/cHvAdWx3V/pyWFeiV5qJGvLcAKhl5DQc0Ps=";
          };
        };

        vim-zoom = pkgs.vimUtils.buildVimPlugin {
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
    in
    [
      customVim.tabline-vim
      customVim.vim-caser
      customVim.vim-heritage
      customVim.vim-textobj-xmlattr
      customVim.vim-zoom
      vimPlugins.vim-visual-star-search

      # {
      #   plugin = customVim.toggle-checkbox-nvim;
      #   type = "lua";
      #   config = ''
      #     vim.keymap.set("n", "<leader>t", ":lua require('toggle-checkbox').toggle()<CR>")
      #   '';
      # }

      vimPlugins.harpoon
      vimPlugins.refactoring-nvim
      vimPlugins.comment-nvim
      vimPlugins.dial-nvim
      vimPlugins.gitsigns-nvim
      vimPlugins.impatient-nvim
      vimPlugins.nvim-web-devicons
      vimPlugins.rest-nvim
      vimPlugins.undotree
      vimPlugins.vim-easy-align
      vimPlugins.vim-eunuch
      vimPlugins.vim-highlightedyank
      vimPlugins.vim-nix
      vimPlugins.vim-obsession
      vimPlugins.vim-pasta
      vimPlugins.vim-polyglot
      vimPlugins.vim-projectionist
      vimPlugins.vim-repeat
      vimPlugins.vim-sleuth
      vimPlugins.vim-surround
      vimPlugins.vim-terraform
      vimPlugins.vim-textobj-user
      vimPlugins.vim-tmux-navigator
      vimPlugins.vim-unimpaired

      vimPlugins.lualine-nvim

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

      # Git
      vimPlugins.vim-fugitive
      vimPlugins.vim-rhubarb

      # Debugging
      vimPlugins.nvim-dap
      vimPlugins.nvim-dap-ui
      vimPlugins.nvim-dap-virtual-text

      # Treesitter
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.nvim-treesitter-context
      vimPlugins.nvim-treesitter-textobjects

      # LSP, linting and formatting
      vimPlugins.conform-nvim
      vimPlugins.lsp-status-nvim
      vimPlugins.none-ls-nvim
      vimPlugins.nvim-lspconfig

      # Completion
      vimPlugins.cmp-buffer
      vimPlugins.cmp-cmdline
      vimPlugins.cmp-nvim-lsp
      vimPlugins.cmp-nvim-lsp-signature-help
      vimPlugins.cmp-path
      vimPlugins.cmp-tabnine
      vimPlugins.cmp-treesitter
      vimPlugins.cmp-vsnip
      vimPlugins.cmp_luasnip
      vimPlugins.lspkind-nvim
      vimPlugins.nvim-cmp
      vimPlugins.phpactor

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

      # Wiki
      vimPlugins.vimwiki

      # Configuration.
      opdavies-nvim
    ];

  mkExtraPackages = { system }:
    let
      inherit (pkgs) nodePackages;

      pkgs = (import inputs.nixpkgs {
        inherit system;

        config.allowUnfree = true;
      });
    in
    [
      # Languages
      nodePackages.typescript
      pkgs.php81

      # Language servers
      nodePackages."@tailwindcss/language-server"
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.grammarly-languageserver
      nodePackages.intelephense
      nodePackages.typescript-language-server
      nodePackages.vls
      nodePackages.volar
      nodePackages.vscode-langservers-extracted
      nodePackages.vue-language-server
      nodePackages.yaml-language-server
      pkgs.ansible-language-server
      pkgs.gopls
      pkgs.lua-language-server
      pkgs.nixd
      pkgs.phpactor
      pkgs.rnix-lsp
      pkgs.terraform-ls

      # Formatters
      pkgs.black
      pkgs.nodePackages.prettier
      pkgs.stylua

      # Tools
      pkgs.html-tidy
      pkgs.nodePackages.markdownlint-cli
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
    in
    neovim.override {
      configure = {
        customRC = mkExtraConfig;
        packages.main = { inherit start; };
      };

      extraMakeWrapperArgs = ''--suffix PATH : "${lib.makeBinPath extraPackages}"'';
    };

  mkHomeManager = { system }:
    let
      extraConfig = mkExtraConfig;
      extraPackages = mkExtraPackages { inherit system; };
      plugins = mkNeovimPlugins { inherit system; };
    in
    {
      inherit extraConfig extraPackages plugins;

      enable = true;
    };
}
