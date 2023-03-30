{ pkgs, ... }: 

{
  services.nix-daemon.enable = true;

  # programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [ 
      bash
      zsh
      fish
    ];
    loginShell = pkgs.fish;
    systemPackages = [ pkgs.coreutils ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
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
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 14;
      KeyRepeat = 1;
    };

  };
  # backwards compatibility; don't change
  system.stateVersion = 4;
	  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    #casks = [ "raycast" "amethyst" ];
    taps = [ "fujiapple852/trippy" ];
    brews = [ "trippy" ];
  };
}