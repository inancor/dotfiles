reload_script = function(name)
    require("plenary.reload").reload_module(name)
    require(name)
    return print(name .. " reloaded")
end
