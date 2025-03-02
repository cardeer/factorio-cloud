events.on_cloud_updated_event = script.generate_event_name()

---@param event EventData.CustomInputEvent | { item: Cloud.StorageDetail }
function events.on_cloud_updated(event)
    gui.cloud_storage.fetch_item_stack(event.item)
end
