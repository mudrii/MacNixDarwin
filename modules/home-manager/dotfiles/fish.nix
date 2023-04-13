{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
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
      nixsw = "darwin-rebuild switch --flake ~/src/system-config/.#";
      nixup = "pushd ~/src/system-config; nix flake update; nixsw; popd";
      vim = "nvim";
      ucl = "nix-collect-garbage -d && nix-store --gc && nix-store --repair --verify --check-contents && nix-store --optimise -vvv";
      scl = "sudo nix-collect-garbage -d && sudo nix-store --gc && sudo nix-store --repair --verify --check-contents && sudo nix-store --optimise -vvv";
      acl = "ucl && scl";
    };
    plugins = [{
      name = "bobthefish";
      src = pkgs.fetchFromGitHub {
        owner = "oh-my-fish";
        repo = "theme-bobthefish";
        rev = "76cac812064fa749ffc258a20398c6f6250860c5";
        # sha256 = lib.fakeSha256;
        sha256 = "7nZ25R75WsSPqSmyeJbRQ49cITxL3D5CfyplsixFlY8=";
      };
    }];
    loginShellInit = ''
      direnv hook fish | source
    '';
    interactiveShellInit = ''
      set -g theme_display_git yes
      set -g theme_display_git_dirty yes
      set -g theme_display_git_untracked yes
      set -g theme_display_git_ahead_verbose yes
      set -g theme_display_git_dirty_verbose yes
      set -g theme_display_git_stashed_verbose yes
      set -g theme_display_git_master_branch yes
      set -g theme_git_worktree_support no
      set -g theme_display_vagrant no
      set -g theme_display_docker_machine yes
      set -g theme_display_k8s_context yes
      set -g theme_display_hg no
      set -g theme_display_virtualenv yes
      set -g theme_display_ruby no
      set -g theme_display_user ssh
      set -g theme_display_hostname ssh
      set -g theme_display_vi no
      set -g theme_display_date no
      set -g theme_display_cmd_duration yes
      set -g theme_title_display_process yes
      set -g theme_title_display_path yes
      set -g theme_title_display_user yes
      set -g theme_title_use_abbreviated_path no
      set -g theme_avoid_ambiguous_glyphs yes
      set -g theme_powerline_fonts yes
      set -g theme_nerd_fonts no
      set -g theme_show_exit_status yes
      set -g theme_color_scheme dark
      set -g fish_prompt_pwd_dir_length 0
      set -g theme_project_dir_length 1
      set -g direnv_fish_mode eval_on_arrow
      set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
      set -x PAGER less
      set -x LESS -R
      set -x TERM xterm-256color
      set -x VISUAL nvim
      set -x EDITOR nvim

      # Do not show any greeting
      set --universal --erase fish_greeting
#      function fish_greeting; end

      # Kitty Shell Integration
      if set -q KITTY_INSTALLATION_DIR
        set --global KITTY_SHELL_INTEGRATION enabled
        source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
        set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
      end

      # Direnv Integration
      if type -q direnv
        function __direnv_export_eval --on-variable PWD
          status --is-command-substitution; and return
          eval (direnv export fish)
        end
      else
        echo "Install direnv first! Check http://direnv.net" 2>&1
      end
    '';

    functions = {
      __fish_command_not_found_handler = {
        body = "__fish_default_command_not_found_handler $argv[1]";
        onEvent = "fish_command_not_found";
      };
      sudobangbang = {
        onEvent = "fish_preexec";
        body = "abbr !! sudo $argv[1]";
      };
#      bind_status = {
#        body = "commandline -i (echo '$status')";
#      };
#      bind_self = {
#        body = "commandline -i (echo '%self')";
#      };
#      fish_user_key_bindings = {
#        body = "
#          bind '$?' bind_status
#          bind '$$' bind_self
#          bind ! bind_bang
#          bind '$' bind_dollar
#        ";
#      };
#      bind_bang = {
#        body = "
#          switch (commandline -t)
#          case '!'
#            commandline -t $history[1]; commandline -f repaint
#          case '*'
#            commandline -i !
#          end
#        ";
#      };
#      bind_dollar = {
#        body = "
#          switch (commandline -t)
#          case '!'
#            commandline -t $history[1]; commandline -f repaint
#          case '*'
#            commandline -i '$'
#          end
#        ";
#      };
      bind_ctrl_r = {
        body = "
          switch (commandline -t)
          case '^R'
            commandline -t $history[1]; commandline -f repaint
          case '*'
            commandline -i '^R'
          end
        ";
      };
    };
  };
  home = {
    file = {
      fish_user_key_bindings = {
        source = ./fish/fish_user_key_bindings.fish;
        target = ".config/fish/functions/fish_user_key_bindings.fish";
      };
    };
  };
}