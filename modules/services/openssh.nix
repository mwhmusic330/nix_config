{ flake.modules.nixos.openssh = { ... }: {

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      MaxAuthTries = 2;
    };
  };

}; }
