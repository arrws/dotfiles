# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstableTarball = fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  services.tailscale.enable = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.firewall.checkReversePath = "loose"; # Tailscale wants this

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  console.font = "Lat2-Terminus16";
  console.keyMap = "us";
  i18n = { defaultLocale = "en_US.UTF-8"; };

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs;
      [
        source-code-pro
        # terminus_font
      ];
  };

  # Set your time zone.
  time.timeZone = "Europe/London";
  # time.timeZone = "Asia/Hong_Kong";

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    (pkgs.perlPackages.buildPerlPackage {
      pname = "Audio-FLAC-Header";
      version = "2.4";
      src = pkgs.fetchurl {
        url =
          "mirror://cpan/authors/id/D/DA/DANIEL/Audio-FLAC-Header-2.4.tar.gz";
        sha256 =
          "fba5911d6c22d81506565cd9a1438e8605420ff7986cf03d1a12d006a4070543";
      };
      meta = {
        description = "Interface to FLAC header metadata";
        license = with pkgs.lib.licenses; [ artistic1 gpl1Plus ];
      };
    })

    vim
    neovim

    ### INTERNET
    # google-chrome
    chromium
    firefox
    curl
    wget
    git
    mullvad
    tailscale

    ### TERMINAL
    bash
    zsh
    kitty
    man-pages
    tmux
    htop
    fzf
    delta
    ripgrep
    bat
    sd
    fd
    fdupes
    unzip
    neofetch
    dmenu
    cmatrix
    bc
    transmission
    transmission-gtk
    hledger

    ### FILE MANAGEMENT
    exa
    tree
    vifm
    # nnn
    ncdu
    rsync
    borgbackup

    ### IMAGES
    feh
    imagemagick
    librsvg
    mupdf

    ### AUDIO/VIDEO
    mpv
    ffmpeg
    mpc_cli
    mpd
    cmus
    moc
    ncmpcpp
    exiftool

    ### UTILS
    redshift
    file
    scrot
    xcalib
    xclip
    xorg.xev
    xorg.xmodmap
    xosd
    xprintidle-ng

    ### SYSTEM
    acpid
    rsyslog
    pmutils
    # lm_sensors
    acpi
    powertop
    undervolt
    linuxPackages.cpupower
    linuxPackages.turbostat

    ### PROGRAMMING
    gnumake
    sqlite
    nixfmt

    ### HASKELL
    haskellPackages.xmobar
    haskellPackages.haskell-language-server

    ### C/C++
    gcc

    ### GO
    # go
    # gopls

    ### TYPESCRIPT
    # nodejs
    # nodePackages.typescript
    # nodePackages.typescript-language-server

    ### RUST
    rustc
    cargo
    rust-analyzer

    ### PYTHON
    python310
    python-language-server
    # python310Packages.websockets
    # python310Packages.numpy
    # python310Packages.pandas
    # python310Packages.jupyter
    # python310Packages.tensorflow
    # python310Packages.pytorch
    # python310Packages.Keras
    # python310Packages.scikitlearn
    # python310Packages.matplotlib
    # python310Packages.seaborn
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable SSH
  # services.openssh.enable = true;
  services.sshd.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable VPN
  # services.tailscale.enable = true;
  services.mullvad-vpn.enable = true;

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
  services.acpid.acEventCommands = ''
    export PATH=/run/wrappers/bin:/run/current-system/sw/bin:$PATH
    pm-powersave
  '';

  # Enable sound.
  sound.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  # hardware.brightnessctl.enable = true;

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver vaapiIntel ];
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";
    videoDrivers = [ "modesetting" ];
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
    # windowManager.openbox.enable = true;

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
      "*/10 * * * *    nan   /home/nan/.bin/warn_bat.sh"
      "*/20 * * * *    nan   /home/nan/.bin/warn_eyes.sh"
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nan = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/nan";
    extraGroups =
      [ "wheel" "networkmanager" "video" ]; # Enable ‘sudo’ for the user.
  };

  programs.zsh.enable = true;
  programs.zsh.promptInit = "";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?
}
