events = {}

require('scripts.events.on_cloud_updated')
script.on_event(events.on_cloud_updated_event, events.on_cloud_updated)

require('scripts.events.gui_opened')
require('scripts.events.gui_closed')
require('scripts.events.gui_elem_changed')
require('scripts.events.gui_click')
require('scripts.events.on_tick')
require('scripts.events.on_built_entity')
require('scripts.events.on_player_mined_entity')
require('scripts.events.on_pre_player_crafted_item')
script.on_event(defines.events.on_gui_elem_changed, events.on_gui_elem_changed)
script.on_event(defines.events.on_gui_opened, events.on_gui_opened)
script.on_event(defines.events.on_gui_closed, events.on_gui_closed)
script.on_event(defines.events.on_gui_click, events.on_gui_click)
script.on_event(defines.events.on_tick, events.on_tick)
script.on_event(defines.events.on_built_entity, events.on_built_entity)
script.on_event({
    defines.events.on_player_mined_entity,
    defines.events.on_entity_died
}, events.on_player_mined_entity)
script.on_event(defines.events.on_pre_player_crafted_item, events.on_pre_player_crafted_item)
