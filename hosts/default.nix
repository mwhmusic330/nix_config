{ self, inputs, ... }:
let
  username = "michael";
  hostname = "nixconvert";
  addr = "${username}@${hostname}";
  system = "x86_64-linux";
  systemStateVersion = "24.11";
in {
  flake.nixosConfigurations.${hostname} = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit hostname username; };
    modules = with self.modules.nixos; [
      ./_nixos/hardware-configuration.nix

      base
      openssh
      tmux
      users

      {
        hardware.facter.reportPath = ./facter.json;
        nixpkgs.hostPlatform.system = system;
        system.stateVersion = systemStateVersion;
        boot.loader.grub = {
            enable = true;
            device = "/dev/sda";
            useOSProber = true;
          };
      }

    ];
  };

  flake.homeConfigurations."${addr}"= inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${system};
  
    extraSpecialArgs = {
      inherit username hostname;
      # strip out `self` to avoid infinite recursion
      inputs = builtins.removeAttrs inputs [ "self" ];
    };
  
    modules = with self.modules.homeManager; [
  
      {
        home.username = username;
        home.homeDirectory = "/home/${username}";
      }
  
      base
  
    ];
  };

}
