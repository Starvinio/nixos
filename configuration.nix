# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

	home-manager.useGlobalPkgs = true;
	home-manager.useUserPackages = true;
	home-manager.users.donbravias = import ./home.nix;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "zenbook"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  
  # Stop charging at 80% and use AC only instead
  systemd.tmpfiles.rules = [
    "w /sys/class/power_supply/BAT0/charge_control_end_threshold - - - - 80"
  ];

  virtualisation.libvirtd.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."donbravias" = {
    isNormalUser = true;
    description = "Don Bravias";
    extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # NOTE: Experimental Port Allowances
  networking.firewall.allowedTCPPorts = [ 
    25565 # Lan MC 
    53317 # Localsend
  ];
	
  services.pipewire = {
  	enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };


  services.keyd = {
  	enable=true;

    keyboards.default = {
      ids = [ "*" ];

      # Swap escape and capslock
      settings.main = {
        capslock = "esc";
        esc = "capslock";
      };
    };
  };


	services.displayManager.gdm.enable = true;
	services.desktopManager.gnome.enable = true;

	services.gnome.core-apps.enable = false;
	services.gnome.core-developer-tools.enable = false;
	services.gnome.games.enable = false;

	environment.gnome.excludePackages = with pkgs; [
		gnome-tour
		gnome-user-docs
	];

  environment.sessionVariables = {
    GDK_BACKEND = "wayland";
    GTK_CSD = "1";
  };

	services.printing.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  	# system 
    killall
  ];

  fonts.packages = with pkgs; [
		jetbrains-mono
		maple-mono.truetype
		maple-mono.Normal-TTF
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
