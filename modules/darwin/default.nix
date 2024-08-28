{ pkgs, config, ... }: 

{ 
  services.nix-daemon.enable = true;
  users = {
    users = {
      mudrii = {
        shell = pkgs.fish;
        home = "/Users/mudrii";
      };
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  programs = {
    zsh.enable = true;
    fish.enable = true;
  };

  environment = {
    shells = with pkgs; [
      bash
      zsh
      fish
    ];
    
    loginShell = pkgs.fish;
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];

    systemPackages = with pkgs; [
      coreutils 
      # (python3Full.withPackages(ps: with ps; [
      # Add any additional Python packages you want here
      # ]))
    ];
    variables = {
      # PYTHON = "${pkgs.python3Full}/bin/python3";
    };

    shellAliases = {
      # python = "python3";
    };
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
      allowBroken = true;
      # allowUnsupportedSystem = true;
      # permittedInsecurePackages = [
      #   "python3.10-tensorflow-2.11.1"
      #   "tensorflow-2.11.1"
      #   "tensorflow-2.11.1-deps.tar.gz"
      # ];
    };
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  fonts = {
    packages = with pkgs; [
      # powerline-fonts
      # nerdfonts
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];
  };
 
  system.defaults = {
    dock.autohide = true;

    finder = {
      AppleShowAllFiles = true;
      _FXShowPosixPathInTitle = true;
    };

    NSGlobalDomain = {
      AppleShowAllExtensions = false;
      InitialKeyRepeat = 14;
      KeyRepeat = 1;
    };

  };

  # backwards compatibility; don't change
  system.stateVersion = 4; 
}
