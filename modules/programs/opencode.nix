{ flake.modules.homeManager.openCode = { ... }: {
  
  programs.opencode = {
    enable = true;
  };
  nixpkgs.config.packageOverrides = pkgs: {
    opencode = pkgs.opencode.overrideAttrs (_: {
      NIX_CFLAGS_COMPILE = "-march=x86-64";
    });
  };
}; }

