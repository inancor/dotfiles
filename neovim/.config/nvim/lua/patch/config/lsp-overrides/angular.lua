local util = require 'lspconfig.util'

local function build_cmd(probe_dir)
	return { 'ngserver', '--stdio', '--tsProbeLocations', probe_dir, '--ngProbeLocations', probe_dir }
end

local function override()
	local lsp_root = "/home/connor/.local/share/nvim/lsp_servers/angularls/node_modules"

	return {
		root_dir = util.root_pattern('angular.json'),
		cmd = build_cmd(lsp_root),
		on_new_config = function(new_cfg, new_root)
			new_cfg.cmd = build_cmd(lsp_root)
		end
	}
end

return override

