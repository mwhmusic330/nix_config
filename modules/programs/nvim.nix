{ flake.modules.homeManager.nvim = { ... }: {

  programs.neovim = {
  	enable = true;
    	initLua = builtins.readFile "/home/michael/.dotfiles/home/.config/nvim/init.lua";
  };

}; }
