local constants = require("constants")
local path = constants.icon_location_prefix

local name = 'cloud-storage'

local cloud_storage = table.deepcopy(data.raw["container"]["steel-chest"])
cloud_storage.name = name
cloud_storage.inventory_size = 1000
cloud_storage.max_health = 50000
cloud_storage.icon = path.."/cloud-storage/icon.png"
cloud_storage.resistances = { { type = "fire", percent = 90 } }
cloud_storage.minable.result = name
cloud_storage.inventory_type = "with_filters_and_bar"

data:extend({
    cloud_storage,
    {
        type = 'item',
        name = name,
        icon = path.."/cloud-storage/icon.png",
        icon_size = 200,
        subgroup = 'storage',
        order = 'a[items]-b[steel-chest]',
        place_result = name,
        stack_size = 50
    },
    {
        type = 'recipe',
        name = name,
        ingredients = {
            { type = 'item', name = 'steel-plate', amount = 100 }
        },
        results = {
            { type = 'item', name = name, amount = 1 }
        }
    },
    {
        type = "technology",
        name = name,
        icon = path .. "/cloud-storage/icon.png",
        icon_size = 200,
        effects = {},
        unit = {
            count = 100,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 }
            },
            time = 10
        },
        order = "a-b-b",
    },
})