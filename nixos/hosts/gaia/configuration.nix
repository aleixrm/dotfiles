# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include home manager (https://nix-community.github.io/home-manager/index.xhtml#sec-install-nixos-module) 
      <home-manager/nixos>
    ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };
  boot.kernelParams = [ "button.lid_init_state=open" ];

  boot.initrd.luks.devices."luks-5fadc8fd-8be7-4547-acca-857fedc3a0fe".device = "/dev/disk/by-uuid/5fadc8fd-8be7-4547-acca-857fedc3a0fe";
  networking.hostName = "gaia"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Andorra";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ca_AD.UTF-8";
    LC_IDENTIFICATION = "ca_AD.UTF-8";
    LC_MEASUREMENT = "ca_AD.UTF-8";
    LC_MONETARY = "ca_AD.UTF-8";
    LC_NAME = "ca_AD.UTF-8";
    LC_NUMERIC = "ca_AD.UTF-8";
    LC_PAPER = "ca_AD.UTF-8";
    LC_TELEPHONE = "ca_AD.UTF-8";
    LC_TIME = "ca_AD.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "es";
    variant = "cat";
  };

  # Sound
  ## Pipewire
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    #pulse.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Graphics
  services.xserver = {
    displayManager.gdm.enable = true;
    videoDrivers = ["nvidia"];
  };
  hardware.graphics.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  hardware.nvidia = {
    powerManagement.enable = true;
    modesetting.enable = true;
    open = true;
    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:0:0:0";
      intelBusId = "PCI:0:2:0";
    };
  };

  # Configure console keymap
  console.keyMap = "es";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zahori = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "zahori";
    extraGroups = [ "networkmanager" "wheel" "openrazer" "video" ];
    packages = with pkgs; [];
  };

  # Home-manager
  home-manager.users.zahori = { pkgs, ... }: {

    home.packages = with pkgs; [
      bluez
    ];

    services.mpris-proxy = {
      enable = true;
    };
    
    programs.git = {
      enable = true;
      extraConfig = {
        include = {
          path = "${config.users.users.zahori.home}/.config/zahori.gitconfig";
 	};
      };
    };

    programs.kitty = {
      enable = true;
      settings = {
	enable_audio_bell = false;
      };
    };

    services.kanshi = {
      enable = true;
      profiles = {
        portable = {
          outputs = [
            {
              criteria = "eDP-1";
              position = "0,0";
              mode = "1920x1080@60Hz";
              scale = 1.0;
            }
          ];
        };
        all-docked = {
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "HDMI-A-1";
              status = "enable";
              position = "0,0";
              mode = "2560x1440@144Hz";
              scale = 1.25;
            }
            {
              criteria = "DP-3";
              status = "enable";
              position = "-1080,0";
              transform = "90";
            }
          ];
        };
        docked-simple = {
	  outputs = [
	   {
	     criteria = "eDP-1";
	     status = "disable";
 	   }
	   {
	     criteria = "HDMI-A-1";
	     status = "enable";
	     position = "0,0";
	     mode = "2560x1440@144Hz";
	     scale = 1.25;
	   }
 	  ];
	};
      };
    };

    programs.zsh = {
        enable = true;
        oh-my-zsh = {
            enable = true;
            plugins = [ "git" "sudo" ];
            theme = "powerlevel10k";
        };
        plugins = [
          {
            # A prompt will appear the first time to configure it properly
            # make sure to select MesloLGS NF as the font in Konsole
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          }
          {
            name = "powerlevel10k-config";
            src = "${config.users.users.zahori.home}";
            file = ".p10k.zsh";
          }
      ];
    };

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "24.11";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # Openrazer
  hardware.openrazer.enable = true;

  # Enable flatpak
  services.flatpak.enable = true; 

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     vim
     wget
     lshw
     curl
     openrazer-daemon
     polychromatic
     kitty
     waybar
     firefox
     hyprpaper
     mako
     rofi
     wofi
     dolphin
     kanshi
     pavucontrol
     git
     spotify
     zsh-powerlevel10k
  ];

  #Configure Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.waybar.enable = true;

  # Enable zsh system-wide
  programs.zsh.enable = true;

  #Nerd fonts
  fonts.fontDir.enable = true;
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [ 
    (nerdfonts.override { fonts = [ "Meslo" "NerdFontsSymbolsOnly" ]; }) 
    font-awesome
    powerline-fonts
    powerline-symbols
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

  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchDocked = "ignore";
  services.logind.lidSwitchExternalPower = "ignore";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
