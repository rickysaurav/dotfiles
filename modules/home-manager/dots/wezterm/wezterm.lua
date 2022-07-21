local wezterm = require 'wezterm';
return {
  native_macos_fullscreen_mode = true,
  font_size = 12.0,
  hide_tab_bar_if_only_one_tab = true,
  exit_behavior = "Close",
  keys = {
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {key="LeftArrow", mods="OPT", action=wezterm.action{SendString="\x1bb"}},
    -- Make Option-Right equivalent to Alt-f; forward-word
    {key="RightArrow", mods="OPT", action=wezterm.action{SendString="\x1bf"}},
  },
  font = wezterm.font_with_fallback({
        --  Iosevka does not seem to work with wezterm.
        --  https://github.com/wez/wezterm/issues/1516
        "Iosevka Nerd Font",
        "JetBrainsMono Nerd Font Mono"}),
  color_scheme = "OneHalfDark",
}
