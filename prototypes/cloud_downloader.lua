local cloud_downloader = table.deepcopy(data.raw['container']['steel-chest'])
cloud_downloader.name = item_constants.cloud_downloader.name
cloud_downloader.inventory_size = 1
cloud_downloader.minable.result = item_constants.cloud_downloader.name

data:extend({
    cloud_downloader,
    {
        type = 'recipe',
        name = item_constants.cloud_storage.name,
        ingredients = { {
            type = 'item',
            name = 'steel-plate',
            amount = 100
        } },
        results = { {
            type = 'item',
            name = item_constants.cloud_storage.name,
            amount = 1
        } }
    }
})
