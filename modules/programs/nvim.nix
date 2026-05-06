{ flake.modules.homeManager.nvim = { ... }: {

  programs.neovim = {
  	enable = true;
    	extraLuaConfig = builtins.readFile "/home/michael/.dotfiles/home/.config/nvim/init.lua";
  };

}; }
