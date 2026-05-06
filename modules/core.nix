{
  flake.modules.nixos.core = { hostname, ... }: {

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";

    networking.hostName = hostname;

    security.sudo.wheelNeedsPassword = false;


  };
  flake.modules.homeManager.core = { hostname,pkgs, ... }: {
    programs = {
      home-manager.enable = true;
      fastfetch.enable = true;
      bash.enable = true;
      bash.initExtra = ''
        export PATH="/home/michael/.dotfiles/Scripts:$PATH"
        fastfetch
      '';
      bash.shellAliases = {
        ghgrab = "nix run github:abhixdd/ghgrab";
        aa = "sessionizer";
        };
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
