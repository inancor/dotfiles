local M = {}

function M.format_buffer()
	vim.lsp.buf.format({
		filter = function(clients)
			-- filter out clients that you don't want to use
			return vim.tbl_filter(function(client)
				return client.name ~= "html"
			end, clients)
		end,
	})
end

function M.lsp_formatting(bufnr)
	vim.lsp.buf.format({
		filter = function(clients)
			-- filter out clients that you don't want to use
			return vim.tbl_filter(function(client)
				return client.name ~= "html"
			end, clients)
		end,
		bufnr = bufnr,
	})
end

return M;
