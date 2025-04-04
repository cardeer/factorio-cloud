-- entity
local cloud_uploader = table.deepcopy(data.raw['container']['steel-chest'])
cloud_uploader.name = constants.items.cloud_storage_uploader.name
cloud_uploader.inventory_size = 1
cloud_uploader.minable.result = constants.items.cloud_storage_uploader.name
cloud_uploader.icon = constants.items.cloud_storage_uploader.icon
cloud_uploader.icon_size = 200
cloud_uploader.picture = {
    filename = constants.items.cloud_storage_uploader.icon,
    width = 200,
    height = 200,
    scale = 1 / (250 / 32),
}

-- item
local cloud_uploader_item = table.deepcopy(data.raw["item"]['steel-chest'])
cloud_uploader_item.name = constants.items.cloud_storage_uploader.name
cloud_uploader_item.icon = constants.items.cloud_storage_uploader.icon
cloud_uploader_item.icon_size = 200
cloud_uploader_item.stack_size = 50
cloud_uploader_item.place_result = constants.items.cloud_storage_uploader.name

data:extend({
    cloud_uploader,
    cloud_uploader_item,
    {
        type = 'recipe',
        enabled = false,
        name = constants.items.cloud_storage_uploader.name,
        ingredients = {
            {
                type = 'item',
                name = 'passive-provider-chest',
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
        results = { {
            type = 'item',
            name = constants.items.cloud_storage_uploader.name,
            amount = 1
        } },
        place_result = constants.items.cloud_storage_uploader.name
    }
})
