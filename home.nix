{ pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ngoclongnguyen";
  home.homeDirectory = "/Users/ngoclongnguyen";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    tig
    nodejs_24
  ];

  programs.fish = {
    enable = true;

    shellAliases = {
      ".." = "cd ..";
      "cd.." = "cd ..";
      ll = "ls -la";
      gti = "git";
    };

    functions.sudo = ''
      if test "$argv" = !!
        eval command sudo $history[1]
      else
        command sudo $argv
      end
    '';

    interactiveShellInit = ''
      starship init fish | source
    '';
  };

  programs.starship = {
    enable = true;
  };

  xdg.configFile."ghostty/config".text = ''
    theme = dark:Ayu,light:Ayu Light

    font-thicken = true

    window-padding-balance = true
    window-padding-x = 10
    window-padding-y = 10
  '';

  xdg.configFile."starship.toml".text = ''
    "$schema" = 'https://starship.rs/config-schema.json'

    format = """
    [](color_red)\
    $os\
    $username\
    [](bg:color_yellow fg:color_red)\
    $time\
    [](bg:color_green fg:color_yellow)\
    $directory\
    [](bg:color_blue fg:color_green)\
    $git_branch\
    $git_status\
    [ ](fg:color_blue)\
    $line_break$character"""

    palette = 'dynamic'

    [palettes.dynamic]
    color_fg0     = "black"
    color_bg1     = "black"
    color_blue    = "blue"
    color_green   = "green"
    color_magenta = "magenta"
    color_red     = "red"
    color_yellow  = "yellow"

    [os]
    disabled = false
    style = "bg:color_red fg:color_fg0"

    [os.symbols]
    Windows = "󰍲"
    Ubuntu = "󰕈"
    SUSE = ""
    Raspbian = "󰐿"
    Mint = "󰣭"
    Macos = "󰀵"
    Manjaro = ""
    Linux = "󰌽"
    Gentoo = "󰣨"
    Fedora = "󰣛"
    Alpine = ""
    Amazon = ""
    Android = ""
    AOSC = ""
    Arch = "󰣇"
    Artix = "󰣇"
    EndeavourOS = ""
    CentOS = ""
    Debian = "󰣚"
    Redhat = "󱄛"
    RedHatEnterprise = "󱄛"
    Pop = ""

    [username]
    show_always = true
    style_user = "bg:color_red fg:color_fg0"
    style_root = "bg:color_red fg:color_fg0"
    format = '[ $user ]($style)'

    [directory]
    style = "bg:color_green fg:color_fg0"
    format = "[ $path ]($style)"
    truncation_length = 3
    truncation_symbol = "…/"

    [directory.substitutions]
    "Documents" = "󰈙 "
    "Downloads" = " "
    "Music" = "󰝚 "
    "Pictures" = " "
    "Developer" = "󰲋 "

    [git_branch]
    symbol = ""
    style = "bg:color_blue"
    format = '[[ $symbol $branch ](fg:color_fg0 bg:color_blue)]($style)'

    [git_status]
    style = "bg:color_blue"
    format = '[[($all_status$ahead_behind )](fg:color_fg0 bg:color_blue)]($style)'

    [time]
    disabled = false
    time_format = "%R"
    style = "fg:color_fg0 bg:color_yellow"
    format = '[[  $time ](fg:color_fg0 bg:color_yellow)]($style)'

    [line_break]
    disabled = false

    [character]
    disabled = false
    success_symbol = '[](bold fg:color_green)'
    error_symbol = '[](bold fg:color_red)'
    vimcmd_symbol = '[](bold fg:color_green)'
    vimcmd_replace_one_symbol = '[](bold fg:color_magenta)'
    vimcmd_replace_symbol = '[](bold fg:color_magenta)'
    vimcmd_visual_symbol = '[](bold fg:color_yellow)'
  '';

  programs.vim = {
    enable = true;

    extraConfig = ''
      syntax on
      set number
      set relativenumber
      set tabstop=2
      set shiftwidth=2
      set expandtab
      set cursorline

      function JKescape(key) abort
        if a:key ==# 'j'
          let b:esc_j_lasttime = reltimefloat(reltime())
          return a:key
        endif

        let l:timediff = reltimefloat(reltime()) - get(b:, 'esc_j_lasttime')
        let b:esc_j_lasttime = 0.0
        return l:timediff <= 0.1 && l:timediff > 0.001 ? "\b\e" : a:key
      endfunction

      inoremap <expr> j JKescape('j')
      inoremap <expr> k JKescape('k')
    '';
  };

  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
    ];

    userSettings = {
      ui_font_size = 16;
      buffer_font_size = 15;

      icon_theme = {
        mode = "system";
        light = "Zed (Default)";
        dark = "Zed (Default)";
      };
      theme = {
        mode = "system";
        light = "Ayu Light";
        dark = "Ayu Dark";
      };

      tabs = {
        file_icons = true;
        git_status = true;
      };
      title_bar = {
        show_sign_in = false;
        show_branch_icon = false;
      };

      autosave = "on_focus_change";
      base_keymap = "VSCode";

      vim = {
        use_smartcase_find = true;
        toggle_relative_line_numbers = true;
      };
      vim_mode = true;

      git = {
        inline_blame = {
          delay_ms = 1000;
        };
      };

      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
      };

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      agent = {
        default_model = {
          provider = "copilot_chat";
          model = "gpt-5-mini";
        };
        favorite_models = [ ];
        model_parameters = [ ];
      };
      features = {
        edit_prediction_provider = "copilot";
      };
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "nlongn22";
        email = "rebuke09puppies@icloud.com";
      };
      core = {
        editor = "vim";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.firefox = {
    enable = true;
  };
}
