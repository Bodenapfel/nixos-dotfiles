local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "thunar"
local browser = "firefox"
local menu = "rofi -show drun"

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + BackSpace", hl.dsp.exit())
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + C", hl.dsp.window.float())
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + O", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(browser))
hl.bind("ALT + Tab", hl.dsp.exec_cmd("rofi -show window"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(terminal .. " nvim /home/dk/.dotfiles"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(terminal .. " nvim"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(terminal .. " btop"))
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("rofi -modi emoji -show emoji"))
hl.bind(
	mainMod .. " + comma",
	hl.dsp.exec_cmd("rofi -show calc -modi calc -no-show-match -no-sort -automatic-save-to-history")
)
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("systemctl --user restart waybar"))
hl.bind(mainMod .. " + CONTROL + S", hl.dsp.exec_cmd("awww img ~/.local/share/wallpapers/mojave.jpg"))
hl.bind(
	mainMod .. " + CONTROL + SHIFT + S",
	hl.dsp.exec_cmd("awww img ~/.local/share/wallpapers/skeleton.gif --transition-type=none")
)

hl.bind("F16", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

hl.bind("Print", hl.dsp.exec_cmd([[grimblast -n copysave area $HOME/Pictures/Screenshots/$(date +%F_%H-%M-%S).png]]))
hl.bind(
	mainMod .. " + Print",
	hl.dsp.exec_cmd(
		[[grimblast save output - | satty --filename - --output-filename $HOME/Pictures/Screenshots/$(date +%F_%H-%M-%S).png]]
	)
)

hl.bind("F21", hl.dsp.exec_cmd("bash ~/Scripts/hue-dunkler.sh"))
hl.bind("F22", hl.dsp.exec_cmd("bash ~/Scripts/hue-heller.sh"))
hl.bind("F13", hl.dsp.exec_cmd("bash ~/Scripts/hue-aus.sh"))
hl.bind("SUPER + CONTROL + Space", hl.dsp.exec_cmd("switchkb"))

hl.bind("F24", hl.dsp.exec_cmd("ddcutil --bus=12 --sleep-multiplier=0.1 setvcp 10 + 10"))
hl.bind("F23", hl.dsp.exec_cmd("ddcutil --bus=12 --sleep-multiplier=0.1 setvcp 10 - 10"))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))

hl.bind(mainMod .. " + CONTROL + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CONTROL + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + CONTROL + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + CONTROL + j", hl.dsp.window.move({ direction = "d" }))

for workspace = 1, 9 do
	hl.bind(mainMod .. " + " .. workspace, hl.dsp.focus({ workspace = workspace }))
	hl.bind(mainMod .. " + SHIFT + " .. workspace, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + D", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + d", hl.dsp.window.move({ workspace = 10 }))

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-s"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
