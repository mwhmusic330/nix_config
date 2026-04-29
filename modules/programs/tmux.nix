{ flake.modules.nixos.tmux = { ... }: {

  programs.tmux = {
    enable = true;
    # extraConfig = builtins.readFile "/home/michael/.dotfiles/.tmux.conf";
  };

};
}
