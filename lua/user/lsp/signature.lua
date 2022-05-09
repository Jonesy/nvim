local status_ok, signature = pcall(require, "lsp_signature")

if not status_ok then
	return
end

local icons = require("user.icons")

local config = {
	bind = true, -- mandatory
	debug = false, -- set to true to enable debug logging
	always_visible = true,
	floating_window = true,
	floating_window_above_cur_line = true,
	floating_window_off_x = 1,
	floating_window_off_y = 1,
	hint_enable = true,
	handler_opts = {
		border = "rounded",
	},
	toggle_key = "<M-x>",
}

signature.setup(config)
signature.status_line(200)
