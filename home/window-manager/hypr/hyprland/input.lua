hl.config({
	input = {
		kb_layout = "us,de",
		kb_variant = "",
		kb_model = "",
		kb_options = "fkeys:basic_13-24,ctrl:nocaps",
		kb_rules = "",
		repeat_rate = 30,
		repeat_delay = 300,

		follow_mouse = 1,

		sensitivity = -0.7, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})
