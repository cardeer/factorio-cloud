require('constants.main')
require('types')
require('scripts.events')

require('utils.downloader')
require('utils.player')
require('utils.cloud')


require('gui.main')

flib_table = require('__flib__.table')

script.on_event(events.on_cloud_updated_event, events.on_cloud_updated)

script.on_event(defines.events.on_gui_elem_changed, events.on_gui_elem_changed)
script.on_event(defines.events.on_gui_opened, events.on_gui_opened)
script.on_event(defines.events.on_gui_closed, events.on_gui_closed)
script.on_event(defines.events.on_gui_click, events.on_gui_click)
script.on_event(defines.events.on_tick, events.on_tick)
