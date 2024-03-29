{ config, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
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
      lsa = "exa --long --all --group --header --group-directories-first --sort=type --icons";
      lsg = "exa --long --all --group --header --git";
      lst = "exa --long --all --group --header --tree --level ";
      lless = "set -gx LESSOPEN '|pygmentize -f terminal256 -g -P style=monokai %s' && set -gx LESS '-R' && less -m -g -i -J -u -Q";
      vdir = "vdir --color=auto";
      lss = "ls --color=auto -F";
      vim = "nvim";
      nixsw = "darwin-rebuild switch --flake ~/src/system-config/.#";
      nixup = "pushd ~/src/system-config; nix flake update; nixsw; popd";
    };
  };
}
