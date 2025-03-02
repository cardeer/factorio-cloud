-- entity
local cloud_uploader = table.deepcopy(data.raw['container']['steel-chest'])
cloud_uploader.name = constants.items.cloud_storage_uploader.name
cloud_uploader.inventory_size = 1
cloud_uploader.minable.result = constants.items.cloud_storage_uploader.name
cloud_uploader.icon = constants.general.graphics_location .. '/cloud-storage/uploader.png'
cloud_uploader.icon_size = 200

-- item
local cloud_uploader_item = table.deepcopy(data.raw["item"]['steel-chest'])
cloud_uploader_item.name = constants.items.cloud_storage_uploader.name
cloud_uploader_item.icon = constants.general.graphics_location .. '/cloud-storage/uploader.png'
cloud_uploader_item.icon_size = 200
cloud_uploader_item.stack_size = 50
cloud_uploader_item.place_result = constants.items.cloud_storage_uploader.name
-- cloud_uploader_item.pictures = "item/" .. constants.items.cloud_storage_uploader.name
-- cloud_uploader_item.animation = {}

data:extend({cloud_uploader, cloud_uploader_item, {
    type = 'recipe',
    name = constants.items.cloud_storage_uploader.name,
    ingredients = {{
        type = 'item',
        name = 'iron-plate',
        amount = 100
    }},
    results = {{
        type = 'item',
        name = constants.items.cloud_storage_uploader.name,
        amount = 1
    }},
    place_result = constants.items.cloud_storage_uploader.name
}})
