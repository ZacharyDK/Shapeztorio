data:extend(
{
    --Begin transcendental recipes
    {
        type = "recipe",
        name = "transcendental-iron",
        energy_required = 60,
        category = "transcendental-vortex",
        subgroup = "shapez",
        ingredients =
        {
        },
        results = 
        {
            {type="item", name="iron-plate", probability = 0.2, amount=2},
            {type="item", name="iron-gear-wheel", probability = 0.2, amount=4},
            {type="item", name="iron-stick", probability = 0.2, amount=4},
            {type="item", name="iron-ore", probability = 0.2, amount=2},
            {type="item", name="steel-plate", probability = 0.2, amount=2},
        },
        enabled = false,
        localised_name = {"","Transcendental iron"},
        allow_quality = true,
        allow_productivity = true,
        auto_recycle = false,
        main_product = "iron-ore",
    },
    {
        type = "recipe",
        name = "transcendental-copper",
        energy_required = 60,
        category = "transcendental-vortex",
        subgroup = "shapez",
        ingredients =
        {
        },
        results = 
        {
            {type="item", name="copper-plate", probability = 0.35, amount=2},
            {type="item", name="copper-cable", probability = 0.2, amount=2},
            {type="item", name="programmable-speaker", probability = 0.05, amount=1},
            {type="item", name="copper-ore", probability = 0.2, amount=2},
            {type="item", name="electronic-circuit", probability = 0.2, amount=3},
        },
        enabled = false,
        localised_name = {"","Transcendental copper"},
        allow_quality = true,
        allow_productivity = true,
        main_product = "copper-ore",
        maximum_productivity = 5,
    },
    {
        type = "recipe",
        name = "transcendental-factory",
        energy_required = 120,
        category = "transcendental-vortex",
        subgroup = "shapez",
        ingredients =
        {
        },
        results = 
        {
            {type="item", name="inserter", probability = 0.2, amount=4},
            {type="item", name="transport-belt", probability = 0.2, amount=5},
            {type="item", name="iron-gear-wheel", probability = 0.2, amount=10},
            {type="item", name="pipe", probability = 0.2, amount=10},
            {type="item", name="medium-electric-pole", probability = 0.2, amount=3},
        },
        enabled = false,
        localised_name = {"","Transcendental factory"},
        allow_quality = true,
        allow_productivity = true,
        auto_recycle = false,
        main_product = "inserter",
        maximum_productivity = 5,
    },
    {
        type = "recipe",
        name = "transcendental-power",
        energy_required = 250,
        category = "transcendental-vortex",
        subgroup = "shapez",
        ingredients =
        {
        },
        results = 
        {
            {type="item", name="solar-panel", probability = 0.38, amount=2},
            {type="item", name="accumulator", probability = 0.2, amount=5},
            {type="item", name="solid-fuel", probability = 0.2, amount=5},
            {type="item", name="uranium-fuel-cell", probability = 0.02, amount=1},
            {type="item", name="medium-electric-pole", probability = 0.2, amount=3},
        },
        enabled = false,
        localised_name = {"","Transcendental power"},
        allow_quality = true,
        allow_productivity = true,
        auto_recycle = false,
        main_product = "solar-panel",
        maximum_productivity = 5,
    },
    {
        type = "recipe",
        name = "transcendental-process",
        energy_required = 200,
        category = "transcendental-vortex",
        subgroup = "shapez",
        ingredients =
        {
        },
        results = 
        {
            {type="item", name="assembling-machine-2", probability = 0.2, amount=1},
            {type="item", name="electric-mining-drill", probability = 0.2, amount=5},
            {type="item", name="electric-furnace", probability = 0.2, amount=10},
            {type="item", name="chemical-plant", probability = 0.2, amount=10},
            {type="item", name="pumpjack", probability = 0.2, amount=3},
        },
        enabled = false,
        localised_name = {"","Transcendental process"},
        allow_quality = true,
        allow_productivity = true,
        auto_recycle = false,
        main_product = "assembling-machine-2",
        maximum_productivity = 5,
    },
    {
        type = "recipe",
        name = "transcendental-CwCwCwCw",
        energy_required = 15,
        category = "transcendental-vortex",
        subgroup = "shapez",
        ingredients =
        {
        },
        results = 
        {
            {type="item", name="CwCwCwCw", amount=8},
        },
        enabled = false,
        localised_name = {"","Transcendental shapez"},
        allow_quality = true,
        allow_productivity = true,
        auto_recycle = false,
        main_product = "CwCwCwCw",
        maximum_productivity = 5,
    },
    {
        type = "recipe",
        name = "transcendental-RwRwRwRw",
        energy_required = 15,
        category = "transcendental-vortex",
        subgroup = "shapez",
        ingredients =
        {
        },
        results = 
        {
            {type="item", name="RwRwRwRw", amount=8},
        },
        enabled = false,
        localised_name = {"","Transcendental shapez"},
        allow_quality = true,
        allow_productivity = true,
        auto_recycle = false,
        main_product = "RwRwRwRw",
        maximum_productivity = 5,
    },
    {
        type = "recipe",
        name = "transcendental-ammo",
        energy_required = 20,
        category = "transcendental-vortex",
        subgroup = "shapez",
        ingredients =
        {
        },
        results = 
        {
            {type="item", name="piercing-rounds-magazine", amount=1},
        },
        enabled = false,
        localised_name = {"","Transcendental ammo"},
        allow_quality = true,
        allow_productivity = true,
        auto_recycle = false,
        main_product = "piercing-rounds-magazine",
        maximum_productivity = 5,
    },
    {
        type = "recipe",
        name = "transcendental-rocket",
        energy_required = 100,
        category = "transcendental-vortex",
        subgroup = "shapez",
        ingredients =
        {
        },
        results = 
        {
            {type="item", name="rocket-fuel", probability = 0.3, amount=1},
            {type="item", name="low-density-structure", probability = 0.4, amount=1},
            {type="item", name="processing-unit", probability = 0.3, amount=1},
        },
        enabled = false,
        localised_name = {"","Transcendental rocket parts"},
        allow_quality = true,
        allow_productivity = true,
        auto_recycle = false,
        main_product = "rocket-fuel",
        maximum_productivity = 5,
    },
    --PAINT
    {
        type = "recipe",
        name = "paint-r",
        energy_required = 5,
        category = "paint",
        subgroup = "shapez",
        order = "[paint]-[r]",
        ingredients =
        {
            {type="fluid", name="light-oil", amount=100},
            {type="item", name="iron-ore", amount=3},
        },
        results = 
        {
            {type="fluid", name="paint-r", amount=800},
        },
        enabled = false,
        localised_name = {"","Red paint"},
        allow_quality = false,
        allow_productivity = true,
        auto_recycle = false,
        main_product = "paint-r",
        maximum_productivity = 5,
    },
    {
        type = "recipe",
        name = "paint-g",
        energy_required = 5,
        category = "paint",
        subgroup = "shapez",
        order = "[paint]-[g]",
        ingredients =
        {
            {type="fluid", name="light-oil", amount=100},
            {type="item", name="copper-ore", amount=3},
        },
        results = 
        {
            {type="fluid", name="paint-g", amount=800},
        },
        enabled = false,
        localised_name = {"","Green paint"},
        allow_quality = false,
        allow_productivity = true,
        auto_recycle = false,
        main_product = "paint-g",
        maximum_productivity = 5,
    },
    {
        type = "recipe",
        name = "paint-b",
        energy_required = 5,
        category = "paint",
        subgroup = "shapez",
        order = "[paint]-[b]",
        ingredients =
        {
            {type="fluid", name="light-oil", amount=100},
            {type="item", name="iron-plate", amount=3},
        },
        results = 
        {
            {type="fluid", name="paint-b", amount=800},
        },
        enabled = false,
        localised_name = {"","Blue paint"},
        allow_quality = false,
        allow_productivity = true,
        auto_recycle = false,
        main_product = "paint-b",
        maximum_productivity = 5,
    },
    {
        type = "recipe",
        name = "paint-w",
        energy_required = 5,
        category = "paint",
        subgroup = "shapez",
        order = "[paint]-[w]",
        ingredients =
        {
            {type="fluid", name="light-oil", amount=100},
            {type="item", name="iron-plate", amount=1},
            {type="item", name="iron-ore", amount=1},
            {type="item", name="copper-ore", amount=1},
        },
        results = 
        {
            {type="fluid", name="paint-w", amount=800},
        },
        enabled = false,
        localised_name = {"","White paint"},
        allow_quality = false,
        allow_productivity = true,
        auto_recycle = false,
        main_product = "paint-w",
        maximum_productivity = 5,
    },
}
)