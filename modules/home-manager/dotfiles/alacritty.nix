{ config, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        "TERM" = "xterm-256color";
      };
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        decorations = "none";
      };
      scrolling.history = 100000;
      font = {
        normal = {
          family = "MesloLGS Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "MesloLGS Nerd Font Mono";
          style = "Bold";
        };
        bold_italic = {
          family = "MesloLGS Nerd Font Mono";
          style = "Bold Italic";
        };
        italic = {
          family = "MesloLGS Nerd Font Mono";
          style = "Italic";
        };
        size = 16.0;
        offset = {
          x = 1;
          y = 1;
        };
      };
      window.opacity = 1.0;
    };
  };
}