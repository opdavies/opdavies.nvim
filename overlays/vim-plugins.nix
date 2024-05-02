final: prev: {
  vimPlugins = prev.vimPlugins // {
    nvim-tmux-navigation = final.vimUtils.buildVimPlugin {
      name = "nvim-tmux-navigation";
      src = final.fetchFromGitHub {
        owner = "alexghergh";
        repo = "nvim-tmux-navigation";
        rev = "4898c98702954439233fdaf764c39636681e2861";
        sha256 = "CxAgQSbOrg/SsQXupwCv8cyZXIB7tkWO+Y6FDtoR8xk=";
      };
    };

    tabline-vim = final.vimUtils.buildVimPlugin {
      name = "tabline-vim";
      src = final.fetchFromGitHub {
        owner = "mkitt";
        repo = "tabline.vim";
        rev = "69c9698a3240860adaba93615f44778a9ab724b4";
        sha256 = "51b8PxyKqBdeIvmmZyF2hpMBjkyrlZDdTB1opr5JZ7Y=";
      };
    };

    vim-caser = final.vimUtils.buildVimPlugin {
      name = "vim-caser";
      src = final.fetchFromGitHub {
        owner = "arthurxavierx";
        repo = "vim-caser";
        rev = "6bc9f41d170711c58e0157d882a5fe8c30f34bf6";
        sha256 = "PXAY01O/cHvAdWx3V/pyWFeiV5qJGvLcAKhl5DQc0Ps=";
      };
    };

    vim-heritage = final.vimUtils.buildVimPlugin {
      name = "vim-heritage";
      src = final.fetchFromGitHub {
        owner = "jessarcher";
        repo = "vim-heritage";
        rev = "cffa05c78c0991c998adc4504d761b3068547db6";
        sha256 = "Lebe5V1XFxn4kSZ+ImZ69Vst9Nbc0N7eA9IzOCijFS0=";
      };
    };

    vim-textobj-xmlattr = final.vimUtils.buildVimPlugin {
      name = "vim-textobj-xmlattr";
      src = final.fetchFromGitHub {
        owner = "whatyouhide";
        repo = "vim-textobj-xmlattr";
        rev = "694a297f1d75fd527e87da9769f3c6519a87ebb1";
        sha256 = "+91FVP95oh00flINdltqx6qJuijYo56tHIh3J098G2Q=";
      };
    };

    vim-zoom = final.vimUtils.buildVimPlugin {
      name = "vim-zoom";
      src = final.fetchFromGitHub {
        owner = "dhruvasagar";
        repo = "vim-zoom";
        rev = "01c737005312c09e0449d6518decf8cedfee32c7";
        sha256 = "/ADzScsG0u6RJbEtfO23Gup2NYdhPkExqqOPVcQa7aQ=";
      };
    };
  };
}
