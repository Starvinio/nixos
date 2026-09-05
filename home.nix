{ config, pkgs, ... }:

{
  home.username = "donbravias";
  home.homeDirectory = "/home/donbravias";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

	home.packages = with pkgs; [
    # cli
    wget
    git
    ripgrep
    fastfetch

    # media
    imv
    mpv
    obs-studio
    localsend

    # working environment
    neovim

    # ai stuff
    chatgpt-cli
    gemini-cli

    # minecraft
    prismlauncher 

    # gnome native
    nautilus      
    gnome-boxes
    dconf-editor

    # desktop applications
    zathura
    zathuraPkgs.zathura_pdf_poppler
    anki

    # programming languages
    rustc
    cargo
    gcc
    python3

    # LSP
    nil
    clang-tools
    lua-language-server
    rust-analyzer
	];

  programs.bash = {
	  enable = true;

	  initExtra = ''
      PS1="\[\033[32m\][\W]\[\033[0m\] \[\033[1m\]λ\[\033[0m\] "
    '';

	  shellAliases = {
      vi = "nvim";
      la = "ls -la";
      ".." = "cd ..";
      rebuild = "sudo nixos-rebuild switch";
      testbuild = "sudo nixos-rebuild test";
	  };
	};

  home.sessionVariables = {
  	EDITOR = "nvim";
  	VISUAL = "nvim";
  };

  programs.git = {
    enable = true;
    settings = { 
      user = {
        name = "Starvinio";
        email = "starvinio@proton.me";
      };
      init.defaultBranch = "main";
    };
  };

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };

  programs.ghostty = { 
    enable = true;
    enableBashIntegration = true;
    settings = {
      # font
      font-family = "Maple Mono Normal";
      font-size = 14.7;
      font-feature = "-calt";

      theme = "Tomorrow Night";
      window-theme = "ghostty";
      background-opacity = 0.9;
      #gtk-titlebar-hide-when-maximized = "true
      gtk-titlebar-style = "tabs";
      maximize = true;

      mouse-hide-while-typing = true;

      keybind = [ 
        "ctrl+shift+h=goto_split:left"
        "ctrl+shift+j=goto_split:down"       
        "ctrl+shift+k=goto_split:up"
        "ctrl+shift+l=goto_split:right"       
      ];
    };
  };

  programs.tmux = {
    enable = true;

    prefix = "C-Space";        # replaces: unbind C-b; set -g prefix C-Space
    baseIndex = 1;              # set -g base-index 1
    keyMode = "vi";             # set-window-option -g mode-keys vi
    mouse = true;                # set -g mouse on
    historyLimit = 10000;        # set -g history-limit 10000
    escapeTime = 0;              # set -sg escape-time 0
    terminal = "\${TERM}";       # set -g default-terminal "${TERM}"
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      isDefault = true;

      settings = {
        # required for userChrome.css to be loaded at all
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      userChrome = ''
        /* Remove tab close button (the x on each tab) */
        .tab-close-button {
          display: none !important;
        }

        /* Remove new tab button (+ at end of tab strip) */
        #tabs-newtab-button {
          display: none !important;
        }

        /* Remove reload button (covers both nav-bar and urlbar placement) */
        #reload-button,
        #urlbar-reload-button {
          display: none !important;
        }

        /* Remove "list all tabs" dropdown arrow */
        #alltabs-button {
          display: none !important;
        }

        /* Remove page back/forward buttons */
        #back-button,
        #forward-button {
          display: none !important;
        }
      '';
    };
  };

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 20;
    gtk.enable = true;
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
      font-name = "Maple Mono 11";
      monospace-font-name = "Maple Mono Normal, 11";
      clock-format = "24h";
      clock-show-weekday = false;
      clock-show-date = false;
      cursor-theme = "Bibata-Modern-Classic";
      cursor-size = 20;
      color-scheme = "prefer-dark";
      show-battery-percentage = true;
      gtk-decoration-layout = ":";
    };

    "org/gnome/desktop/notifications" = {
      show-banners = false;
      show-in-lock-screen = false;
    };


    "org/gnome/desktop/search-providers" = {
      disable-external = true;
    };

    "org/gnome/desktop/session" = { 
      idle-delay = "uint32 480";
    };

    "org/gnome/settings-daemon/plugins/color" = { 
      night-light-enabled = true;
      night-light-temperature = "uint32 2500";
    };
  };
}


