-- These three were legacy `exec` entries, so keep their reload-time behavior.
hl.exec_cmd([[gsettings set org.gnome.desktop.interface gtk-theme "Breeze-Dark"]])
hl.exec_cmd([[gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"]])
hl.exec_cmd("uwsm app -- hypridle")

-- Legacy `exec-once` entries only run when the compositor starts.
hl.on("hyprland.start", function()
	local commands = {
		"uwsm app -- flatpak run com.github.wwmm.easyeffects --gapplication-service",
		"uwsm app -- nm-applet",
		"uwsm app -- hyprctl setcursor BreezeX-RosePineDawn-Linux 24",
		"uwsm app -- systemctl --user start plasma-polkit-agent",
		"uwsm app -- caelestia shell -d",
		"uwsm app -- wl-paste --type text --watch cliphist store",
		"uwsm app -- wl-paste --type image --watch cliphist store",
		"uwsm app -- clipse -listen",
		-- LibrePods: both AppImages (identical sha256) abort on every launch
		-- (Rust panic at src/main.rs:53). ~/Scripts/librepods (older build) works,
		-- but only when Bluetooth is up -- it aborts if the adapter is down,
		-- so skip the launch unless the adapter is powered.
		"uwsm app -- sh -c 'sleep 20 && bluetoothctl show | grep -q \"Powered: yes\" && exec /home/archmo/Scripts/librepods --start-minimized'",
		"hyprctl dispatch workspace 1",
		"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
	}

	for _, command in ipairs(commands) do
		hl.exec_cmd(command)
	end
end)
