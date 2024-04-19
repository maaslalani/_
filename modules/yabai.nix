{config, ...}: let
  yabaiPath = "${config.xdg.configHome}/yabai";
in {
  home.file."${yabaiPath}/yabairc".text = ''
    yabai -m config                          \
        mouse_follows_focus   off            \
        focus_follows_mouse   off            \
        window_origin_display default        \
        window_placement      second_child   \
        window_zoom_persist   on             \
        window_shadow         on             \
        active_window_opacity 1.0            \
        normal_window_opacity 0.90           \
        window_opacity        off            \
        insert_feedback_color 0xffd75f5f     \
        split_ratio           0.50           \
        split_type            auto           \
        auto_balance          off            \
        top_padding           0              \
        bottom_padding        0              \
        left_padding          0              \
        right_padding         0              \
        window_gap            0              \
        layout                bsp            \
        mouse_modifier        fn             \
        mouse_action1         move           \
        mouse_action2         resize         \
        mouse_drop_action     swap
  '';
}
