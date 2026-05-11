{ flake.modules.homeManager.git = { ... }: {

  programs.git = {
    enable = true;
    settings = {
      alias = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };
      user = {
        name = "michael";
	email = "149101891+mwhmusic330@users.noreply.github.com";
      };
      push = { autoSetupRemote = true; };
      init.defaultBranch = "main";
    };
  };

}; }
