{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      ccat = "pygmentize -f terminal256 -g -P style=monokai";
      gadc = "git add -A; and git commit";
      gad = "git add .";
      gcm = "git commit";
      gch = "git checkout";
      gdf = "git diff";
      gl = "git log";
      glg = "git log --color --graph --pretty --oneline";
      gpl = "git pull";
      gps = "git push";
      gst = "git status";
      la = "exa --long --all --group --header --group-directories-first --sort=type --icons";
      lg = "exa --long --all --group --header --git";
      lt = "exa --long --all --group --header --tree --level ";
      lless = "set -gx LESSOPEN '|pygmentize -f terminal256 -g -P style=monokai %s' && set -gx LESS '-R' && less -m -g -i -J -u -Q";
      vdir = "vdir --color=auto";
      ls = "ls --color=auto -F";
      vim = "nvim";
      nixsw = "darwin-rebuild switch --flake ~/src/system-config/.#";
      nixup = "pushd ~/src/system-config; nix flake update; nixsw; popd";
    };
  };
}