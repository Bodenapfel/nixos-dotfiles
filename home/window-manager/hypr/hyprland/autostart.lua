-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user start playerctld.service && waybar")
	hl.exec_cmd("hyprctl setcursor Breeze_Light 24")
	hl.exec_cmd("systemctl --user start hyprpolkitagent.service")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("wl-clip-persist --clipboard regular")
	hl.exec_cmd("hyprsunset-auto")
	hl.exec_cmd("sleep 3 && discord --start-minimized")
	hl.exec_cmd("sleep 2 && owncloud")
	-- hl.exec_cmd(
	-- 	"sleep 1 && ferdium --ozone-platform=wayland --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto"
	-- )
	hl.exec_cmd("sleep 1 && flatpak run com.ktechpit.whatsie")
	hl.exec_cmd("systemctl --user restart pipewire pipewire-pulse wireplumber")
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("kitty -e zsh -c 'fastfetch; NO_COWSAY=1 zsh'")
	hl.exec_cmd("sleep 5 && steam -silent")
	hl.exec_cmd("jellyfin-mpv-shim --no-gui")
	hl.exec_cmd("awww img ~/.local/share/wallpapers/mojave.jpg")
end)
