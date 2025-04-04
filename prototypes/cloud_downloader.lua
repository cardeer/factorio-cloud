-- entity
local cloud_downloader = table.deepcopy(data.raw['container']['steel-chest'])
cloud_downloader.name = constants.items.cloud_storage_downloader.name
cloud_downloader.minable.result = constants.items.cloud_storage_downloader.name
cloud_downloader.icon = constants.items.cloud_storage_downloader.icon
cloud_downloader.icon_size = 200
-- cloud_downloader.order = 'b'
cloud_downloader.inventory_size = 1
cloud_downloader.picture = {
    filename = constants.items.cloud_storage_downloader.icon,
    width = 200,
    height = 200,
    scale = 1 / (250 / 32),
}

-- item
local cloud_downloader_item = table.deepcopy(data.raw["item"]['steel-chest'])
cloud_downloader_item.name = constants.items.cloud_storage_downloader.name
cloud_downloader_item.icon = constants.items.cloud_storage_downloader.icon
cloud_downloader_item.icon_size = 200
cloud_downloader_item.stack_size = 50
cloud_downloader_item.place_result = constants.items.cloud_storage_downloader.name

data:extend({
    cloud_downloader,
    cloud_downloader_item,
    {
        type = 'recipe',
        enabled = false,
        name = constants.items.cloud_storage_downloader.name,
        ingredients = {
            {
                type = 'item',
                name = 'requester-chest',
                amount = 5
            },
            {
                type = 'item',
                name = 'solar-panel',
                amount = 5
            },
            {
                type = 'item',
                name = 'accumulator',
                amount = 5
            },
            {
                type = 'item',
                name = 'beacon',
                amount = 1
            }
        },
        results = {
            {
                type = 'item',
                name = constants.items.cloud_storage_downloader.name,
                amount = 1
            }
        }
    }
})
