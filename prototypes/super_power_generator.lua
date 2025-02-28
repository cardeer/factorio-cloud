local path = '__factorio-cloud__/graphics'

data:extend({ {
    type = 'electric-energy-interface',
    name = item_constants.ark_reactor.name,
    icon = path .. '/power-generator/icon.png',
    icon_size = 32,
    stack_size = 100,
    group = 'production',
    subgroup = 'energy',
    order = 'a',
    drawing_box = { { -1, -2 }, { 1, 2 } },
    collision_box = { { -1, -2 }, { 1, 2 } },
    selection_box = { { -1, -2 }, { 1, 2 } },
    minable = {
        result = item_constants.ark_reactor.name,
        mining_time = 1
    },
    energy_production = '100MW',
    energy_source = {
        type = 'electric',
        buffer_capacity = "100MW",
        input_flow_limit = "0kW",
        output_flow_limit = '100MW',
        usage_priority = 'primary-output',
        render_no_power_icon = false
    },
    energy_usage = '0kW',
    animation = {
        filename = path .. '/power-generator/item.png',
        width = 250,
        height = 250,
        scale = 4 / (250 / 32),
        frame_count = 1
    }
}, {
    type = 'item',
    name = item_constants.ark_reactor.name,
    icon = path .. '/power-generator/icon.png',
    place_result = item_constants.ark_reactor.name,
    icon_size = 32,
    stack_size = 100,
    group = 'production',
    subgroup = 'energy'
}, {
    type = 'recipe',
    name = item_constants.ark_reactor.name,
    energy_required = 0.1,
    ingredients = { {
        type = 'item',
        name = 'low-density-structure',
        amount = 100
    },
        {
            type = 'item',
            name = 'laser-turret',
            amount = 10
        },
        {
            type = 'item',
            name = 'supercapacitor',
            amount = 100
        },
        {
            type = 'item',
            name = 'tungsten-carbide',
            amount = 100
        },
        {
            type = 'item',
            name = 'uranium-235',
            amount = 150
        } },
    results = { {
        type = 'item',
        name = item_constants.ark_reactor.name,
        amount = 1
    } }
},
    {
        type = "technology",
        name = item_constants.ark_reactor.name,
        icon = general_constants.graphics_location_prefix .. "/power-generator/icon.png",
        icon_size = 200,
        effects = {},
        unit = {
            count = 1000,
            ingredients = {
                { "automation-science-pack",      1 },
                { "logistic-science-pack",        1 },
                { "chemical-science-pack",        1 },
                { "utility-science-pack",         1 },
                { "space-science-pack",           1 },
                { "metallurgic-science-pack",     1 },
                { "electromagnetic-science-pack", 1 }
            },
            time = 50
        },
        order = "a-b-b"
    }
})
