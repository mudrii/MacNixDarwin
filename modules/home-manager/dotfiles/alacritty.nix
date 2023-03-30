{ config, pkgs, lib, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      scrolling.history = 100000;
      font = {
        normal.family = "MesloLGS Nerd Font Mono";
        size = 16;
      };
    };
  };
}