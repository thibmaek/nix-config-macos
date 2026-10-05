{
  enable = true;
  package = null;
  extensions = [
    "docker"
    "make"
    "nix"
    "toml"
  ];
  userKeymaps = [
    {
      bindings = {
        "cmd-shift-d" = "editor::DuplicateLineDown";
        "cmd-shift-g" = "git_panel::ToggleFocus";
        "ctrl-k a" = "agent::Toggle";
        "ctrl-k s" = "editor::SortLinesCaseInsensitive";
        "ctrl-k t" = "terminal_panel::Toggle";
      };
    }
  ];
  userSettings = {
    edit_predictions = {
      provider = "zed";
    };
    agent_servers = {
      Opencode = {
        favorite_config_option_values = {
          model = [
            "ollama/glm-5.3-flash:cloud"
            "ollama/glm-5.3:cloud"
            "ollama/kimi-k3:cloud"
          ];
        };
        type = "custom";
        command = "opencode";
        args = [ "acp" ];
      };
    };
    proxy = "";
    agent = {
      default_model = {
        provider = "ollama";
        model = "glm-5.3:cloud";
        enable_thinking = true;
      };
      show_turn_stats = true;
      thinking_display = "preview";
      play_sound_when_agent_done = "when_hidden";
      threads_sidebar = {
        auto_open = false;
        default_width = 250.0;
        position = "right";
      };
      max_content_width = 850.0;
      default_width = 400.0;
      dock = "right";
      favorite_models = [ ];
      model_parameters = [ ];
    };
    git_panel = {
      show_count_badge = false;
      file_icons = true;
      group_by = "staging";
      collapse_untracked_diff = false;
      tree_view = true;
      dock = "left";
    };
    terminal = {
      toolbar = {
        breadcrumbs = false;
      };
      bell = "system";
      option_as_meta = true;
      show_count_badge = true;
    };
    use_system_window_tabs = false;
    bottom_dock_layout = "contained";
    tab_bar = {
      show_pinned_tabs_in_separate_row = false;
    };
    tabs = {
      close_position = "left";
      file_icons = true;
      git_status = true;
    };
    title_bar = {
      show_menus = false;
      show_branch_status_icon = true;
    };
    status_bar = {
      show_active_file = true;
      line_endings_button = true;
      cursor_position_button = true;
      active_language_button = true;
    };
    project_panel = {
      hide_hidden = false;
      hide_root = false;
      git_status_indicator = true;
      diagnostic_badges = false;
      bold_folder_labels = true;
      folder_indicator = "icon";
      entry_spacing = "comfortable";
      default_width = 280.0;
      dock = "left";
      button = true;
    };
    search = {
      button = true;
      center_on_match = true;
    };
    which_key = {
      enabled = false;
    };
    show_wrap_guides = true;
    cursor_shape = "bar";
    cursor_animation = {
      enabled = false;
    };
    markdown_preview = {
      code_font_family = "FiraCode Nerd Font";
      font_family = "IBM Plex Sans";
    };
    buffer_font_family = "Monaspace Radon";
    cli_default_open_behavior = "new_window";
    ui_font_size = 16;
    buffer_font_size = 15;
    theme = {
      mode = "system";
      light = "Ayu Light";
      dark = "Ayu Mirage";
    };
  };
}
