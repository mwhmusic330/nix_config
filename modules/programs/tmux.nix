{ flake.modules.homeManager.tmux = { ... }: {

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile "/home/michael/.dotfiles/home/.tmux.conf";
  };

};
}
