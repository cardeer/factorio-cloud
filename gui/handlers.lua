---@param player LuaPlayer
---@param event LuaEventType
---@param name string
---@param fn function
function gui.add_handler(player, event, name, fn)
    local handlers = gui.get_handlers(player, event)
    handlers[name] = fn
end

---@param player LuaPlayer
---@param event LuaEventType
function gui.get_handlers(player, event)
    if not gui.handlers[player.index] then
        gui.handlers[player.index] = {}
    end

    if not gui.handlers[player.index][event] then
        gui.handlers[player.index][event] = {}
    end

    return gui.handlers[player.index][event]
end

---@param player LuaPlayer
---@param event LuaEventType
---@param name string
function gui.get_handler(player, event, name)
    local handlers = gui.get_handlers(player, event)
    return handlers[name]
end
