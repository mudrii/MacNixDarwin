{ pkgs, ... }:

{
  home = {
    stateVersion = "22.11";
    sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      EDITOR = "nvim";
      PAGER = "less -FirSwX";
      SHELL = "fish";
      CLICLOLOR = 1;
      # MANPAGER = "nvim -c 'set ft=man' -";
      TERM = "xterm-256color";
    };
    packages = with pkgs; [
      ripgrep
      fd
      curl
      less
      exa
      highlight
      lf
      gh
      bitwarden-cli
#      powerline
      (
        python39.withPackages (
          ps: with ps; [
            poetry-core
            pip
            #powerline
            pygments
            xstatic-pygments
          ]
        )
      )
    ];
  };

  programs = {
    jq.enable = true;
    command-not-found.enable = true;
    exa.enable = true;
    htop.enable = true;
    info.enable = true;

    dircolors = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };

    bat = {
      enable = true;
      config = {
        theme = "TwoDark";
        paging = "always";
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
  };
#  home.file.".inputrc".source = ./dotfiles/inputrc;
}
