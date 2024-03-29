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
      open-interpreter
      # openai-whisper
      openai-whisper-cpp
      # awscli2
      bitwarden-cli
      cloudflared
      bun
      curl
      duf
      thefuck
      fd
      ffmpeg
      fzf
      git-lfs
      gnupg
      go
      gotools
      highlight
      httpie
      jq
      yq-go
      go-task
      pulumi
      lazydocker
      less
      lf
      tldr
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
      gnutls
      poetry
      rclone
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
    atuin.enable = true;
    btop.enable = true;
    command-not-found.enable = true;
    dircolors.enable = true;
    eza.enable = true;
    fzf.enable = true;
    htop.enable = true;
    info.enable = true;
    jq.enable = true;
    lazygit.enable = true;
    zoxide.enable = true;

    # zellij = {
    #   enable = true;
    #   enableFishIntegration = true;
    # };

    gh = {
      enable = true;
      extensions = with pkgs; [ 
        gh-copilot 
        gh-markdown-preview
      ];
      settings = {
        git_protocol = "ssh";

        prompt = "enabled";

        aliases = {
          pch = "pr checkout";
          pvw = "pr view";
          coe = "copilot explain";
          cos = "copilot suggest";
        };
      };
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
