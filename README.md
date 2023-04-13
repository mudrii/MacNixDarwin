# Mac Nix

## Install nix on Mac

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

## Test installed nix

```bash
nix-shell -p nix-info --run "nix-info -m"
```

## Create flake configuration

```bash
mkdir -p ~/src/system-config
cd ~/src/system-config
vim flake.nix
```

### Initial flake configuration file

```nix
{
  description = "my minimal flake";
  inputs = {
    # Where we get most of our software. Giant mono repo with recipes
    # called derivations that say how to build software.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # nixos-22.11

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs: {
    darwinConfigurations.Demos-Virtual-Machine =
      inputs.darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };
        modules = [
          ({ pkgs, ... }: {
            # here go the darwin preferences and config items
            programs.zsh.enable = true;
            environment.shells = [ pkgs.bash pkgs.zsh pkgs.fish ];
            environment.loginShell = pkgs.zsh;
            environment.systemPackages = [ pkgs.coreutils ];
            nix.extraOptions = ''
              experimental-features = nix-command flakes
            '';
            system.keyboard.enableKeyMapping = true;
            system.keyboard.remapCapsLockToEscape = true;
            fonts.fontDir.enable = true; # DANGER
            fonts.fonts =
              [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];
            services.nix-daemon.enable = true;
            system.defaults.finder.AppleShowAllExtensions = true;
            system.defaults.finder._FXShowPosixPathInTitle = true;
            system.defaults.dock.autohide = true;
            system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
            system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
            system.defaults.NSGlobalDomain.KeyRepeat = 1;
            # backwards compat; don't change
            system.stateVersion = 4;
          })
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.demo.imports = [
                ({ pkgs, ... }: {
                  # Don't change this when you change package input. Leave it alone.
                  home.stateVersion = "22.11";
                  # specify my home-manager configs
                  home.packages = [ pkgs.ripgrep pkgs.fd pkgs.curl pkgs.less ];
                  home.sessionVariables = {
                    PAGER = "less";
                    CLICLOLOR = 1;
                    EDITOR = "nvim";
                  };
                  programs.bat.enable = true;
                  programs.bat.config.theme = "TwoDark";
                  programs.fzf.enable = true;
                  programs.fzf.enableZshIntegration = true;
                  programs.exa.enable = true;
                  programs.git.enable = true;
                  programs.zsh.enable = true;
                  programs.zsh.enableCompletion = true;
                  programs.zsh.enableAutosuggestions = true;
                  programs.zsh.enableSyntaxHighlighting = true;
                  programs.zsh.shellAliases = { ls = "ls --color=auto -F"; };
                  programs.starship.enable = true;
                  programs.starship.enableZshIntegration = true;
                  programs.alacritty = {
                    enable = true;
                    settings.font.normal.family = "MesloLGS Nerd Font Mono";
                    settings.font.size = 16;
                  };
                })
              ];
            };
          }
        ];
      };
  };
}
```

## build and install

```nix
nix --extra-experimental-features "nix-command flakes" build .#darwinConfigurations.macbook.system

./result/sw/bin/darwin-rebuild switch --flake ~/src/system-config

printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf

/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t

./result/sw/bin/darwin-rebuild switch --flake ~/src/system-config
```

## Remove unnecessary files directly managed by Nix

```nix
sudo rm /etc/nix/nix.conf /etc/shells

./result/sw/bin/darwin-rebuild switch --flake ~/src/system-config
```

## change default shell

```sh
chsh -s /run/current-system/sw/bin/fish
```

## Rebuild on configurations changes

```nix
darwin-rebuild switch --flake ~/src/system-config/.#
```

### Optional

#### link
```shell
sudo ln -s /Users/mudrii/Applications/JetBrains\ Toolbox/  JetBrains\ Apps
sudo ln -s /Users/mudrii/Applications/Home\ Manager\ Apps/  Home\ Manager\ Apps                                                  3697ms
sudo ln -s /Users/mudrii/Applications Users\ Apps
```
