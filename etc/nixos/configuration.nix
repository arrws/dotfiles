# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  console.font = "Lat2-Terminus16";
  console.keyMap = "us";
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };


   fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      source-code-pro
      # terminus_font
    ];
  };


  # Set your time zone.
  time.timeZone = "Europe/London";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    file
    fzf
    ripgrep
    curl
    vim
    vifm
    #nnn
    #neovim
    neovim-nightly
    ncdu
    neofetch
    dmenu
    git
    unzip
    #google-chrome
    chromium
    firefox
    #rxvt_unicode
    bash
    zsh
    htop
    rsync
    feh
    mpv
    mpd
    mpc_cli
    mupdf
    tmux
    xosd
    xclip
    #lm_sensors
    acpi
    powertop
    undervolt
    ncmpcpp
    imagemagick
    #scrot
    sc-im
    hledger
    xorg.xev
    xcalib
    kitty
    acpid
    tree
    rsyslog
    pmutils
    gnome3.librsvg
    cmatrix
    sqlite
    borgbackup
    patdiff
    redshift
    exa
    cmus
    moc
    ncmpcpp

    linuxPackages.cpupower
    linuxPackages.turbostat

    gcc
    go
    gopls

    nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.json
    #nodePackages.npm
 
    haskellPackages.xmobar
    haskellPackages.haskell-language-server

    (haskellPackages.ghcWithPackages (self: [
      self.random
      self.Glob
    ]))

    rustc
    cargo

    gnumake
    python3
    python38Packages.python-language-server
    python38Packages.numpy
    python38Packages.pandas
    python38Packages.matplotlib
    #python38Packages.jupyter
    #python38Packages.tensorflow
    #python38Packages.pytorch
    #python38Packages.Keras
    #python38Packages.scikitlearn
    #python38Packages.seaborn
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  programs.adb.enable = true;
  programs.light.enable = true;
  
  environment.etc = {
    "pm/power.d/80undervolt" = {
      text = ''
case "$1" in
true) # powersaving on
	cpupower frequency-set -u 2100MHz
	undervolt --core -90 --cache -90
	;;
false) # powersaving off
	cpupower frequency-set -u 3400MHz
	undervolt --core -90 --cache -90
	;;
*)
	exit 254
	;;
esac

exit 0
      '';
      mode = "0755";
    };
  };

  services.acpid.enable = true;
  # services.acpid.lidEventCommands = ''
  #   export USER=nan
  #   export XAUTHORITY=/home/nan/.Xauthority
  #   export PATH=/run/current-system/sw/bin/
  #   export DISPLAY=':0'
  #   LID_STATE=$(awk '{ print $2 }' /proc/acpi/button/lid/LID/state)
  #   if [ $LID_STATE = 'closed' ]; then
  #       slimlock 2>> /tmp/slimlock.log
  #   fi
  # '';
  services.acpid.acEventCommands = ''
    export PATH=/run/wrappers/bin:/run/current-system/sw/bin:$PATH
    pm-powersave
  '';

  services.sshd.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  # hardware.brightnessctl.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";

    videoDrivers = ["modesetting"];
    useGlamor = true;
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
    # windowManager.xmonad.extraPackages = self: [self.xmonadContrib ];

    # deviceSection = ''
    #	Option "TearFree" "true"
    #'';
    
    displayManager = {
	autoLogin.enable = true;
	autoLogin.user = "nan";
        sessionCommands = ''
            # xscreensaver -no-splash &
            setxkbmap -option ctrl:nocaps us
	    feh --bg-fill ~/.skynet.png
            '';
    };
    autorun = true;

    # synaptics.enable = true;
    libinput.enable = true;
    };

	services.cron = {
		enable = true;
		systemCronJobs = [
			"*/10 * * * *    nan   /home/nan/.scripts/warn_bat.sh"
			 # "*/5 * * * *      root    date >> /tmp/cron.log"
		];
	};

  # visual compositor
  # services.compton.enable = false; # change that
  # services.compton.fade = false;
  # services.compton.shadow = false;
  # # services.compton.inactiveOpacity = "0.8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nan = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/nan";
    extraGroups = [ "wheel" "networkmanager" "video" ]; # Enable ‘sudo’ for the user.
  };

  programs.zsh.enable = true;
  programs.zsh.promptInit = "";
  # users.extraUsers.USER = {
  #   shell = pkgs.zsh;
  # };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?
}


