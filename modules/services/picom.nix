#
# Compositor
#

{ config, lib, pkgs, ... }:

{ 
  config = lib.mkIf (config.xsession.enable) {
    services.picom = {
      enable = true;
      package = pkgs.picom.overrideAttrs(o: {
        src = pkgs.fetchFromGitHub {
          repo = "picom";
          owner = "jonaburg";
          rev = "e3c19cd7d1108d114552267f302548c113278d45";
          sha256 = "4voCAYd0fzJHQjJo4x3RoWz5l3JJbRvgIXn1Kg6nz6Y=";
        };
      });

      backend = "glx";
      vSync = true;

      # Shadows
      shadow = false;
      shadowOpacity = 0.75;

      # Fade
      fade = true;
      fadeDelta = 10;

      # Opacity
      opacityRules = [
      #  "100:name = 'Picture in picture'"
      #  "100:name = 'Picture-in-Picture'"
      #  "85:class_i ?= 'rofi'"
        "80:class_i *= 'Alacritty'"
      #  "100:fullscreen"
      ]; # Find with $ xprop | grep "WM_CLASS"

      settings = {
        daemon = true;
        use-damage = false;
        resize-damage = 1;
        refresh-rate = 0;
        #corner-radius = 5;                          # Corners
        #round-borders = 5;

        # Animations
        transition-length = 150;
        transition-pow-x = 0.5;
        transition-pow-y = 0.5;
        transition-pow-w = 0.5;
        transition-pow-h = 0.5;
        size-transition = true;

        # Extras
        detect-rounded-corners = true;
        detect-client-opacity = false;
        detect-transient = true;
        detect-client-leader = false;
        mark-wmwim-focused = true;
        mark-ovredir-focues = true;
        unredir-if-possible = true;
        glx-no-stencil = true;
        glx-no-rebind-pixmap = true;
      };
    };
  };
}
