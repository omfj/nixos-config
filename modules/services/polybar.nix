#
# Bar
#

{ config, lib, pkgs, ... }:

let
  mypolybar = pkgs.polybar.override {
    alsaSupport = true;
    pulseSupport = true;
  };
in
{
  config = lib.mkIf (config.xsession.enable) {
    services = {
      polybar = {
        enable = true;
        script = ''
          #  Handled by bspwmrc (modules/desktop/bspwm)
        '';
        package = mypolybar;
        config = {
          "bar/main" = {
            width = "100%";
            height = 30;
            fixed-center = true;

            enable-ipc = true;

            background = "#111";
            foreground = "#eee";

            border-size = 3;
            border-color = "#111";

            module-margin-left = 1;
            module-margin-right = 1;

            font-0 = "SourceCodePro:size=12";
            font-1 = "FontAwesome6Free:style=Solid:size=10";
            font-2 = "FontAwesome6Free:style=Regular:size=10";
            font-3 = "FontAwesome6Brands:style=Regular:size=10";
            font-4 = "FiraCodeNerdFont:size=12";

            modules-left = "bspwm";
            modules-right = "backlight pad memory cpu pad mic sink volume pad battery date";

            tray-position = "right";
            tray-detached = "false";

            wm-restack = "bspwm";
          };
          "module/memory" = {                     # RAM
            type = "internal/memory";
            format = "<label>"; #<bar-used>";
            format-foreground = "#999";
            label = "  %percentage_used%%";
          };
          "module/cpu" = {                        # CPU
            type = "internal/cpu";
            interval = 1;
            format = "<label>"; # <ramp-coreload>";
            format-foreground = "#999";
            label = "  %percentage%%";
          };
          "module/volume" = {                     # Volume
            type = "internal/pulseaudio";
            interval = 2;
            use-ui-max = "false";
            format-volume = "<ramp-volume>  <label-volume>";
            label-muted = "  muted";
            label-muted-foreground = "#66";

            ramp-volume-0 = "";
            ramp-volume-1 = "";
            ramp-volume-2 = "";

            click-right = "${pkgs.pavucontrol}/bin/pavucontrol";  # Right click opens pavucontrol, left click mutes, scroll changes levels
          };
          "module/backlight" = {                  # Keeping for the futur when i have a screen that supports xbacklight
            type = "internal/backlight";          # Now doen with sxhkb shortcuts
            card = "intel_backlight";
            #use-actual-brightness = "false";
            format = "<ramp> <bar>";

            ramp-0 = "";
            ramp-1 = "";
            ramp-2 = "";

            bar-width = 10;
            bar-indicator = "|";
            bar-indicator-font = 3;
            bar-indicator-foreground = "#ff";
            bar-fill = "─";
            bar-fill-font = 3;
            bar-fill-foreground = "ff"; #"#c9665e";
            bar-empty = "─";
            bar-empty-font = 3;
            bar-empty-foreground = "#44";
          };
          "module/battery" = {                    # Show battery (only when exist), uncomment to show battery and animations
            type = "internal/battery";
            full-at = 98;

            label-full = "%percentage%%";
            label-charging = "%percentage%%";
            label-discharging = "%percentage%%";

            format-charging = "<animation-charging> <label-charging>    ";
            format-discharging = "<ramp-capacity> <label-discharging>    ";
            format-full = "<ramp-capacity> <label-full>    ";

            ramp-capacity-0 = "";
            ramp-capacity-0-foreground = "#f53c3c";
            ramp-capacity-1 = "";
            ramp-capacity-1-foreground = "#ffa900";
            ramp-capacity-2 = "";
            ramp-capacity-3 = "";
            ramp-capacity-4 = "";

            bar-capacity-width = 10;
            bar-capacity-format = "%{+u}%{+o}%fill%%empty%%{-u}%{-o}";
            bar-capacity-fill = "█";
            bar-capacity-fill-foreground = "#ddffffff";
            bar-capacity-fill-font = 3;
            bar-capacity-empty = "█";
            bar-capacity-empty-font = 3;
            bar-capacity-empty-foreground = "#44ffffff";

            animation-charging-0 = "";          # Animation when charging
            animation-charging-1 = "";
            animation-charging-2 = "";
            animation-charging-3 = "";
            animation-charging-4 = "";
            animation-charging-framerate = 750;
          };
          "module/date" = {                       # Time/Date  Day-Month-Year Hour:Minute
            type = "internal/date";
            #date = "%{A1:notify-send -t 0 \"$(cal -m)\":}  %%{F#999}%d-%m-%Y%%{F-} %%{F#fff}%H:%M%%{F-}%{A}";
            date = "  %%{F#999}%d-%m-%Y%%{F-} %%{F#fff}%H:%M%%{F-}";
          };
          "module/bspwm" = {                      # Workspaces
            type = "internal/bspwm";
            pin-workspace = true;
            #label-monitor = "%name%";

            format = "<label-state> <label-mode>";

            label-focused-foreground = "#fff";
            label-focused-background = "#773f3f3f";
            label-focused-underline = "#c9665e";
            label-focused-font = 4;
            label-focused-padding = 2;

            label-occupied-foreground = "#ddd";
            label-occupied-underline = "#666";
            label-occupied-font = 4;
            label-occupied-padding = 2;

            label-urgent-foreground = "#000000";
            label-urgent-background = "#bd2c40";
            label-urgent-underline = "#9b0a20";
            label-urgent-font = 4;
            label-urgent-padding = 2;

            label-empty = "%icon%";
            label-empty-foreground = "#55";
            label-empty-font = 4;
            label-empty-padding = 2;
          };
          "module/title" = {
            type = "internal/xwindow";
            format = "<label>";
            format-background = "#00000000";
            format-foreground = "#ccffffff";
            label = "%title%";
            label-maxlen = 75;
            label-empty = "";
            label-empty-foreground = "#ccffffff";
          };

          # CUSTOM
          "module/pad" = {
            type = "custom/text";
            content = "    ";
          };
          "module/mic" = {
            type = "custom/script";
            interval = 1;
            tail = "true";
            exec = "~/.config/polybar/script/mic.sh status";
            click-left = "~/.config/polybar/script/mic.sh toggle";
          };
          "module/sink" = {
            type = "custom/script";
            interval = 1;
            tail = "true";
            exec = "~/.config/polybar/script/sink.sh status";
            click-left = "~/.config/polybar/script/sink.sh toggle";
          };
          "module/logo" = {
            type = "custom/menu";
            expand-right = true;

            label-open = " %{F#a7c7e7} ";
            label-close = " %{F#a7c7e7} ";
            label-separator = "|";
            format-spacing = "1";

            menu-0-0 = "";
            menu-0-0-exec = "menu-open-1";
            menu-0-1 = "";
            menu-0-1-exec = "menu-open-2";

            menu-1-0 = "";
            menu-1-0-exec = "sleep 0.5; bspc quit";
            menu-1-1 = "";
            menu-1-1-exec = "sleep 0.5; xset dpms force standby";
            menu-1-2 = "";
            menu-1-2-exec = "sleep 0.5; systemctl suspend";
            menu-1-3 = "";
            menu-1-3-exec = "sleep 0.5; systemctl poweroff";
            menu-1-4 = "";
            menu-1-4-exec = "sleep 0.5; systemctl reboot";

            menu-2-0 = "";
            menu-2-0-exec = "alacritty &";
            menu-2-1 = "";
            menu-2-1-exec = "firefox &";
            menu-2-2 = "";
            menu-2-3 = "";
            menu-2-3-exec = "plexmediaplayer &";
            menu-2-4 = "";
            menu-2-4-exec = "flatpak run com.obsproject.Studio &";
            menu-2-5 = "";
            menu-2-5-exec = "lutris &";
            menu-2-6 = "";
            menu-2-6-exec = "steam &";
          };
          "module/bluetooth" = {
            type = "custom/text";
            content = "";
            click-left = "${pkgs.blueman}/bin/blueman-manager";
          };
        };
      };
    };
    home.file.".config/polybar/script/mic.sh" = {               # Custom script: Mic mute
      text = ''
        #!/bin/sh

        case $1 in
          "status")
            #MUTED=$(pacmd list-sources | awk '/\*/,EOF {print}' | awk '/muted/ {print $2; exit}')
            #if [[ $MUTED = "no" ]]; then
            MUTED=$(awk -F"[][]" '/Left:/ { print $4 }' <(amixer sget Capture))
            if [[ $MUTED = "on" ]]; then
              echo ''
            else
              echo ''
            fi
          ;;
          "toggle")
            #ID=$(pacmd list-sources | grep "*\ index:" | cut -d' ' -f5)
            #pactl set-source-mute $ID toggle
            ${pkgs.alsa-utils}/bin/amixer set Capture toggle
          ;;
        esac
      '';
      executable = true;
    };
    home.file.".config/polybar/script/sink.sh" = {              # Custom script: Toggle speaker/headset
      text = ''
        #!/bin/sh

        ID1=$(awk '/ Built-in Audio Analog Stereo/ {sub(/.$/,"",$2); print $2 }' <(${pkgs.wireplumber}/bin/wpctl status) | head -n 1)
        ID2=$(awk '/ S10 Bluetooth Speaker/ {sub(/.$/,"",$2); print $2 }' <(${pkgs.wireplumber}/bin/wpctl status) | sed -n 2p)

        HEAD=$(awk '/ Built-in Audio Analog Stereo/ { print $2 }' <(${pkgs.wireplumber}/bin/wpctl status | grep "*") | sed -n 2p)
        SPEAK=$(awk '/ S10 Bluetooth Speaker/ { print $2 }' <(${pkgs.wireplumber}/bin/wpctl status | grep "*") | head -n 1)

        case $1 in
          "status")
            if [[ $HEAD = "*" ]]; then
              echo ''
            elif [[ $SPEAK = "*" ]]; then
              echo '蓼'
            fi
          ;;
          "toggle")
            if [[ $HEAD = "*" ]]; then
              ${pkgs.wireplumber}/bin/wpctl set-default $ID2
            elif [[ $SPEAK = "*" ]]; then
              ${pkgs.wireplumber}/bin/wpctl set-default $ID1
            fi
          ;;
        esac
      '';
      executable = true;
    };
  };
}


