{ config, pkgs, ... }:

{
  home.username = "donbravias";
  home.homeDirectory = "/home/donbravias";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.bash = {
	  enable = true;

	  initExtra = ''
      
      PS1="\n\[\033[32m\]\w\n\[\033[0m\]\$ " 
    '';

	  shellAliases = {
      vi = "nvim";
      la = "ls -la";
      rebuild = "sudo nixos-rebuild switch";
	  };
	};

	home.packages = with pkgs; [
	];

  home.sessionVariables = {
  	EDITOR = "nvim";
  	VISUAL = "nvim";
  };

  dconf.settings = {
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 4;
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell" = {
      favorite-apps = [
        "com.mitchellh.ghostty.desktop"
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "org.pwmt.zathura.desktop"
      ];
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = [ "<Super>u" ];
      switch-to-workspace-2 = [ "<Super>i" ];
      switch-to-workspace-3 = [ "<Super>o" ];
      switch-to-workspace-4 = [ "<Super>p" ];

      move-to-workspace-1 = [ "<Shift><Super>u" ];
      move-to-workspace-2 = [ "<Shift><Super>i" ];
      move-to-workspace-3 = [ "<Shift><Super>o" ];
      move-to-workspace-4 = [ "<Shift><Super>p" ];

      close = [ "<Shift><Super>q" ];
      toggle-fullscreen = [ "<Shift><Super>f" ];
      toggle-maximized = [ "<Super>f" ];
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/desktop/interface" = {
      clock-format = "24h";
      clock-show-date = false;
    };

    "org/gnome/desktop/interface" = {
        cursor-theme = "Bibata-Modern-Classic";
        cursor-size = 24;
    };
  };

}


