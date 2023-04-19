{ config, pkgs, ... }:

{
    programs.tmux = {
      enable = true;
      #keyMode = "vi";
      terminal = "xterm-256color";
      historyLimit = 406000; # Up the history limit
      prefix = "C-a";
      baseIndex = 0; # Index windows from 0
      mouse = true;
      shell = "${pkgs.fish}/bin/fish";
#      plugins = with pkgs [
#     ]
      extraConfig = ''
#        source ${pkgs.python39Packages.powerline}/share/tmux/powerline.conf
       source ${pkgs.powerline}/share/tmux/powerline.conf

        # Lower delay
        set -s escape-time 1

        # Keeps me from having to exit and restart whenever I make a config change.
        bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

        # Bind Ctrl-a Ctrl-a to last window
        bind-key C-a last-window

        # alternative copy mode key
        bind Escape copy-mode

        # pass through xterm keys
        set -g xterm-keys on

        # monitor activity in windows
        setw -g monitor-activity on

#        setw -g xterm-keys on
        set -sg repeat-time 600
        set -s focus-events on

        set -g status on
        set -q -g status-utf8 on
        setw -q -g utf8 on

        setw -g automatic-rename on
        set -g renumber-windows on

        set -g set-titles on
        set -g set-titles-string '#H:#S.#I.#P #W #T'

        set -g display-panes-time 800
        set -g display-time 1000

        set -g status-interval 10

        # Silence bell
        set-option -g visual-bell on

#        set -g visual-bell on
#        set -g bell-action any

#        setw -g monitor-activity on
        set -g visual-activity on

        # Change window-splitting commands
        unbind %
        bind | split-window -h
        bind - split-window -v

        bind C-f command-prompt -p find-session 'switch-client -t %%'

        # Vim style Movement commands
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        bind -r C-h select-window -t :-
        bind -r C-l select-window -t :+

        # Pane resizing commands
        bind H resize-pane -L 2
        bind J resize-pane -D 2
        bind K resize-pane -U 2
        bind L resize-pane -R 2

#        bind -r h select-pane -L  # move left
#        bind -r j select-pane -D  # move down
#        bind -r k select-pane -U  # move up
#        bind -r l select-pane -R  # move right

        bind > swap-pane -D       # swap current pane with the next one
        bind < swap-pane -U       # swap current pane with the previous one

#        bind -r H resize-pane -L 2
#        bind -r J resize-pane -D 2
#        bind -r K resize-pane -U 2
#        bind -r L resize-pane -R 2
      '';
    };
}