{
  description = "MacBook Pro 14 nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      home-manager,
      nixpkgs,
      nix-homebrew,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            pkgs.nixd
            pkgs.nixfmt
          ];

          homebrew = {
            enable = true;
            brews = [
              "mas"
            ];
            casks = [
              "ghostty"
            ];
            masApps = {
              "wBlock" = 6746388723;
            };
            onActivation.cleanup = "zap";
            onActivation.autoUpdate = true;
            onActivation.upgrade = true;
          };

          system.defaults = {
            dock.autohide = true;
            dock.persistent-apps = [
              "/System/Applications/FaceTime.app"
              "/System/Applications/Messages.app"
              "/System/Applications/Weather.app"
              "/System/Applications/Maps.app"
              "/System/Applications/Music.app"
              "/System/Applications/Mail.app"
              "/Applications/Safari.app"
            ];
            dock.show-recents = false;
            dock.mru-spaces = false;
            trackpad.TrackpadThreeFingerDrag = true;
            trackpad.TrackpadThreeFingerHorizSwipeGesture = 0;
            trackpad.TrackpadFourFingerHorizSwipeGesture = 2;
            WindowManager.StandardHideWidgets = true;
            WindowManager.StageManagerHideWidgets = true;
            hitoolbox.AppleFnUsageType = "Show Emoji & Symbols";
            finder.NewWindowTarget = "Home";
            NSGlobalDomain.ApplePressAndHoldEnabled = false;
            NSGlobalDomain.KeyRepeat = 6;
            NSGlobalDomain.InitialKeyRepeat = 25;
            NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
            NSGlobalDomain.NSAutomaticInlinePredictionEnabled = false;
            NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
            NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
            NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
            NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
          };

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          programs.fish.enable = true;
          environment.shells = [ pkgs.fish ];

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          system.primaryUser = "ngoclongnguyen";

          users.users.ngoclongnguyen = {
            home = "/Users/ngoclongnguyen";
          };

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#mbp
      darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ngoclongnguyen = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = "ngoclongnguyen";
            };
          }
        ];
      };
    };
}
