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
      ttyper            # Typing game

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
      zip               # Zip files
      unzip
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
      betterlockscreen # Lockscreen
      mullvad-vpn      # VPN

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

      # Rust
      rustc            # Rust compiler
      cargo            # Rust package manager

      # Node/webdev
      yarn             # npm alernative
      nodejs           # node js
      nodePackages.npm # Node package manager

      # Haskell
      ghc              # Haskell compiler
      stack            # Package manager ++(?)
      cabal-install    # --||--

      # Java
      jdk              # Java devkit

      # TODO: Python 

      # Tex
      texlive.combined.scheme-medium # Latex baby
    ];

    file.".config/wall".source = ../modules/themes/wall;

    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
      size = 24;
    };
  };
}
