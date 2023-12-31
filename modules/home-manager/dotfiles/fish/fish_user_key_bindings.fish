# enables $?
function bind_status
  commandline -i (echo '$status')
end

# enables $$
function bind_self
	#  commandline -i (echo '%self')
  commandline -i (echo '$fish_pid')
end

# enable keybindings
function fish_user_key_bindings
  bind '$?' bind_status
  bind '$$' bind_self
  bind `!` bind_bang
  bind '$' bind_dollar
end

function bind_bang
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function bind_dollar
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# Fish shell keybindings
# set --universal fish_key_bindings fish_vi_key_bindings
# function fish_hybrid_key_bindings --description \
# "Vi-style bindings that inherit emacs-style bindings in all modes"
#   for mode in default insert visual
#     fish_default_key_bindings -M $mode
# end
#     fish_vi_key_bindings --no-erase
# end
# set -g fish_key_bindings fish_hybrid_key_bindings
#
# function fish_mode_prompt
#   switch $fish_bind_mode
#     case default
#       set_color --bold red
#       echo 'N'
#     case insert
#       set_color --bold green
#       echo 'I'
#     case replace_one
#       set_color --bold green
#       echo 'R'
#     case visual
#       set_color --bold brmagenta
#       echo 'V'
#     case '*'
#       set_color --bold red
#       echo '?'
#     end
#     set_color normal
#    end
