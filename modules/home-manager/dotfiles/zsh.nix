{ config, pkgs, ... }:

{
  zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      ls = "ls --color=auto -F";
      nixswitch = "darwin-rebuild switch --flake ~/src/system-config/.#";
      nixup = "pushd ~/src/system-config; nix flake update; nixswitch; popd";
    };
  };
}