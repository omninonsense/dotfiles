local wezterm = require 'wezterm';

local tab_switch_keys = {}
for i = 1,8 do
  table.insert(tab_switch_keys, {
    key="F" .. tostring(i),
    action=wezterm.action{ActivateTab=i-1}
  })
end

local keys = {
    {key="[", mods="ALT", action=wezterm.action{ActivateTabRelative=-1}},
    {key="]", mods="ALT", action=wezterm.action{ActivateTabRelative=1}},
}

-- Merge keys and tab_switch_keys
for k,v in pairs(tab_switch_keys) do table.insert(keys, v) end

return {
  color_scheme = "Wez",
  font = wezterm.font_with_fallback({
    "JetBrains Mono",
    "icons-in-terminal",
    "Noto Color Emoji",
  }),
  harfbuzz_features = {"calt=1", "clig=1"},
  keys = keys
}
