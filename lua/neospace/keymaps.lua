local vim  = vim
local nvim = require'nvim'

local M = {}
M.mappings = {}

local valid_modes = {
	n = 'n'; v = 'v'; x = 'x'; i = 'i';
	o = 'o'; t = 't'; c = 'c'; s = 's';
	-- :map! and :map
	['!'] = '!'; [' '] = '';
}

function M.apply(mappings, default_options)
	for key, options in pairs(mappings) do
		options = vim.tbl_extend("keep", options, default_options or {})
		local mode, mapping = key:match("^(.)(.+)$")
		if not mode then
			assert(false, "nvim_apply_mappings: invalid mode specified for keymapping "..key)
		end
		if not valid_modes[mode] then
			assert(false, "nvim_apply_mappings: invalid mode specified for keymapping. mode="..mode)
		end
		mode = valid_modes[mode]
		local rhs = options[1]
		-- Remove this because we're going to pass it straight to nvim_set_keymap
		options[1] = nil

		--nvim.$method(...) redirects to vim.api.nvim_$method(...)
		nvim.set_keymap(mode, mapping, rhs, options)
	end
end

return M

