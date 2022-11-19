{ config, lib, pkgs, inputs, user, location, ... }:

{
  users.users.${user} = {                   # System User
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" "kvm" "libvirtd" "plex" ];
    shell = pkgs.zsh;                       # Default shell
  };

  security = {
    sudo.wheelNeedsPassword = true;
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.gdm.enableGnomeKeyring = true;
  };

  networking.networkmanager.enable = true;

  # Time zone and internationalisation
  time.timeZone = "Europe/Oslo";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "nb_NO.UTF-8";
      LC_MONETARY = "nb_NO.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "no";
  };

  sound = {                                 # ALSA sound enable
    enable = true;
    mediaKeys = {                           # Keyboard Media Keys (for minimal desktop)
      enable = true;
    };
  };

  fonts.fonts = with pkgs; [                # Fonts
    carlito                                 # NixOS
    vegur                                   # NixOS
    source-code-pro
    font-awesome                            # Icons
    corefonts                               # MS
    (nerdfonts.override {                   # Only selected nerd fonts
      fonts = [
        "FiraCode"
        "JetBrainsMono"
        "Hack"
        "IBMPlexMono"
      ];
    })
  ];

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    systemPackages = with pkgs; [
      vim
      git
      killall
      nano
      pciutils
      usbutils
      wget
    ];
    etc = {
      "xdg/user-dirs.defaults" = {
        text = ''
          DESKTOP=Desktop
          DOCUMENTS=Documents
          DOWNLOAD=Downloads
          MUSIC=Music
          PICTURES=Pictures
          PUBLICSHARE=Public
          TEMPLATES=Templates
          VIDEOS=Videos
        '';
      };

      "xdg/mimeapps.list" = {
        text = ''
          [Default Applications]
          x-scheme-handler/http=firefox.desktop
          x-scheme-handler/https=firefox.desktop
        '';
      };
    };
  };

  # GnuPG
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "curses";
  };
  services.pcscd.enable = true;

  # Keychain
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  services = {
    # File management
    gvfs.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
    # Audio
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    # OpenSSH
    openssh = {
      enable = true;
      allowSFTP = true;
      extraConfig = ''
        HostKeyAlgorithms +ssh-rsa
      '';
    };
    flatpak.enable = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {                                  # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;    # Enable nixFlakes on system
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  nixpkgs.config.allowUnfree = true;        # Allow proprietary software.

  system = {                                # NixOS settings
    autoUpgrade = {                         # Allow auto update (not useful in flakes)
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.05";
  };
}

