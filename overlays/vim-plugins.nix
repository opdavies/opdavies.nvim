final: prev: {
  vimPlugins = prev.vimPlugins // {
    conf-vim = final.vimUtils.buildVimPlugin {
      name = "conf-vim";
      src = final.fetchFromGitHub {
        owner = "tjdevries";
        repo = "conf.vim";
        rev = "master";
        sha256 = "AjiTJsoim0BAnyfqk1IQzNsa6jhFM2+A66E7q9sJqz0=";
      };
    };

    edit-alternate-vim = final.vimUtils.buildVimPlugin {
      name = "edit-alternate-vim";
      src = final.fetchFromGitHub {
        owner = "tjdevries";
        repo = "edit_alternate.vim";
        rev = "master";
        sha256 = "mEKnqYAhgrdxPRoKf4S4yYecdFIHGg8bDxpqPuC1+S4=";
      };
    };

    standard-vim = final.vimUtils.buildVimPlugin {
      name = "standard-vim";
      src = final.fetchFromGitHub {
        owner = "tjdevries";
        repo = "standard.vim";
        rev = "master";
        sha256 = "9VwkvV1Dv6cE4uDkPp36DozjWJOclDR883yDMYw000E=";
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

    vim-autoread = final.vimUtils.buildVimPlugin {
      name = "vim-autoread";
      src = final.fetchFromGitHub {
        owner = "djoshea";
        repo = "vim-autoread";
        rev = "24061f84652d768bfb85d222c88580b3af138dab";
        sha256 = "fSADjNt1V9jgAPjxggbh7Nogcxyisi18KaVve8j+c3w=";
      };
    };

    vim-textobj-indent = final.vimUtils.buildVimPlugin {
      name = "vim-textobj-indent";
      src = final.fetchFromGitHub {
        owner = "kana";
        repo = "vim-textobj-indent";
        rev = "deb76867c302f933c8f21753806cbf2d8461b548";
	sha256 = "oFzUPG+IOkbKZ2gU/kduQ3G/LsLDlEjFhRP0BHBE+1Q=";
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
