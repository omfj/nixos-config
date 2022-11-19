#
# System notifications
#

{ config, lib, pkgs, ... }:

let
  colors = import ../themes/colors.nix;                 # Import colors theme
in
{
  home.packages = [ pkgs.libnotify ];                   # Dependency
  services.dunst = {
    enable = true;
    iconTheme = {                                       # Icons
      name = "Papirus Dark";
      package = pkgs.papirus-icon-theme;
      size = "16x16";
    };
    settings = {               # Settings
      global = {
        monitor = 0;
        width = 300;
        height = 250;
        origin = "top-right";
        offset = "35x75";
        scale = 0;
        notification_lmit = 5;
        shrink = "yes";
        padding = 15;
        horizontal_padding = 15;
        frame_width = 3;
        separator_color = "frame";
        font = "FiraCode Nerd Font 13";
        line_height = 4;
        idle_threshold = 120;
        markup = "full";
        format = ''<b>%s</b>\n%b'';
        alignment = "left";
        vertical_alignment = "center";
        icon_position = "left";
        word_wrap = "yes";
        ignore_newline = "no";
        show_indicators = "yes";
        sort = true;
        stack_duplicates = true;
        hide_duplicate_count = true;
        frame_color = "#817F7F";
      };
      urgency_low = {
        background = "#1A1A1A";
        foreground = "#F9F9F9";
        timeout = 5;
      };
      urgency_normal = {
        background = "#1A1A1A";
        foreground = "#F9F9F9";
        timeout = 4;
      };
      urgency_critical = {
        background = "#900000";
        foreground = "#FFFFFF";
        frame_color = "#FF0000";
        timeout = 10;
      };
    };
  };
  xdg.dataFile."dbus-1/services/org.knopwob.dunst.service".source = "${pkgs.dunst}/share/dbus-1/services/org.knopwob.dunst.service";
}
