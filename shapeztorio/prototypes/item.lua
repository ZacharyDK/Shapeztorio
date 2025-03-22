require ("util") 
local sounds = require("__base__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")


function create_shapez_assembler_item(assemble_params)
    return
    {
        type = "item",
        name = assemble_params.name,
        localised_name = {"",assemble_params.localised_name},
        icons = 
        {
            {
                icon = "__shapeztorio__/graphics/icons/shapez-machine-white.png",
                icon_size = 64,
                tint = assemble_params.tint,
            },
        },
        subgroup = "shapez",
        order = "b",
        inventory_move_sound = item_sounds.fluid_inventory_move,
        pick_sound = item_sounds.fluid_inventory_pickup,
        drop_sound = item_sounds.fluid_inventory_move,
        stack_size = 10,
        default_import_location = "nauvis", -- TODO
        place_result = assemble_params.name,
        weight = 20*kg,
    }
end

function create_shapez_assembler_recipe(assemble_params)
    return
    {
        type = "recipe",
        name = assemble_params.name,
        category = "basic-crafting",
        energy_required = 3,
        subgroup = "shapez",
        order = "a",
        main_product = assemble_params.name,
        ingredients = 
        {
            {
                type = "item",
                amount = 1,
                name = "assembling-machine-1",
            },
            {
                type = "item",
                amount = 2,
                name = "electronic-circuit",
            },
            {
                type = "item",
                amount = 2,
                name = "copper-plate",
            },
            {
                type = "item",
                amount = 1,
                name = "inserter",
            },
        },
        results = 
        {
            {
                type = "item",
                amount = 1,
                name = assemble_params.name,
            }
        },
        localised_name = {"",assemble_params.localised_name},
        auto_recycle = true,
        allow_productivity = false,
        hide_from_player_crafting = false,
        hidden = false, 
        enabled = false,
    }
end


