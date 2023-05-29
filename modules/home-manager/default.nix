{ pkgs, config, ... }:

{
  imports = [
    ./dotfiles/bash.nix
    ./dotfiles/zsh.nix
    ./dotfiles/fish.nix
    ./dotfiles/git.nix
    ./dotfiles/nvim.nix
    ./dotfiles/alacritty.nix
    ./dotfiles/tmux.nix
    ./dotfiles/kitty.nix
    ./dotfiles/lf.nix
    ./dotfiles/ssh.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

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
      awscli2
      nodejs
      pv
      ffmpeg
#      powerline
      (
        python310.withPackages (
          ps: with ps; [
            poetry-core
            pip
            openai
            langchain
            pandas
            openai-whisper
            tiktoken
            ipython
            jupyter
            boto3
#            powerline
#            torch-bin
            torch
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
