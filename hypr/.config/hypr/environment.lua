-- With UWSM, these are ideally exported from ~/.config/uwsm/env and
-- ~/.config/uwsm/env-hyprland. They remain here to preserve the old config.

local environment = {
    QT_QPA_PLATFORMTHEME = "qt6ct",
    XDG_CURRENT_DESKTOP = "Hyprland",
    XCURSOR_SIZE = "24",
    HYPRCURSOR_SIZE = "24",
    LIBVA_DRIVER_NAME = "nvidia",
    XDG_SESSION_TYPE = "wayland",
    GBM_BACKEND = "nvidia-drm",
    NVD_BACKEND = "direct",
    __GLX_VENDOR_LIBRARY_NAME = "nvidia",
    ELECTRON_OZONE_PLATFORM_HINT = "wayland",
    ELECTRON_DISABLE_GPU = "true",
    ELECTRON_ENABLE_OZONE = "true",
}

for name, value in pairs(environment) do
    hl.env(name, value)
end
