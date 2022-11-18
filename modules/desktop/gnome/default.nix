{ config, lib, pkgs, ... }:

{
  programs.dconf.enable = true;

  services = {
    xserver = {
      enable = true;

      layout = "no";                              # Keyboard layout & €-sign
      libinput.enable = true;

      displayManager = {                          # Display Manager
        gdm = {
          enable = true;
        };
      };
      desktopManager= {
        gnome = {                                 # Window Manager
          enable = true;
        };
      };
    };
    udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
    ];
  };

  programs.zsh.enable = true;

  hardware.pulseaudio.enable = false;

  environment = {
    systemPackages = with pkgs; [       # Packages installed
      gnome.adwaita-icon-theme
      gnomeExtensions.appindicator
      gnomeExtensions.pop-shell
    ];
    gnome.excludePackages = (with pkgs; [
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      gedit
      epiphany
      geary
      evince
      tali
      iagno
      hitori
      atomix
    ]);
  };
}
