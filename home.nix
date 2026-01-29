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

  xdg.configFile."fish/config.fish".text = ''
    alias .. "cd .."
    alias cd.. "cd .."
    alias ll "ls -la"
    alias gti git

    function sudo
      if test "$argv" = !!
        eval command sudo $history[1]
      else
        command sudo $argv
      end
    end

    starship init fish | source
  '';

  xdg.configFile."ghostty/config".text = ''
    theme = dark:Gruvbox Dark Hard,light:Gruvbox Light Hard

    font-thicken = true

    window-padding-balance = true
    window-padding-x = 10
    window-padding-y = 10
  '';

  programs.starship = {
    enable = true;
  };

  xdg.configFile."starship.toml".text = ''
    "$schema" = 'https://starship.rs/config-schema.json'

    format = """
    [](color_orange)\
    $os\
    $username\
    [](bg:color_yellow fg:color_orange)\
    $directory\
    [](fg:color_yellow bg:color_aqua)\
    $git_branch\
    $git_status\
    [](fg:color_aqua bg:color_blue)\
    $c\
    $cpp\
    $rust\
    $golang\
    $nodejs\
    $php\
    $java\
    $kotlin\
    $haskell\
    $python\
    [](fg:color_blue bg:color_bg3)\
    $nix_shell\
    [](fg:color_bg3 bg:color_bg1)\
    $time\
    [ ](fg:color_bg1)\
    $line_break$character"""

    palette = 'gruvbox_dark'

    [palettes.gruvbox_dark]
    color_fg0 = '#fbf1c7'
    color_bg1 = '#3c3836'
    color_bg3 = '#665c54'
    color_blue = '#458588'
    color_aqua = '#689d6a'
    color_green = '#98971a'
    color_orange = '#d65d0e'
    color_purple = '#b16286'
    color_red = '#cc241d'
    color_yellow = '#d79921'

    [os]
    disabled = false
    style = "bg:color_orange fg:color_fg0"

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
    style_user = "bg:color_orange fg:color_fg0"
    style_root = "bg:color_orange fg:color_fg0"
    format = '[ $user ]($style)'

    [directory]
    style = "fg:color_fg0 bg:color_yellow"
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
    style = "bg:color_aqua"
    format = '[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)'

    [git_status]
    style = "bg:color_aqua"
    format = '[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)'

    [nodejs]
    symbol = ""
    style = "bg:color_blue"
    format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

    [c]
    symbol = " "
    style = "bg:color_blue"
    format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

    [cpp]
    symbol = " "
    style = "bg:color_blue"
    format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

    [rust]
    symbol = ""
    style = "bg:color_blue"
    format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

    [golang]
    symbol = ""
    style = "bg:color_blue"
    format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

    [php]
    symbol = ""
    style = "bg:color_blue"
    format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

    [java]
    symbol = ""
    style = "bg:color_blue"
    format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

    [kotlin]
    symbol = ""
    style = "bg:color_blue"
    format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

    [haskell]
    symbol = ""
    style = "bg:color_blue"
    format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

    [python]
    symbol = ""
    style = "bg:color_blue"
    format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

    [nix_shell]
    symbol = " "
    style = "bg:color_bg3"
    format = '[[ $symbol$state( \($name\)) ](fg:color_fg0 bg:color_bg3)]($style)'

    [time]
    disabled = false
    time_format = "%R"
    style = "bg:color_bg1"
    format = '[[  $time ](fg:color_fg0 bg:color_bg1)]($style)'

    [line_break]
    disabled = false

    [character]
    disabled = false
    success_symbol = '[](bold fg:color_green)'
    error_symbol = '[](bold fg:color_red)'
    vimcmd_symbol = '[](bold fg:color_green)'
    vimcmd_replace_one_symbol = '[](bold fg:color_purple)'
    vimcmd_replace_symbol = '[](bold fg:color_purple)'
    vimcmd_visual_symbol = '[](bold fg:color_yellow)'
  '';

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
        light = "Gruvbox Light Hard";
        dark = "Gruvbox Dark Hard";
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

  programs.codex = {
    enable = true;
  };
}
