require("constants.main")

---@type string
local tech_added = nil
local cloud_ingredients = {
    {
        count = 100,
        ingredients = {
            { "automation-science-pack", 1 },
        },
        time = 10,
    },
    {
        count = 200,
        ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
        },
        time = 15,
    },
    {
        count = 300,
        ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
        },
        time = 20,
    },
    {
        count = 400,
        ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
        },
        time = 25,
    },
    {
        count = 500,
        ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
        },
        time = 30,
    },
    {
        count = 600,
        ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 },
        },
        time = 35,
    },
    {
        count = 700,
        ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "production-science-pack", 1 },
            { "utility-science-pack",    1 },
            { "space-science-pack",      1 },
        },
        time = 40,
    },
}

if mods['space-age'] then
    local space_agecloud_ingredients = {
        {
            count = 800,
            ingredients = {
                { "automation-science-pack",  1 },
                { "logistic-science-pack",    1 },
                { "military-science-pack",    1 },
                { "chemical-science-pack",    1 },
                { "production-science-pack",  1 },
                { "utility-science-pack",     1 },
                { "space-science-pack",       1 },
                { "metallurgic-science-pack", 1 },
            },
            time = 45,
        },
        {
            count = 900,
            ingredients = {
                { "automation-science-pack",      1 },
                { "logistic-science-pack",        1 },
                { "military-science-pack",        1 },
                { "chemical-science-pack",        1 },
                { "production-science-pack",      1 },
                { "utility-science-pack",         1 },
                { "space-science-pack",           1 },
                { "metallurgic-science-pack",     1 },
                { "electromagnetic-science-pack", 1 },
            },
            time = 45,
        },
        {
            count = 1100,
            ingredients = {
                { "automation-science-pack",      1 },
                { "logistic-science-pack",        1 },
                { "military-science-pack",        1 },
                { "chemical-science-pack",        1 },
                { "production-science-pack",      1 },
                { "utility-science-pack",         1 },
                { "space-science-pack",           1 },
                { "metallurgic-science-pack",     1 },
                { "electromagnetic-science-pack", 1 },
                { "agricultural-science-pack",    1 },
            },
            time = 50,
        },
        {
            count = 1200,
            ingredients = {
                { "automation-science-pack",      1 },
                { "logistic-science-pack",        1 },
                { "military-science-pack",        1 },
                { "chemical-science-pack",        1 },
                { "production-science-pack",      1 },
                { "utility-science-pack",         1 },
                { "space-science-pack",           1 },
                { "metallurgic-science-pack",     1 },
                { "electromagnetic-science-pack", 1 },
                { "agricultural-science-pack",    1 },
                { "cryogenic-science-pack",       1 },
            },
            time = 60,
        },
        {
            count = 1200,
            ingredients = {
                { "automation-science-pack",      1 },
                { "logistic-science-pack",        1 },
                { "military-science-pack",        1 },
                { "chemical-science-pack",        1 },
                { "production-science-pack",      1 },
                { "utility-science-pack",         1 },
                { "space-science-pack",           1 },
                { "metallurgic-science-pack",     1 },
                { "electromagnetic-science-pack", 1 },
                { "agricultural-science-pack",    1 },
                { "cryogenic-science-pack",       1 },
                { "promethium-science-pack",      1 },
            },
            time = 60,
        },
    }
    for k = 1, #space_agecloud_ingredients do
        table.insert(cloud_ingredients, space_agecloud_ingredients[k])
    end
end


for i, unit in pairs(cloud_ingredients) do
    local new_tech_name = constants.items.technology.prefix .. i
    if not data.raw.technology[new_tech_name] then
        local increase_stack = i * settings.startup["cloud_storage_stack_multiplier"].value
        local tech = {
            type = "technology",
            name = new_tech_name,
            icon = constants.items.cloud_storage_uploader.icon,
            icon_size = 200,
            effects = {},
            prerequisites = {},
            unit = unit,
            localised_description = "Cloud maximum is " .. increase_stack .. " stack per item"
        }
        if not tech_added then
            tech.prerequisites = {
                "logistic-system",
                "solar-energy",
                "electric-energy-accumulators",
                "effect-transmission"
            }
            tech.effects = {
                {
                    type = "unlock-recipe",
                    recipe = constants.items.cloud_storage_downloader.name
                },
                {
                    type = "unlock-recipe",
                    recipe = constants.items.cloud_storage_uploader.name
                },
            }
        else
            tech.prerequisites = { tech_added, unit.ingredients[i][1] }
        end
        data:extend({ tech })
    end
    tech_added = new_tech_name
end


require("prototypes.cloud_downloader")
require("prototypes.cloud_uploader")
