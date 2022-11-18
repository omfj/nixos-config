#
# bspwm 
#

{ config, lib, pkgs, ... }:

{
  imports = [
    ../../services/picom.nix
    ../../services/polybar.nix
    ../../services/sxhkd.nix
  ];
  xsession = {
    enable = true;
    windowManager = {
      bspwm = {
        enable = true;
        rules = {
          "Pavucontrol" = {
            state = "floating";
            sticky = true;
          };
          "*:*:Picture in picture" = {
            state = "floating";
            sticky = true;
          };
          "*:*:Picture-in-Picture" = {
            state = "floating";
            sticky = true;
          };
        };
        extraConfig = ''
          xsetroot -cursor_name left_ptr &

          bspc monitor -d 1 2 3 4 5 6 7

          bspc config border_width      3
          bspc config window_gaps      12
          bspc config split_ratio     0.52

          bspc config focus_follows_pointer     true
          bspc config borderless_monocle        true
          bspc config gapless_monocle           true

          bspc config focused_border_color "#777777"

          feh --bg-tile $HOME/.config/wall        # Wallpaper

          killall -q polybar &                    # Reboot polybar to correctly show workspaces
          while pgrep -u $UID -x polybar >/dev/null; do sleep 1;done

          polybar main &
        '';
      };
    };
  };
}
