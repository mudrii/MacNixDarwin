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

  home = {
    stateVersion = "23.11";
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
      nix-tree
      git-lfs
      wget
      nushell
      ripgrep
      fd
      curl
      less
      highlight
      lf
      gh
      tree
      parallel
      nix-tree
      bitwarden-cli
      awscli2
      nodejs
      bun
      lua
      pv
      ffmpeg
      universal-ctags
#      github-copilot-cli
#      open-interpreter
#      openai
      openai-whisper-cpp
#      openai-whisper
#      ollama
#      powerline
      poetry
      (
        python3.withPackages (
          ps: with ps; [
#            powerline
            accelerate
            poetry-core
            pip
            pipx
            huggingface-hub
            openai
#            openai-triton
#            openai-whisper
            langchain
            autogen
            pandas
            tiktoken
            ipython
            jupyter
            boto3
#            torch-bin
            transformers
            torch
            torchvision
            torchaudio
            numpy
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
    eza.enable = true;
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

    atuin = {
      enable = true;
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
