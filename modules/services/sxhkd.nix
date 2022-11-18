#
# Keyboard shortcuts
#

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.xsession.enable) {
    services = {
      sxhkd = {
        enable = true;
        keybindings = {
          # Rofi
          "super + d" = "rofi -show drun"; # Open rofi (custom theme " -theme theme.rasi")

          # Apps
          "super + shift + Return" = "alacritty"; # Open terminal
          "super + shift + f" = "pcmanfm";        # File manager
          "super + shift + w" = "firefox";        # Web browser
          "super + shift + s" = "spotify";        # Music
          "Print" = "flameshot gui";              # Start flameshot gui

          # bspwm general
          "super + alt + q" = "bspc quit";  # Exit bspwm
          "super + alt + r" = "bspc wm -r"; # Reload bspwm
          "super + q" = "bspc node -c";    # Quit application
          "super + shift + q" = "bspc node -k";     # Kill application

          # bspwm state
          "super + m" = "bspc desktop -l next";                  # Alternatve between tiled and monocle
          "super + t" = "bspc node -t tiled";                    # Tile node
          "super + f" = "bspc node -t fullscreen";               # Fullscreen node
          "super + space" = "bspc node -t floating";             # Float node
          "super + shift + space" = "bspc node -t pseudo_tiled"; # Psuedo tile node

          # bspwm flags
          "super + ctrl + m" = "bspc node -g marked";  # Set node to marked
          "super + ctrl + x" = "bspc node -g locked";  # Set node to locked
          "super + ctrl + y" = "bspc node -g sticky";  # Set node to sticky
          "super + ctrl + z" = "bspc node -g private"; # Set node to private

          # bspwm focus
          "super + {h, j, k, l}" = "bspc node -f {west, south, north, east}";         # Focus node
          "super + shift + {h, j, k, l}" = "bspc node -s {west, south, north, east}"; # Move node
          "alt + Tab" = "bspc node -f next.local.!hidden.window";                     # "Alt-tab" to next
          "alt + shift + Tab" = "bspc node -f prev.local.!hidden.window";             # "Alt-tab" to prev
          "super + {1-9,0}" = "bspc desktop -f '{1-9,10}'";                     # Go to workspace
          "super + shift + {1-9,0}" = "bspc node -d focused:'^{1-9,10}'";             # Move node to workspace (and follow)


          # bspwm move/resize
          "super + alt + {h, j, k, l}" = "bspc node -z {left -20 0, bottom 0 20, top 0 -20, right 20 0}";
          "super + alt + shift + {h, j, k, l}" = "bspc node -z {right -20 0, top 0 20, bottom 0 -20, left 20 0}";
          "super + {Left, Down, Up, Right}" = "bspc node -v {-20 0, 0 20, 0 -20, 20 0}";
          #"super + shift + {h, j, k, l}" = "bspwm_smart_move {west, south, north, east}";

          # Lock screen
          "super + x" = "betterlockscreen --lock blur";

          # XF86 Keys
          "XF86AudioRaiseVolume" = "pamixer -i 5";     # Raise volume
          "XF86AudioLowerVolume" = "pamixer -d 5";     # Lower volume
          "XF86AudioMute" = "pamixer -t";              # Mute volume
          "XF86AudioMicMute" = "dunstify \"Not set\""; # Toggle mute mic audio

          # Brightness
          "XF86MonBrightnessUp" = "light -A 10";   # Increase backlight
          "XF86MonBrightnessDown" = "light -U 10"; # Decrease backlight
        };
      };
    };
  };
}
