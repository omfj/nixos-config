{
  description = "NixOS configuration by omfj";

  inputs =                                                                  # All flake references used to build my NixOS setup. These are dependencies.
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";                  # Nix Packages

      home-manager = {                                                      # User Package Management
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nur = {
        url = "github:nix-community/NUR";                                   # NUR Packages
      };

      emacs-overlay = {                                                     # Emacs Overlays
        url = "github:nix-community/emacs-overlay";
        flake = false;
      };

      doom-emacs = {                                                        # Nix-community Doom Emacs
         url = "github:nix-community/nix-doom-emacs";
         inputs.nixpkgs.follows = "nixpkgs";
         inputs.emacs-overlay.follows = "emacs-overlay";
      };
    };

  outputs = inputs @ { self, nixpkgs, home-manager, nur, doom-emacs, ... }:
    let
      user = "omfj";
      location = "$HOME/.setup";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user location doom-emacs;
        }
      );
    };
}
