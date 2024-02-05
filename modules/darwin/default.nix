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
    # caskArgs.no_quarantine = true;
    masApps = {
      "Battery Monitor" = 413678017;
      "Dropover" = 1355679052;
      "Encrypto" = 935235287;
      "HotKey" = 975890633;
      "ISD Go" = 1447072980;
      "Keynote" = 409183694;
      "Meeter" = 1510445899;
      "Numbers" = 409203825;
      # "Omnivore" = 1564031042;
      "Orbot" = 1609461599;
      "Pages" = 409201541;
      "Pixelmator Pro" = 1289583905;
      "StopTheMadness Pro" = 6471380298;
      "System Monitor" = 423368786;
      "Telegram Lite" = 946399090;
      "UTM" = 1538878817;
      "Velja" = 1607635845;
      "Xcode" = 497799835;
      "iMovie" = 408981434;
      };
    global = {
      brewfile = true;
      autoUpdate = true;
    };
    onActivation = {
      upgrade = true;
      cleanup = "uninstall";
      };
    casks = [ 
      "amethyst" 
      "arc"
      "authy"
      "bitwarden"
      "discord"
      "downie"
      "drawio"
      "figma"
      "firefox"
      "google-chrome"
      "google-drive"
      "grammarly-desktop" 
      "insomnia"
      "keka"
      "latest"
      "little-snitch"
      "lm-studio"
      "maccy"
      "miniconda"
      "ollama"
      "podman-desktop"
      "postman"
      "raycast" 
      "rsyncui"
      "slack"
      "soulver"
      "soulver-cli"
      "viber"
      "whatsapp"
      "yubico-authenticator"
      "yubico-yubikey-manager"
      "zoom"
      "zotero"
    ];
    brews = [ 
      "podman" 
      "sha2"
      "trippy" 
      # "openai-whisper"
    ];
    taps = [ "fujiapple852/trippy" ];
  };
}
