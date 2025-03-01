-- entity
local cloud_downloader = table.deepcopy(data.raw['container']['steel-chest'])
cloud_downloader.name = constants.items.cloud_storage_downloader.name
cloud_downloader.inventory_size = 1
cloud_downloader.minable.result = constants.items.cloud_storage_downloader.name

-- item
local cloud_downloader_item = table.deepcopy(data.raw["item"]['steel-chest'])
cloud_downloader_item.name = constants.items.cloud_storage_downloader.name
cloud_downloader_item.icon = constants.general.graphics_location .. '/cloud-storage/downloader.png'
cloud_downloader_item.icon_size = 200
cloud_downloader_item.stack_size = 50
cloud_downloader_item.place_result = constants.items.cloud_storage_downloader.name

data:extend({
    cloud_downloader,
    cloud_downloader_item,
    {
        type = 'recipe',
        name = constants.items.cloud_storage_downloader.name,
        ingredients = {
            {
                type = 'item',
                name = 'steel-plate',
                amount = 100
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
