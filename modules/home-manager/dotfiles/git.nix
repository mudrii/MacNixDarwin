{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "mudrii";
    userEmail = "mudreac@gmail.com";
    ignores = [ "*~" "*.swp" ".DS_Store" "._.DS_Store" "**/.DS_Store" "**/._.DS_Store" ];
/*
    signing = {
      key = null; # Let GPG decide
      signByDefault = true;
    };
*/
    aliases = {
      unstage = "reset HEAD --";
      pr = "pull --rebase";
      addp = "add --patch";
      comp = "commit --patch";
      co = "checkout";
      ci = "commit";
      c = "commit";
      b = "branch";
      p = "push";
      d = "diff";
      a = "add";
      s = "status";
      f = "fetch";
      pa = "add --patch";
      pc = "commit --patch";
      rf = "reflog";
      l = "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";
      pp = "!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)";
      recent-branches = "branch --sort=-committerdate";
    };
    
    extraConfig = {
      credential = { helper = "store"; };
      # credential."https://github.com" = {
      #   #helper = "!${pkgs.gh}/bin/gh auth git-credential";
      #   helper = "!/run/current-system/sw/bin/gh auth git-credential";
      # };

      init = { defaultBranch = "main"; };
      pull = { rebase = true; }; # Rebase by default when pulling
      push = { default = "current"; }; # Push to a remote branch with the same name
      fetch = { prune = true; }; # Prune remote branches when fetching
      diff = { algorithm = "histogram"; }; # "Better" diff algorithm
      stash = { showPatch = true; };
      status = { showUntrackedFiles = "all"; };
      transfer = { fsckobjects = false; };

      branch = { 
        autoSetupMerge = "always"; 
        sort = "-committerdate"; # Sort branches by last commit date 
        };

      commit = { 
        verbose = true; # Show the diff when committing
        # gpgsign = true; 
      };

      core = {
        # pager = "less -R";
        # autocrlf = "input";
        editor = "nvim";
      };

      merge = {
        conflictstyle = "zdiff3"; # Also show the common ancestor
        ff = "only";
        summary = true;
        tool = "vimdiff";
        renamelimit = 10000;
      };

      remote = {
        push = [
          "refs/heads/*:refs/heads/*"
          "refs/tags/*:refs/tags/*"
        ];

        fetch = [
          "refs/heads/*:refs/remotes/origin/*"
          "refs/tags/*:refs/tags/*"
        ];
      };

      rebase = {
        stat = true;
        autoSquash = true; # Stash changes before rebasing
        autostash = true;
      };
    };
  };
}
