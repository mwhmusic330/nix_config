{ flake.modules.nixos.tmux = { ... }: {

  programs.tmux = {
    enable = true;
  };

}; }
