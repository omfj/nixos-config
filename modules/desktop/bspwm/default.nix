#
#  Bspwm configuration
#

{ config, lib, pkgs, ... }:

{
  programs.dconf.enable = true;

  services = {
    xserver = {
      enable = true;

      layout = "no";
      libinput.enable = true;

      displayManager = {
        lightdm = {
          enable = true;
          greeters = {
            gtk = {
              enable = true;
              cursorTheme = {
                package = pkgs.gnome.adwaita-icon-theme;
                name = "Adwaita";
                size = 24;
              };
            };
          };
        };
        defaultSession = "none+bspwm";
      };
      windowManager= {
        bspwm = {
          enable = true;
        };
      };

      videoDrivers = [
        "intel"
      ];

      serverFlagsSection = ''
        Option "BlankTime" "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
      ''; # Caffinate

    };
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    xclip
    xorg.xev
    xorg.xkill
    xorg.xrandr
    xterm
    alacritty
    sxhkd
  ];

  xdg.portal = {                                  # Required for flatpak with windowmanagers
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
