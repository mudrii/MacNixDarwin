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
    systemPackages = [ pkgs.coreutils ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
#    allowUnsupportedSystem = true;
#    permittedInsecurePackages = [
#      "python3.10-tensorflow-2.11.1"
#      "tensorflow-2.11.1"
#      "tensorflow-2.11.1-deps.tar.gz"
#      ];
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
      powerline-fonts
#      nerdfonts
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
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    masApps = {
      "Yubico Authenticator" = 1497506650;
      "Encrypto" = 935235287;
      "Pixelmator Pro" = 1289583905;
      "HotKey" = 975890633;
      "StopTheMadness" = 1376402589;
      "Goodnotes" = 1444383602;
      "Orbot" = 1609461599;
      "Keynote" = 409183694;
      "GarageBand" = 682658836;
      "ISD Go" = 1447072980;
      "Numbers" = 409203825;
      "Xcode" = 497799835;
      "Bitwarden" = 1352778147;
      "Pages" = 409201541;
      "iMovie" = 408981434;
      "Dropover" = 1355679052;
      "Meeter" = 1510445899;
      "System Monitor" = 423368786;
      "UTM" = 1538878817;
      "Battery Monitor" = 413678017;
      "Telegram Lite" = 946399090;
      "Velja" = 1607635845;
      "Omnivore" = 1564031042;
      "Keka" = 470158793;
      };
    global = {
      brewfile = true;
      autoUpdate = true;
    };
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
     # extraFlags = [ "--verbose" ];
    };
    casks = [ 
      "raycast" 
      "amethyst" 
      "rsyncui" 
      "insomnia" 
      "podman-desktop" 
      "google-drive"
      "google-chrome"
      "discord"
      "slack"
      "zoom"
    ];
    brews = [ 
      "trippy" 
      "podman" 
      "sha2"
      "openai-whisper"
    ];
    taps = [ "fujiapple852/trippy" ];
  };
}
