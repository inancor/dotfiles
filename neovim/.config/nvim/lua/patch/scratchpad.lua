local utils = require 'patch.utils.init'
local notify = require 'notify'

local window = utils.pick_window()
notify('window: ' .. window)
