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
    global.brewfile = true;
    masApps = { };
    casks = [ "raycast" "amethyst" "rsyncui" "insomnia" "podman-desktop" "google-drive" ];
    taps = [ "fujiapple852/trippy" ];
    brews = [ "trippy" "podman" "sha2"];
  };
}
