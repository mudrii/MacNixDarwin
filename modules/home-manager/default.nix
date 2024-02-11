{ pkgs, config, ... }:

{
  imports = [
    ./dotfiles/bash.nix
    ./dotfiles/zsh.nix
    ./dotfiles/fish.nix
    ./dotfiles/git.nix
    ./dotfiles/nvim.nix
    # ./dotfiles/alacritty.nix
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
      # github-copilot-cli
      # open-interpreter
      # openai
      # openai-whisper
      # openai-whisper-cpp
      awscli2
      bitwarden-cli
      bun
      curl
      fd
      ffmpeg
      fzf
      gh
      git-lfs
      gnupg
      go
      gotools
      highlight
      jq
      less
      lf
      mas
      nix-tree
      nixpkgs-fmt
      nodejs
      nushell
      ocaml
      ollama
      parallel
      pv
      ripgrep
      tree
      universal-ctags
      wget
      zig
      gnutls
      poetry
      (
        python3.withPackages (
          ps: with ps; [
            # langchain
            # openai-triton
            # openai-whisper
            # torch-bin
            accelerate
            autogen
            boto3
            huggingface-hub
            ipython
            jupyter
            numpy
            openai
            pandas
            pip
            pipx
            poetry-core
            pygments
            tiktoken
            torch
            torchaudio
            torchvision
            transformers
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
