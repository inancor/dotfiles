local ns = vim.api.nvim_create_namespace("patch/diagnostics")
vim.cmd('hi! def Dim guifg=grey')

local function HandleDiagnosticItem(diag, _)
	local is_unused_var = vim.tbl_contains(diag.tags or {}, vim.lsp.protocol.DiagnosticTag.Unnecessary)

	if is_unused_var then
		return {
			hl_group = "LspDiagnosticsUnusedHint",
			append_diagnostic = false,
			-- virtual_text = {
			-- 	text = { { "unused variable", 'dim' } },
			-- 	position = "right_align"
			-- },
			['start'] = { row = diag.range.start.line, col = diag.range.start.character },
			['end'] = { row = diag.range['end'].line, col = diag.range['end'].character, }
		}
	else
		return nil
	end
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
	local bufnr = vim.uri_to_bufnr(result.uri)
	if not bufnr then return end

	vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
	local real_diags = {}
	for _, diag in pairs(result.diagnostics) do
		local outcome = HandleDiagnosticItem(diag, bufnr)
		if outcome == nil then
			table.insert(real_diags, diag)
		else
			pcall(vim.api.nvim_buf_set_extmark, bufnr, ns,
				outcome.start.row, outcome.start.col, {
				end_row = outcome['end'].line,
				end_col = outcome['end'].col,
				hl_group = outcome.hl_group,
				virt_text = outcome.virtual_text and outcome.virtual_text.text or nil,
				virt_text_pos = outcome.virtual_text and outcome.virtual_text.position or nil
			})

			if outcome.append_diagnostic then
				table.insert(real_diags, diag)
			end
		end
	end

	result.diagnostics = real_diags
	vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
end

local border = {
	{ "🭽", "FloatBorder" },
	{ "▔", "FloatBorder" },
	{ "🭾", "FloatBorder" },
	{ "▕", "FloatBorder" },
	{ "🭿", "FloatBorder" },
	{ "▁", "FloatBorder" },
	{ "🭼", "FloatBorder" },
	{ "▏", "FloatBorder" },
}

vim.diagnostic.config({
	virtual_text = false,
	float = {
		show_header = true,
		source = 'if_many',
		border = border,
		--border = 'rounded',
		focusable = false,
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, { callback = function() vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" }) end })
