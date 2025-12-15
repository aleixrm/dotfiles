{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "zahori";
  home.homeDirectory = "/home/zahori";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.htop
    pkgs.spotify
    pkgs.nerd-fonts.meslo-lg
    pkgs.podman # requires install system-wide "uidmap" package
    pkgs.podman-tui
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/zahori/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "vim";
    PATH = "$PATH:$HOME/.local/kitty.app/bin/";

  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
  };

  programs.vim.enable = true;

  programs.tmux = {
    enable = true;

    # Change prefix to Ctrl+a and unbind C-b
    prefix = "C-a";
    escapeTime = 200;
    baseIndex = 1;
    mouse = true;
    terminal = "tmux-256color";
    keyMode = "vi";

    # Plugins
    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
    ];

    extraConfig = ''
      # Send Ctrl+a to applications inside tmux pressing it twice
      bind C-a send-prefix

      # Force reload of config file
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "~/.config/tmux/tmux.conf reloaded."

      # hjkl pane traversal
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Enables focus-events
      set-option -g focus-events on

      # Enable true colors
      set-option -ag terminal-overrides ',xterm-256color:RGB'

      # copy to clipboard
      set-option -s set-clipboard off
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip -selection clipboard -i"

      # List of plugins
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      # tmux-resurrect plugin
      set -g @plugin 'tmux-plugins/tmux-resurrect'

      # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
      run '~/.tmux/plugins/tpm/tpm'
    '';
  };

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
	      dracula-theme.theme-dracula
	      vscodevim.vim
	      yzhang.markdown-all-in-one
              bbenoist.nix
              ms-vscode-remote.remote-containers
      ];
      userSettings = {
        "editor.fontFamily" = "MesloLGS Nerd Font Mono";
        # Optional: adjust size or ligatures as you wish
        "editor.fontSize" = 14;
        "editor.fontLigatures" = true;
        "terminal.integrated.customGlyphs" = false;
        "dev.containers.dockerPath" = "podman";
        "terminal.integrated.profiles.linux.bash.path" = "/usr/bin/bash";
      };
    };
  };

  programs.kitty = {
    enable = true;

    font = {
      name = "MesloLGS Nerd Font Mono";
      # The following are kitty defaults and can be omitted,
      # but shown here for clarity if you want to be explicit:
      # bold = "auto";
      # italic = "auto";
      # boldItalic = "auto";
    };
    settings = {
      enable_audio_bell = "no";
      copy_on_select = "yes";
    };
    extraConfig = ''
      symbol_map U+e000-U+e00a,U+ea60-U+ebeb,U+e0a0-U+e0c8,U+e0ca,U+e0cc-U+e0d7,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b7,U+e700-U+e8ef,U+ed00-U+efc1,U+f000-U+f2ff,U+f000-U+f2e0,U+f300-U+f381,U+f400-U+f533,U+f0001-U+f1af0 Symbols Nerd Font Mono
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ./gruvbox-rainbow.toml);
  };
}
