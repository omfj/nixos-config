{ pkgs, ... }:

{
  imports =
    [
      ../../modules/desktop/bspwm/home.nix
    ];

  home = {
    packages = with pkgs; [
      light
      auto-cpufreq
      tlp
    ];
  };

  programs = {
    alacritty.settings.font.size = 10;
  };

  services = {
    blueman-applet.enable = true;
  };
}
