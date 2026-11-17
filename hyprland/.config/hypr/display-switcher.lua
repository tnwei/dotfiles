local defaultMonitor = "eDP-1"

-- Per-monitor overrides (match by output name like "HDMI-A-1" OR monitor model string)
local monitor_presets = {
    ["LG ULTRAGEAR"] = { mode = "2560x1440@60", scale = 1 },
    -- Tip: You can also match by model name from `hyprctl monitors all` so any port works:
    -- ["DELL U2723QE"] = { mode = "2560x1440@60", scale = 1 },
}

local function get_preset(mon)
    if not mon then
        return { mode = "preferred", scale = 1 }
    end
    return monitor_presets[mon.name]
        or (mon.model and monitor_presets[mon.model])
        or { mode = "preferred", scale = 1 }
end

local function get_displays()
    local internal, external
    -- Get all connected monitors (including disabled ones)
    for _, mon in ipairs(hl.get_monitors({ all = true })) do
        if mon.name:match("^eDP") then
            internal = mon.name
        else
            external = mon.name
        end
    end
    return internal, external
end

local function open_display_menu()
    local internal, external = get_displays()

    if not external then
        hl.notification.create({
            text = "No external monitor or projector detected.",
            timeout = 3000
        })
        return
    end

    -- Spawn fuzzel asynchronously via sh so we don't block Hyprland's main loop
    local menu = table.concat({
        "󰍹  External Only (Desk)",
        "EƎ Mirror (Projector)",
        "EE Extend (Presenter)",
        "󰌢  Laptop Only"
    }, "\\n")

    local cmd = string.format(
        [[sh -c '
            CHOICE=$(printf "%s" | fuzzel --dmenu --prompt="Display: " --lines=4 --width=28)
            case "$CHOICE" in
                *"External Only"*)
                    hyprctl eval "hl.monitor({ output = \"%s\", disabled = true }); hl.monitor({ output = \"%s\", disabled = false, mode = \"preferred\", position = \"0x0\", scale = 1 })"
                    ;;
                *"Mirror"*)
                    hyprctl eval "hl.monitor({ output = \"%s\", disabled = false, mode = \"preferred\", position = \"0x0\", scale = 1 }); hl.monitor({ output = \"%s\", disabled = false, mode = \"preferred\", position = \"0x0\", scale = 1, mirror = \"%s\" })"
                    ;;
                *"Extend"*)
                    hyprctl eval "hl.monitor({ output = \"%s\", disabled = false, mode = \"preferred\", position = \"0x0\", scale = 1 }); hl.monitor({ output = \"%s\", disabled = false, mode = \"preferred\", position = \"auto-right\", scale = 1 })"
                    ;;
                *"Laptop Only"*)
                    hyprctl eval "hl.monitor({ output = \"%s\", disabled = true }); hl.monitor({ output = \"%s\", disabled = false, mode = \"preferred\", position = \"0x0\", scale = 1 })"
                    ;;
            esac
        ']],
        menu,
        internal, external,          -- External Only
        internal, external, internal,-- Mirror
        internal, external,          -- Extend
        external, internal           -- Laptop Only
    )

    hl.dispatch(hl.dsp.exec_cmd(cmd))
end

hl.bind("SUPER + T", open_display_menu, { description = "Open Display Switcher Menu" })
