require('constants.main')
require('types')

require('utils.player')
require('utils.cloud')

require('scripts.scripts')

require('scripts.events')

require('gui.main')

flib_table = require('__flib__.table')
mod_gui = require("mod-gui")

script.on_event(defines.events.on_gui_opened, events.on_gui_opened)
script.on_event(defines.events.on_gui_closed, events.on_gui_closed)
script.on_event(defines.events.on_gui_click, events.on_gui_click)
script.on_event(defines.events.on_tick, events.on_tick)

script.on_init(on_init)
script.on_load(on_load)
