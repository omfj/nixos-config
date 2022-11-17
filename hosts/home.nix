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
      mpv               # Media Player
      pavucontrol       # Audio control
      plex-media-player # Media Player
      vlc               # Media Player
      stremio           # Media Streamer

      # Apps
      appimage-run      # Runs AppImages on NixOS
      firefox           # Browser
      _1password        # Password Manager
      vscode            # Code Editor

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
      doom emacs       # Text Editor
      libnotify        # Dep for Dunst
      neovim           # Text Editor
      rofi             # Menu
      vim              # Text Editor

      # Xorg configuration
      xclip            # Console Clipboard
      xorg.xev         # Input viewer
      xorg.xkill       # Kill Applications
      xorg.xrandr      # Screen settings

      # Xorg home-manager
      picom            # Compositer
      sxhkd            # Shortcuts

      # Desktop
      blueman          # Bluetooth
      simple-scan      # Scanning
      blueman          # Bluetooth
      obs-studio       # Recording/Live Streaming
    ];
    file.".config/wall".source = ../modules/themes/wall;
    pointerCursor = {                         # This will set cursor systemwide so applications can not choose their own
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 16;
    };
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
      name = "JetBrains Mono Medium";         # or FiraCode Nerd Font Mono Medium
    };                                        # Cursor is declared under home.pointerCursor
  };
}
