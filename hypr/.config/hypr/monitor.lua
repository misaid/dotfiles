hl.monitor({
    output = "DP-2",
    mode = "1920x1080@239.5",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60",
    position = "1920x0",
    scale = 1,
})

hl.monitor({
    output = "DP-1",
    mode = "preferred",
    -- Mirrored outputs share the source monitor's layout position.
    position = "0x0",
    scale = 1,
    mirror = "DP-2",
})

for workspace = 1, 4 do
    hl.workspace_rule({
        workspace = tostring(workspace),
        monitor = "DP-2",
    })
end

hl.workspace_rule({
    workspace = "5",
    monitor = "DP-2",
    on_created_empty = "thunderbird",
})

hl.workspace_rule({
    workspace = "6",
    monitor = "HDMI-A-1",
    on_created_empty = "btop",
})

hl.workspace_rule({
    workspace = "7",
    monitor = "HDMI-A-1",
})
