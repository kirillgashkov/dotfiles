-- same as fzf.lua
local height_ratio = 0.85
local width_ratio = 0.8

return {
	url = "https://github.com/nvim-tree/nvim-tree.lua",
	event = { "LazyFile", "VeryLazy" },
	opts = {
		view = {
			float = {
				enable = true,
				open_win_config = function()
					local screen_w = vim.opt.columns:get()
					local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
					local window_w = math.floor(screen_w * width_ratio)
					local window_h = math.floor(screen_h * height_ratio)
					local center_x = (screen_w - window_w) / 2
					local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
					return {
						border = "single",
						relative = "editor",
						row = center_y,
						col = center_x,
						width = window_w,
						height = window_h,
					}
				end,
			},
		},
	},
	config = function(_, opts)
		require("nvim-tree").setup(opts)
	end,
}