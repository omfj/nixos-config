#
# Terminal Emulator
#

{ pkgs, ... }:

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        font = rec {
          normal.family = "JetBrainsMono Nerd Font";
          bold = { style = "Bold"; };
          #size = 12; # Also defined in hosts/laptop/home.nix
        };
        colors = rec {
          primary.background = "#151515";
        };
      };
    };
  };
}
