hl.env("NIXOS_OZONE_WL", "1")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Toolkits
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- XDG (keep consistent)
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Could break some things
-- hl.env("SDL_VIDEODRIVER", "wayland")
-- hl.env("CLUTTER_BACKEND", "wayland")
