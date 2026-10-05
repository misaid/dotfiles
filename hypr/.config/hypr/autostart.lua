-- These three were legacy `exec` entries, so keep their reload-time behavior.
hl.exec_cmd([[gsettings set org.gnome.desktop.interface gtk-theme "Breeze-Dark"]])
hl.exec_cmd([[gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"]])
hl.exec_cmd("uwsm app -- hypridle")

-- Legacy `exec-once` entries only run when the compositor starts.
hl.on("hyprland.start", function()
	local commands = {
		"hyprctl plugin load /home/archmo/Projects/hypr-seam/build/libhypr-seam.so",
		-- require("seam") in hyprland.lua runs during the initial config parse,
		-- before this plugin load has had a chance to register its config
		-- keys, so that first pass silently fails to apply seam.lua's values.
		-- Re-trigger a reload shortly after the plugin is up so it gets
		-- applied for real (same delayed-start pattern as the EasyEffects
		-- entry below).
		"sh -c 'sleep 1 && hyprctl reload'",
		"uwsm app -- nm-applet",
		"uwsm app -- hyprctl setcursor BreezeX-RosePineDawn-Linux 24",
		"uwsm app -- systemctl --user start plasma-polkit-agent",
		"uwsm app -- caelestia shell -d",
		-- EasyEffects 8.x Qt has a native tray icon, but it only shows if the
		-- StatusNotifierWatcher host (caelestia) is already up. Delay start so
		-- QSystemTrayIcon::isSystemTrayAvailable() is true. --service-mode
		-- replaces deprecated --gapplication-service; -w hides the window to tray.
		"uwsm app -- sh -c 'sleep 5 && flatpak run com.github.wwmm.easyeffects --service-mode -w'",
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
