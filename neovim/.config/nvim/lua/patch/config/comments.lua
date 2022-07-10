require 'patch.utils'.safe_setup('Comment', {
	---Add a space b/w comment and the line
	---@type boolean|fun():boolean
	padding = true,

	--- Trim left and right sides of block comments before inserting
	trim = false,

	---Whether the cursor should stay at its position
	---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
	---@type boolean
	sticky = true,

	---Lines to be ignored while comment/uncomment.
	---Could be a regex string or a function that returns a regex string.
	---Example: Use '^$' to ignore empty lines
	---@type string|fun():string
	-- ignore = nil,
	ignore = '^$',

	---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
	---NOTE: If `mappings = false` then the plugin won't create any mappings
	---@type boolean|table
	--mappings = false,

	---Pre-hook, called before commenting the line
	---@param ctx Ctx
	pre_hook = function(ctx)
		-- Only calculate commentstring for tsx filetypes
		--if vim.bo.filetype == 'typescript' or vim.bo.filetype == 'javascript' then
		local utils = require 'ts_context_commentstring.utils'
		local inter = require 'ts_context_commentstring.internal'
		local comment_utils = require 'Comment.utils'

		-- Determine whether to use linewise or blockwise commentstring
		local type = ctx.ctype == comment_utils.ctype.line and '__default' or '__multiline'

		-- Determine the location where to calculate commentstring from
		local location = nil
		if ctx.ctype == comment_utils.ctype.block then
			location = utils.get_cursor_location()
		elseif ctx.cmotion == comment_utils.cmotion.v or ctx.cmotion == comment_utils.cmotion.V then
			location = utils.get_visual_start_location()
		end

		return inter.calculate_commentstring({ key = type, location = location })
		--end
	end,

	---Post-hook, called after commenting is done
	---@type fun(ctx: Ctx)
	post_hook = nil,
})