data:extend(
{
    --ITEMS
    {
        type = "item",
        name = "painter-plant",
        localised_name = {"","Paint plant"},
        icon = "__shapeztorio__/graphics/icons/chemical-plant-red.png",
        icon_size = 64,
        subgroup = "shapez",
        order = "a",
        inventory_move_sound = item_sounds.fluid_inventory_move,
        pick_sound = item_sounds.fluid_inventory_pickup,
        drop_sound = item_sounds.fluid_inventory_move,
        stack_size = 10,
        default_import_location = "nauvis", 
        place_result = "painter-plant",
        weight = 20*kg,
    },
    {
        type = "item",
        name = "shapez-plant",
        localised_name = {"","Shapez plant"},
        icon = "__shapeztorio__/graphics/icons/chemical-plant-white.png",
        icon_size = 64,
        subgroup = "shapez",
        order = "a",
        inventory_move_sound = item_sounds.fluid_inventory_move,
        pick_sound = item_sounds.fluid_inventory_pickup,
        drop_sound = item_sounds.fluid_inventory_move,
        stack_size = 10,
        default_import_location = "nauvis", 
        place_result = "shapez-plant",
        weight = 20*kg,
    },
    create_shapez_assembler_item({name = "rotator-CW",localised_name = "Rotator CW", tint = {200,200,0}}),  --{r = 200, g = 200, b =0}, --rgb(200, 200, 0)
    create_shapez_assembler_item({name = "rotator-CCW",localised_name = "Rotator CCW", tint = {175,159,55}}), --{r = 200, g = 200, b =0}, --rgb(175, 159, 55)
    create_shapez_assembler_item({name = "half-destroyer-L",localised_name = "Left half destroyer", tint = {200,100,0}}),  --{r = 200, g = 200, b =0}, --rgb(200, 100, 0)
    create_shapez_assembler_item({name = "half-destroyer-R",localised_name = "Right half destroyer", tint = {146,73,9}}), --rgb(146, 73, 9)
    create_shapez_assembler_item({name = "shapez-splitter",localised_name = "Shapez splitter", tint = {146,9,132}}), --rgb(146, 9, 132)
    create_shapez_assembler_item({name = "rotate-stack-180",localised_name = "Rotate 180 + stack", tint = {200,50,50}}), --rgb(247, 7, 7)
    create_shapez_assembler_item({name = "rotate-stack-90-CW",localised_name = "Rotate 90CW + stack", tint = {63,247,7}}), --rgb(63, 247, 7)

    {
        type = "item",
        name = "swap-box",
        localised_name = {"","Swap box"},
        icons = 
        {
            {
                icon = "__shapeztorio__/graphics/icons/shapez-machine-white.png",
                icon_size = 64,
            },
        },
        subgroup = "shapez",
        order = "b",
        inventory_move_sound = item_sounds.fluid_inventory_move,
        pick_sound = item_sounds.fluid_inventory_pickup,
        drop_sound = item_sounds.fluid_inventory_move,
        stack_size = 10,
        default_import_location = "nauvis", -- TODO
        place_result = "swap-box",
        weight = 20*kg,
    },
    {
        type = "item",
        name = "transcendental-creator",
        icon = "__shapeztorio__/graphics/icons/transcendental.png",
        icon_size = 64,
        subgroup = "shapez",
        order = "a[transcendental-creator]",
        inventory_move_sound = item_sounds.steam_inventory_move,
        pick_sound = item_sounds.steam_inventory_pickup,
        drop_sound = item_sounds.steam_inventory_move,
        place_result = "transcendental-creator",
        stack_size = 20,
        default_import_location = "nauvis",
        weight = 200 * kg,
        localised_name = {"","Transcendental creation engine"},
    },
    --RECIPES
    {
        type = "recipe",
        name = "painter-plant",
        category = "basic-crafting",
        energy_required = 3,
        subgroup = "shapez",
        order = "a",
        main_product = "painter-plant",
        ingredients = 
        {
            {
                type = "item",
                amount = 1,
                name = "chemical-plant",
            },
            {
                type = "item",
                amount = 2,
                name = "electronic-circuit",
            },
            {
                type = "item",
                amount = 2,
                name = "copper-plate",
            },
            {
                type = "item",
                amount = 2,
                name = "pipe",
            },
        },
        results = 
        {
            {
                type = "item",
                amount = 1,
                name = "painter-plant"
            }
        },
        localised_name = {"","painter-plant"},
        auto_recycle = true,
        allow_productivity = false,
        hide_from_player_crafting = false,
        hidden = false, 
        enabled = false,
    },
    {
        type = "recipe",
        name = "shapez-plant",
        category = "basic-crafting",
        energy_required = 3,
        subgroup = "shapez",
        order = "a",
        main_product = "shapez-plant",
        ingredients = 
        {
            {
                type = "item",
                amount = 1,
                name = "chemical-plant",
            },
            {
                type = "item",
                amount = 2,
                name = "electronic-circuit",
            },
            {
                type = "item",
                amount = 2,
                name = "copper-plate",
            },
            {
                type = "item",
                amount = 2,
                name = "pipe",
            },
        },
        results = 
        {
            {
                type = "item",
                amount = 1,
                name = "shapez-plant",
            }
        },
        localised_name = {"","shapez-plant"},
        auto_recycle = true,
        allow_productivity = false,
        hide_from_player_crafting = false,
        hidden = false, 
        enabled = false,
    },
    create_shapez_assembler_recipe({name = "rotator-CW",localised_name = "Rotator CW", tint = {200,200,0}}),  --{r = 200, g = 200, b =0}, --rgb(200, 200, 0)
    create_shapez_assembler_recipe({name = "rotator-CCW",localised_name = "Rotator CCW", tint = {175,159,55}}), --{r = 200, g = 200, b =0}, --rgb(175, 159, 55)
    create_shapez_assembler_recipe({name = "half-destroyer-L",localised_name = "Left half destroyer", tint = {200,100,0}}),  --{r = 200, g = 200, b =0}, --rgb(200, 100, 0)
    create_shapez_assembler_recipe({name = "half-destroyer-R",localised_name = "Right half destroyer", tint = {146,73,9}}), --rgb(146, 73, 9)
    create_shapez_assembler_recipe({name = "shapez-splitter",localised_name = "Shapez splitter", tint = {146,9,132}}), --rgb(146, 9, 132)
    create_shapez_assembler_recipe({name = "rotate-stack-180",localised_name = "Rotate 180 + stack", tint = {200,50,50}}), --rgb(247, 7, 7)
    create_shapez_assembler_recipe({name = "rotate-stack-90-CW",localised_name = "Rotate 90CW + stack", tint = {63,247,7}}), --rgb(63, 247, 7)
    create_shapez_assembler_recipe({name = "swap-box",localised_name = "Swap box", tint = {200,200,200}}), --rgb(200, 200, 200)

}    
)