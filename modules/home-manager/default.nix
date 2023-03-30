{ pkgs, ... }: {
  home = {
    stateVersion = "22.11";
    sessionVariables = {
      # SHELL = "fish";
      PAGER = "less";
      CLICLOLOR = 1;
      EDITOR = "nvim";
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
      (
        python39.withPackages (
          ps: with ps; [
            #poetry
            pip
            powerline
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
    dircolors.enable = true;
    htop.enable = true;
    info.enable = true;

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

#    starship = {
#      enable = true;
#      enableZshIntegration = true;
#    };
  };
#  home.file.".inputrc".source = ./dotfiles/inputrc;
}
