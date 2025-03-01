cloud_downloader = table.deepcopy(data.raw['container']['steel-chest'])
cloud_downloader.name = constants.items.cloud_storage_downloader.name
cloud_downloader.inventory_size = 1
cloud_downloader.minable.result = constants.items.cloud_storage_downloader.name

data:extend({ cloud_downloader, {
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
} })
