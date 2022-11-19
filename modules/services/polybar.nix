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

            separator = "|";
            separator-foreground = "#666";

            font-0 = "JetBrainsMonoNerdFont:size=13;2";
            font-1 = "JetBrainsMonoNerdFont:size=7;2";
            font-2 = "JetBrainsMonoNerdFont:size=9;2";

            modules-left = "bspwm title";
            modules-right = "backlight volume memory cpu battery date";

            tray-position = "right";
            tray-detached = "false";

            wm-restack = "bspwm";
          };
          "module/memory" = {
            type = "internal/memory";
            format = "<label>";
            format-foreground = "#999";
            label = "MEM:  %percentage_used%%";
          };
          "module/cpu" = {
            type = "internal/cpu";
            interval = 1;
            format = "<label>";
            format-foreground = "#999";
            label = "CPU:  %percentage%%";
          };
          "module/volume" = {
            type = "internal/pulseaudio";

            format-volume = "VOL: <label-volume>";
            #format-volume = "<label-volume> <bar-volume>";
            label-volume = "%percentage%%";
            label-volume-foreground = "#eee";
            
            label-muted = "MUTED";
            label-muted-foreground = "#666";
            
            bar-volume-width = 10;
            bar-volume-foreground-0 = "#55aa55";
            bar-volume-foreground-1 = "#55aa55";
            bar-volume-foreground-2 = "#55aa55";
            bar-volume-foreground-3 = "#55aa55";
            bar-volume-foreground-4 = "#55aa55";
            bar-volume-foreground-5 = "#f5a70a";
            bar-volume-foreground-6 = "#ff5555";
            bar-volume-gradient = false;
            bar-volume-indicator = "|";
            bar-volume-indicator-font = 2;
            bar-volume-fill = "─";
            bar-volume-fill-font = 2;
            bar-volume-empty = "─";
            bar-volume-empty-font = 2;
            bar-volume-empty-foreground = "#FF00FF";
          };
          "module/backlight" = {
            type = "internal/backlight";
            card = "intel_backlight";

            use-actual-brightness = true;
            format = "<label>";
            label = "BL: %percentage%%";
            format-underline = "#eee";
          };
          "module/battery" = {
            type = "internal/battery";
            full-at = 98;

            format-charging = "BAT: <label-charging>";
            format-discharging = "BAT: <label-discharging>";
            format-full = "BAT: <label-full>";

            ramp-capacity-0-foreground = "#f53c3c";
            ramp-capacity-1-foreground = "#ffa900";

            bar-capacity-width = 10;
            bar-capacity-format = "%{+u}%{+o}%fill%%empty%%{-u}%{-o}";
            bar-capacity-fill = "█";
            bar-capacity-fill-foreground = "#ddffffff";
            bar-capacity-fill-font = 2;
            bar-capacity-empty = "█";
            bar-capacity-empty-font = 2;
            bar-capacity-empty-foreground = "#44ffffff";
          };
          "module/date" = {
            type = "internal/date";
            date = "%%{F#999}%d-%m-%Y%%{F-} %%{F#fff}%H:%M%%{F-}";
          };
          "module/bspwm" = {
            type = "internal/bspwm";
            format = "<label-state>"; # TODO: Fix whitespace hack

            label-focused = "   ";
            label-focused-background = "#DF717171";

            label-occupied = "   ";

            label-urgent = "   ";
            label-urgent-background = "#8B0000";

            label-empty = "   ";
            label-empty-foreground = "#555";

          };
          "module/title" = {
            type = "internal/xwindow";
            format = "<label>";
            format-foreground = "#eee";
            label = "%title%";
            label-maxlen = 40;
            label-empty = "";
          };

        };
      };
    };
    home.file.".config/polybar/script/example.sh" = {
      text = ''
        #!/bin/sh
        # Example script
      '';
      executable = true;
    };
  };
}


