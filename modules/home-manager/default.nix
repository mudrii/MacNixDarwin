{ pkgs, ... }: {
  home = {
    stateVersion = "22.11";
    sessionVariables = {
      SHELL = "fish";
      PAGER = "less";
      CLICLOLOR = 1;
      EDITOR = "nvim";
    };
    packages = with pkgs; [
      ripgrep
      fd
      curl
      less
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

    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    alacritty = {
      enable = true;
      settings.font.normal.family = "MesloLGS Nerd Font Mono";
      settings.font.size = 16;
    };
  };
#  home.file.".inputrc".source = ./dotfiles/inputrc;
}
