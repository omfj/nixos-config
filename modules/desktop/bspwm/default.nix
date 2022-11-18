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
        gdm = {
          enable = true;
          #background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
          #greeters = {
          #  gtk = {
          #    cursorTheme = {
          #      name = "Adwaita cursor";
          #      package = pkgs.gnome3.adwaita-icon-theme;
          #      size = 16;
          #    };
          #  };
          #};
        };
        defaultSession = "none+bspwm";
      };
      windowManager= {
        bspwm = {                                 # Window Manager
          enable = true;
        };
      };

      videoDrivers = [                            # Video Settings
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
