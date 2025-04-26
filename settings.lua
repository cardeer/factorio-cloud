data:extend({
    {
        type = "int-setting",
        name = "cloud_storage_stack_multiplier",
        setting_type = "startup",
        default_value = 2,
        minimum_value = 1,
        maximum_value = 1000,
    },
    {
        type = "int-setting",
        name = "cloud_storage_speed_upload",
        setting_type = "startup",
        default_value = 2,
        minimum_value = 1,
        maximum_value = 100,
    },
    {
        type = "int-setting",
        name = "cloud_storage_speed_download",
        setting_type = "startup",
        default_value = 2,
        minimum_value = 1,
        maximum_value = 100,
    },
    {
        type = "bool-setting",
        name = "auto_download_ingredients",
        setting_type = "runtime-per-user",
        default_value = false,
    },
})
