-- Per-monitor overrides (match by output name or text in the description)
local monitor_presets = {
    ["LG ULTRAGEAR"] = { mode = "2560x1440@59.95", scale = 1 },
    -- Tip: You can also match by model name from `hyprctl monitors all` so any port works:
    -- ["DELL U2723QE"] = { mode = "2560x1440@60", scale = 1 },
}

local function get_preset(mon)
    if not mon then
        return { mode = "preferred", scale = 1 }
    end
    if monitor_presets[mon.name] then
        return monitor_presets[mon.name]
    end
    -- Lua monitor objects expose description, not the JSON-only model field.
    for description, preset in pairs(monitor_presets) do
        if mon.description and mon.description:find(description, 1, true) then
            return preset
        end
    end
    return { mode = "preferred", scale = 1 }
end

local function get_displays()
    local internal, external
    -- Get all connected monitors (including disabled ones)
    for _, mon in ipairs(hl.get_monitors({ all = true })) do
        if mon.name:match("^eDP") then
            internal = mon
        else
            external = mon
        end
    end
    return internal, external
end

local function open_display_menu()
    local internal, external = get_displays()

    if not internal or not external then
        hl.notification.create({
            text = "A laptop screen and an external monitor are required.",
            timeout = 3000
        })
        return
    end

    local preset = get_preset(external)
    internal, external = internal.name, external.name

    -- Spawn fuzzel asynchronously via sh so we don't block Hyprland's main loop
    local menu = table.concat({
        "󰍹  External Only (Desk)",
        "EƎ Mirror (Projector)",
        "EE Extend (Presenter)",
        "󰌢  Laptop Only"
    }, "\n")

    local cmd = string.format(
        [[sh -c '
            CHOICE=$(printf "%s" | fuzzel --dmenu --prompt="Display: " --lines=4 --width=28)
            case "$CHOICE" in
                *"External Only"*)
                    hyprctl eval "hl.monitor({ output = \"%s\", disabled = true }); hl.monitor({ output = \"%s\", disabled = false, mode = \"%s\", position = \"0x0\", scale = %s, mirror = \"\" })" && hyprctl notify 5 3000 0 "Display switched: External Only"
                    ;;
                *"Mirror"*)
                    hyprctl eval "hl.monitor({ output = \"%s\", disabled = false, mode = \"preferred\", position = \"0x0\", scale = 1, mirror = \"\" }); hl.monitor({ output = \"%s\", disabled = false, mode = \"%s\", position = \"0x0\", scale = %s, mirror = \"%s\" })" && hyprctl notify 5 3000 0 "Display switched: Mirror"
                    ;;
                *"Extend"*)
                    hyprctl eval "hl.monitor({ output = \"%s\", disabled = false, mode = \"preferred\", position = \"0x0\", scale = 1, mirror = \"\" }); hl.monitor({ output = \"%s\", disabled = false, mode = \"%s\", position = \"auto-right\", scale = %s, mirror = \"\" })" && hyprctl notify 5 3000 0 "Display switched: Extend"
                    ;;
                *"Laptop Only"*)
                    hyprctl eval "hl.monitor({ output = \"%s\", disabled = true }); hl.monitor({ output = \"%s\", disabled = false, mode = \"preferred\", position = \"0x0\", scale = 1, mirror = \"\" })" && hyprctl notify 5 3000 0 "Display switched: Laptop Only"
                    ;;
            esac
        ']],
        menu,
        internal, external, preset.mode, preset.scale, -- External Only
        internal, external, preset.mode, preset.scale, internal, -- Mirror
        internal, external, preset.mode, preset.scale, -- Extend
        external, internal           -- Laptop Only
    )

    hl.dispatch(hl.dsp.exec_cmd(cmd))
end

hl.bind("SUPER + T", open_display_menu, { description = "Open Display Switcher Menu" })
