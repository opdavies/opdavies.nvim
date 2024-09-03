{ inputs, self }:

let
  inherit (inputs.nixpkgs) legacyPackages;
in
rec {
  mkVimPlugin =
    { system }:
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
        rm -rf $out/.luacheckrc
        rm -rf $out/.markdownlint.yaml
        rm -rf $out/CHANGELOG.md
        rm -rf $out/flake.lock
        rm -rf $out/flake.nix
        rm -rf $out/lib
        rm -rf $out/overlays
        rm -rf $out/run
        rm -rf $out/stylua.toml
        rm -rf $out/todo
      '';
      src = ../.;
    };

  mkNeovimPlugins =
    { system }:
    let
      pkgs = import inputs.nixpkgs {
        inherit system;

        config.allowUnfree = true;

        overlays = [ (import "${self}/overlays/vim-plugins.nix") ];
      };

      opdavies-nvim = mkVimPlugin { inherit system; };
    in
    with pkgs.vimPlugins;
    [
      comment-nvim
      conf-vim
      dial-nvim
      edit-alternate-vim
      fidget-nvim
      gitsigns-nvim
      harpoon
      impatient-nvim
      mini-nvim
      neodev-nvim
      nvim-spectre
      nvim-web-devicons
      oil-nvim
      refactoring-nvim
      standard-vim
      tabline-vim
      treesj
      undotree
      vim-abolish
      vim-autoread
      vim-eunuch
      vim-highlightedyank
      vim-just
      vim-nix
      vim-obsession
      vim-pasta
      vim-repeat
      vim-sleuth
      vim-terraform
      vim-textobj-user
      vim-textobj-xmlattr
      vim-tmux-navigator
      vim-unimpaired
      vim-zoom

      # Testing
      vim-test

      # Git
      committia-vim
      diffview-nvim
      vim-fugitive

      # Debugging
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text

      # Treesitter
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (
        plugins: with plugins; [
          bash
          comment
          css
          csv
          dockerfile
          gitattributes
          gitignore
          go
          html
          javascript
          json
          kdl
          lua
          luadoc
          make
          markdown
          markdown_inline
          nix
          php
          phpdoc
          query
          rst
          scss
          sql
          terraform
          tmux
          twig
          typescript
          vim
          vimdoc
          vue
          xml
          yaml
        ]
      ))
      nvim-treesitter-context
      nvim-treesitter-textobjects

      # LSP, linting and formatting
      conform-nvim
      lsp-status-nvim
      nvim-lint
      nvim-lspconfig

      # Completion
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      cmp-treesitter
      cmp_luasnip
      lspkind-nvim
      nvim-cmp

      # Snippets
      friendly-snippets
      luasnip

      # Telescope
      plenary-nvim
      popup-nvim
      telescope-frecency-nvim
      telescope-fzf-native-nvim
      telescope-live-grep-args-nvim
      telescope-nvim
      telescope-ui-select-nvim

      # Databases
      vim-dadbod
      vim-dadbod-ui
      vim-dadbod-completion

      # Themes
      catppuccin-nvim

      # Configuration.
      opdavies-nvim
    ];

  mkExtraPackages =
    { system }:
    let
      inherit (pkgs) nodePackages lua54Packages php82Packages;

      pkgs = import inputs.nixpkgs {
        inherit system;

        config.allowUnfree = true;
      };
    in
    with pkgs;
    [
      # Languages
      nodePackages.typescript
      nodejs-slim
      php81

      # Language servers
      gopls
      lua-language-server
      lua54Packages.luacheck
      marksman
      nil
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
      phpactor
      terraform-ls

      # Formatters
      black
      eslint_d
      nixfmt-rfc-style
      nodePackages.prettier
      stylua
      yamlfmt

      # Tools
      hadolint
      html-tidy
      nodePackages.jsonlint
      nodePackages.markdownlint-cli
      php82Packages.php-codesniffer
      php82Packages.phpstan
      proselint
      shellcheck
      yamllint
    ];

  mkExtraConfig = ''
    lua << EOF
      require 'opdavies'
    EOF
  '';

  mkNeovim =
    { system }:
    let
      inherit (pkgs) lib neovim;
      extraPackages = mkExtraPackages { inherit system; };
      pkgs = legacyPackages.${system};
      start = mkNeovimPlugins { inherit system; };
    in
    neovim.override {
      configure = {
        customRC = mkExtraConfig;
        packages.main = {
          inherit start;
        };
      };

      extraMakeWrapperArgs = ''--suffix PATH : "${lib.makeBinPath extraPackages}"'';
    };

  mkHomeManager =
    { system }:
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
