---@param event EventData.on_tick
function events.on_tick(event)
    script.raise_event(events.on_uploader_process_event, {})
    script.raise_event(events.on_downloader_process_event, {})
end
