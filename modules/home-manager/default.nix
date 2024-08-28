{ pkgs, config, ... }:

let
  gollama = pkgs.callPackage ./overlay/gollama.nix {};
in

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
      # openai-whisper
      # open-webui
      # bun
      cloudflared
      curl
      duf
      fd
      ffmpeg
      git-lfs
      git-secrets
      gnupg
      gnutls
      go
      gollama
      go-task
      gotools
      highlight
      httpie
      lazydocker
      less
      lf
      mas
      nix-tree
      nixpkgs-fmt
      nodejs
      nushell
      openai-whisper-cpp
      parallel
      poetry
      pulumi
      pv
      rclone
      ripgrep
      thefuck
      tlrc
      tree
      universal-ctags
      wget
      yq-go
      (
        python3.withPackages (
          ps: with ps; [
            # openai-triton
            # torch-bin
            accelerate
            autogen
            boto3
            huggingface-hub
            ipympl
            ipython
            jupyter
            langchain
            matplotlib
            numpy
            ollama
            open-interpreter
            openai
            openai-whisper
            opencv4
            pandas
            pip
            pipx
            poetry-core
            pygments
            setuptools
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
    atuin.enable = true;
    btop.enable = true;
    command-not-found.enable = true;
    dircolors.enable = true;
    htop.enable = true;
    info.enable = true;
    jq.enable = true;
    lazygit.enable = true;
    zoxide.enable = true;

    # zellij = {
    #   enable = true;
    #   enableFishIntegration = true;
    # };

    eza = {
      enable = true;
      git = true;
    };

    fzf = {
      enable = true;
    };

    bat = {
      enable = true;
      config = {
        theme = "TwoDark";
        paging = "always";
      }; 
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
