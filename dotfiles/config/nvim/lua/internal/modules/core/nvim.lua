return {
	name = "nvim",
	dir = vim.fn.stdpath("config"),
	lazy = false,
	priority = 1,
	opts_extend = { "x_inits" },
	opts = {
		---@type { [string]: fun() }[]
		x_inits = {
			{
				["*"] = function()
					vim.g.loaded_node_provider = 0
					vim.g.loaded_perl_provider = 0
					vim.g.loaded_python3_provider = 0
					vim.g.loaded_ruby_provider = 0

					vim.opt.breakindent = true
					vim.opt.colorcolumn = { "80" }
					vim.opt.cursorline = true
					vim.opt.cursorlineopt = "number"
					vim.opt.expandtab = true
					vim.opt.ignorecase = true
					vim.opt.inccommand = "split"
					vim.opt.mouse = "a"
					vim.opt.number = true
					vim.opt.report = 0
					vim.opt.scrolloff = 10
					vim.opt.shiftwidth = 4
					vim.opt.showmode = false
					vim.opt.signcolumn = "yes"
					vim.opt.shortmess:append({ I = true })
					vim.opt.smartcase = true
					vim.opt.softtabstop = 4
					vim.opt.splitbelow = true
					vim.opt.splitright = true
					vim.opt.tabstop = 4
					vim.opt.timeout = false
					vim.opt.undofile = true
					vim.opt.updatetime = 250

					-- -- core/multicursor.lua owns this.
					-- vim.keymap.set({ "n" }, "<Esc>", function()
					-- 	vim.cmd.nohlsearch()
					-- end, { silent = true })

					vim.keymap.set({ "n", "v" }, ",c", '"+c', { silent = true })
					vim.keymap.set({ "n", "v" }, ",C", '"+C', { silent = true })
					vim.keymap.set({ "n", "v" }, ",d", '"+d', { silent = true })
					vim.keymap.set({ "n", "v" }, ",D", '"+D', { silent = true })
					vim.keymap.set({ "n", "v" }, ",p", '"+p', { silent = true })
					vim.keymap.set({ "n", "v" }, ",P", '"+P', { silent = true })
					vim.keymap.set({ "n", "v" }, ",y", '"+y', { silent = true })
					vim.keymap.set({ "n", "v" }, ",Y", '"+Y', { silent = true })

					vim.keymap.set({ "n" }, ",w", function()
						if not vim.bo.modified then
							vim.notify('buffer has no unsaved changes', vim.log.levels.info)
							return
						end
						vim.cmd("w")
					end, { silent = true })

					vim.keymap.set({ "n" }, ",W", function()
						local modified_bufs = vim.fn.getbufinfo({ bufmodified = 1 })
						if #modified_bufs == 0 then
							vim.notify('buffers have no unsaved changes', vim.log.levels.info)
							return
						end
						vim.cmd("wa")
					end, { silent = true })

					vim.keymap.set({ "n" }, ",q", function()
						local modified_bufs = vim.fn.getbufinfo({ bufmodified = 1 })
						if #modified_bufs ~= 0 then
							if #modified_bufs == 1 then
								vim.notify(tostring(#modified_bufs) .. ' buffer has unsaved changes', vim.log.levels
								.warn)
							else
								vim.notify(tostring(#modified_bufs) .. ' buffers have unsaved changes',
									vim.log.levels.warn)
							end
							return
						end
						vim.cmd("qa")
					end, { silent = true })

					vim.keymap.set({ "n" }, ",Q", function()
						vim.cmd("qa!")
					end, { silent = true })

					vim.keymap.set('n', ',x', function()
						local bufs = vim.fn.getbufinfo({ buflisted = 1 })
						if #bufs ~= 0 and vim.bo.modified then
							vim.notify('buffer has unsaved changes', vim.log.levels.WARN)
							return
						end
						if #bufs > 1 then
							vim.cmd("bd")
						else
							vim.cmd("q")
						end
					end, { silent = true })

					vim.keymap.set('n', ',X', function()
						local bufs = vim.fn.getbufinfo({ buflisted = 1 })
						if #bufs ~= 0 then
							vim.cmd("w")
						end
						if #bufs > 1 then
							vim.cmd("bd")
						else
							vim.cmd("q")
						end
					end, { silent = true })
				end,
			},
		},
	},
	config = function(_, opts)
		local inits_from_ft = {}
		for _, init_from_ft in ipairs(opts.x_inits) do
			for ft, init in pairs(init_from_ft) do
				inits_from_ft[ft] = inits_from_ft[ft] or {}
				table.insert(inits_from_ft[ft], init)
			end
		end

		local non_ft_inits = inits_from_ft["*"] or {}
		inits_from_ft["*"] = nil
		for _, non_ft_init in ipairs(non_ft_inits) do
			non_ft_init()
		end

		for ft, ft_inits in pairs(inits_from_ft) do
			vim.api.nvim_create_autocmd({ "FileType" }, {
				group = vim.api.nvim_create_augroup("internal_nvim_x_inits_" .. ft, {}),
				pattern = { ft },
				callback = function()
					for _, ft_init in ipairs(ft_inits) do
						ft_init()
					end
				end,
			})
		end
	end,
}
