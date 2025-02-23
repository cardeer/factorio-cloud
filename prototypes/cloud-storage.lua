graphics_location = general_constants.graphics_location_prefix

cloud_storage = table.deepcopy(data.raw["container"]["steel-chest"])
cloud_storage.name = item_constants.cloud_storage.name
cloud_storage.inventory_size = 1000
cloud_storage.max_health = 50000
cloud_storage.icon = graphics_location .. "/cloud-storage/icon.png"
cloud_storage.resistances = {{
    type = "fire",
    percent = 90
}}
cloud_storage.minable.result = item_constants.cloud_storage.name
cloud_storage.inventory_type = "with_filters_and_bar"

data:extend({cloud_storage, {
    type = 'item',
    name = item_constants.cloud_storage.name,
    icon = graphics_location .. "/cloud-storage/icon.png",
    icon_size = 200,
    subgroup = 'storage',
    order = 'a[items]-b[steel-chest]',
    place_result = item_constants.cloud_storage.name,
    stack_size = 50
}, {
    type = 'recipe',
    name = item_constants.cloud_storage.name,
    ingredients = {{
        type = 'item',
        name = 'steel-plate',
        amount = 100
    }},
    results = {{
        type = 'item',
        name = item_constants.cloud_storage.name,
        amount = 1
    }}
}, {
    type = "technology",
    name = item_constants.cloud_storage.name,
    icon = graphics_location .. "/cloud-storage/icon.png",
    icon_size = 200,
    effects = {},
    unit = {
        count = 100,
        ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}},
        time = 10
    },
    order = "a-b-b"
}})
