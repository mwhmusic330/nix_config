{
  flake.modules.nixos.core = { hostname, ... }: {

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";

    networking.hostName = hostname;

    security.sudo.wheelNeedsPassword = false;


  };
  flake.modules.homeManager.core = { config,hostname,pkgs,username, ... }:
  let
    home_dir = "/home/${username}";
    config_dir = "${home_dir}/.config";
    dotfiles_dir = "${home_dir}/.dotfiles";
    mksl = config.lib.file.mkOutOfStoreSymlink;
  in
  {
    programs = {
      home-manager.enable = true;
      fastfetch.enable = true;
      bash = {
        enable = true;
        enableCompletion = true;
        bashrcExtra = builtins.readFile "${dotfiles_dir}/home/.bashrc"; 
        shellAliases = {
          ghgrab = "nix run github:abhixdd/ghgrab";
          venv = ''if [[ -n $VIRTUAL_ENV_PROMPT ]]; then deactivate; elif [ -d "./.venv" ]; then source ./.venv/bin/activate; elif [ -d "./venv" ]; then source ./venv/bin/activate; else echo "no environment found"; fi'';
          aa = "sessionizer";
          hm = "cd ${home_dir}/nix_config/ && home-manager switch --impure --flake .#${username}@${hostname}";
          rb = "cd ${home_dir}/nix_config/ && sudo nixos-rebuild switch --impure --flake .#${hostname}";
        };
      };
    };
    home.file = {
      ".bash_aliases".source = mksl "${dotfiles_dir}/bash/.bash_aliases";
    };
    home.packages = with pkgs; [
      stylua
      uv
      fzf
      (python313.withPackages(ps: with ps; [
        black
        flask
        flask-socketio
        jupyter
        jupyter-client
        numpy
        plotly
        pynvim
      ]))
    ];

  };
}
