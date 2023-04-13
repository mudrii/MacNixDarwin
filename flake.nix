{
  description = "Ion flake";
  inputs = {
    # called derivations that say how to build software.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # nixos-22.11

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ nixpkgs, home-manager, darwin, ... }: {
    darwinConfigurations.MacBook-Pro-64 =
      darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        modules = [
          ./modules/darwin
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.mudrii.imports = [
                ./modules/home-manager
                ./modules/home-manager/dotfiles/bash.nix
                ./modules/home-manager/dotfiles/zsh.nix
                ./modules/home-manager/dotfiles/fish.nix
                ./modules/home-manager/dotfiles/git.nix
                ./modules/home-manager/dotfiles/nvim.nix
                ./modules/home-manager/dotfiles/alacritty.nix
                ./modules/home-manager/dotfiles/tmux.nix
                ./modules/home-manager/dotfiles/tmux.nix
                ./modules/home-manager/dotfiles/kitty.nix
                ./modules/home-manager/dotfiles/lf.nix
                ./modules/home-manager/dotfiles/ssh.nix
              ];
            };
          }
        ];
      };
    darwinConfigurations.mudrii14 =
      darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        modules = [
          ./modules/darwin
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.mudrii.imports = [
                ./modules/home-manager
                ./modules/home-manager/dotfiles/bash.nix
                ./modules/home-manager/dotfiles/zsh.nix
                ./modules/home-manager/dotfiles/fish.nix
                ./modules/home-manager/dotfiles/git.nix
                ./modules/home-manager/dotfiles/nvim.nix
                ./modules/home-manager/dotfiles/alacritty.nix
                ./modules/home-manager/dotfiles/tmux.nix
                ./modules/home-manager/dotfiles/tmux.nix
                ./modules/home-manager/dotfiles/kitty.nix
                ./modules/home-manager/dotfiles/lf.nix
                ./modules/home-manager/dotfiles/ssh.nix
              ];
            };
          }
        ];
      };
  };
}