local path = '__factorio-cloud__/graphics'

data:extend({{
    type = 'electric-energy-interface',
    name = 'super-power-generator',
    icon = path .. '/power-generator/icon.png',
    icon_size = 32,
    stack_size = 100,
    group = 'production',
    subgroup = 'energy',
    order = 'a',
    drawing_box = {{-1, -2}, {1, 2}},
    collision_box = {{-1, -2}, {1, 2}},
    selection_box = {{-1, -2}, {1, 2}},
    minable = {
        result = 'super-power-generator',
        mining_time = 1
    },
    energy_production = '1GW',
    energy_source = {
        type = 'electric',
        buffer_capacity = "1GW",
        input_flow_limit = "0kW",
        output_flow_limit = '1GW',
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
    name = 'super-power-generator',
    icon = path .. '/power-generator/icon.png',
    place_result = 'super-power-generator',
    icon_size = 32,
    stack_size = 100,
    group = 'production',
    subgroup = 'energy'
}, {
    type = 'recipe',
    name = 'super-power-generator',
    energy_required = 0.1,
    ingredients = {{
        type = 'item',
        name = 'iron-ore',
        amount = 1
    }},
    results = {{
        type = 'item',
        name = 'super-power-generator',
        amount = 1
    }}
}})
