{ config, lib, pkgs, user, ... }:

{
  imports =                                   # Home Manager Modules
    (import ../modules/editors) ++
    (import ../modules/programs) ++
    (import ../modules/services) ++
    (import ../modules/shell);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # Terminal
      btop              # Resource Manager
      pfetch            # Minimal fetch
      ranger            # File Manager

      # Video/Audio
      feh               # Image Viewer
      mpv               # Media player
      pavucontrol       # Audio control
      plex-media-player # Media player
      vlc               # Media player
      stremio           # Media streamer
      pamixer           # Audio control
      spotify           # Media player

      # Apps
      appimage-run      # Runs AppImages on NixOS
      firefox           # Browser
      _1password-gui    # Password Manager
      vscode            # Code Editor
      discord           # Social network

      # File Management
      okular            # PDF viewer
      gnome.file-roller # Archive Manager
      pcmanfm           # File Manager
      rsync             # Syncer $ rsync -r dir1/ dir2/
      unzip             # Zip files
      unrar             # Rar files

      # General configuration
      git              # Repositories
      nano             # Text Editor
      wget             # Downloader
      zsh              # Shell
      gnupg            # GPG

      # General home-manager
      alacritty        # Terminal Emulator
      dunst            # Notifications
      libnotify        # Dep for Dunst
      rofi             # Menu
      vim              # Text Editor

      # Xorg configuration
      xclip            # Console Clipboard
      xorg.xev         # Input viewer
      xorg.xkill       # Kill Applications
      xorg.xrandr      # Screen settings

      # Xorg home-manager
      sxhkd            # Shortcuts

      # Desktop
      blueman          # Bluetooth
      simple-scan      # Scanning
      blueman          # Bluetooth
      obs-studio       # Recording/Live Streaming
    ];

    file.".config/wall".source = ../modules/themes/wall;

    #pointerCursor = {
    #  name = "Awaita cursor";
    #  package = pkgs.gnome3.adwaita-icon-theme;
    #  size = 16;
    #};
    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrains Mono Medium";
    };
  };
}
