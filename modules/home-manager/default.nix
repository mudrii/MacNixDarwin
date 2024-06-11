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
      # openai-whisper
      bun
      cloudflared
      curl
      duf
      fd
      ffmpeg
      fzf
      git-lfs
      git-secrets
      gnupg
      gnutls
      go
      go-task
      gotools
      highlight
      httpie
      jq
      lazydocker
      less
      lf
      mas
      nix-tree
      nixpkgs-fmt
      nodejs
      nushell
      open-interpreter
      openai-whisper-cpp
      parallel
      poetry
      pulumi
      pv
      rclone
      ripgrep
      thefuck
      tldr
      tree
      universal-ctags
      wget
      yq-go
      (
        python3.withPackages (
          ps: with ps; [
            # openai-triton
            openai-whisper
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
            setuptools
            tiktoken
            torch
            torchaudio
            torchvision
            transformers
            xstatic-pygments
            opencv4
            langchain
            #langchain-openai
            #langchain_google_genai
            #langchain-community
            #python-dotenv
            #pyaudio
            #soundfile
            #SpeechRecognition
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
