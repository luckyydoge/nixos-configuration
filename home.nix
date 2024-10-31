{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "zjw";
  home.homeDirectory = "/home/zjw";

  home.sessionVariables = {
    # WAYLAND_DISPLAY = "wayland-0";
    DISPLAY = "192.168.150.1:0";
    #    XDG_SESSION_TYPE = "wayland";
  };

  home.packages = with pkgs; [
    vim
    git
    wget
    curl
    alacritty
    tree
    neovim
    vscode
    nixd
    alejandra
    home-manager
    neofetch
    htop
    btop
    fastfetch
    cmatrix
    swww
    firefox
  ];

  programs = {
    git = {
      enable = true;
      userName = "zjw";
      userEmail = "zjw000107@gmail.com";
    };

    kitty = {
      enable = true;
      settings = {
        # linux_display_server = "x11";
        confirm_os_window_close = 0;
        dynamic_background_opacity = true;
        enable_audio_bell = false;
        mouse_hide_wait = "-1.0";
        window_padding_width = 10;
        background_opacity = "0.5";
        background_blur = 5;
      };
    };
  };

  wayland.windowManager = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;

      settings = {
        monitor = [
          "Virtual-1, 1920x1080@60, 0x0, 1"
        ];
        "$mod" = "SUPER";
        "$term" = "kitty";
        dwindle = {
            # pseudotile = true;
            # preserve_split = true;
            # no_gaps_when_only = 0;
            smart_split = false;
            # smart_resizing = false;
          };
        bind =
          [
            "$mod, F, exec, firefox"
            ", Print, exec, grimblast copy area"
            "$mod, return, exec, $term"
            "$mod, M, exit"
            "$mod, C, exec, code"
            "$mod, A, exec, alacritty"
            "$mod, q, killactive"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (builtins.genList (
                i: let
                  ws = i + 1;
                in [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              )
              9)
          );
      };
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
