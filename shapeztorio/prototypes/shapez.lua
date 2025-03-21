require ("util") 
local sounds = require("__base__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")

--Create laboratory item and entity. We will reference it later.
require ("util")
require ("__base__.prototypes.entity.pipecovers")
require ("circuit-connector-sprites")
require ("__base__.prototypes.entity.assemblerpipes")


--Control lua handles p lab rejecting items of normal, "", nil, or common quality
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local smoke_animations = require("__base__.prototypes.entity.smoke-animations")
local smoke_fast_animation = smoke_animations.trivial_smoke_fast
local trivial_smoke = smoke_animations.trivial_smoke


local shape_code = 
{"C","R","S","D"}

local color_code = 
{"u","r","g","b","c","y","m","w"}

local tint_code = 
{
    ["u"] = {r = 150, g = 150, b =150}, --rgb(150,150,150)
    ["r"] = {r = 200, g = 0, b =0}, --rgb(200,0,0)
    ["g"] = {r = 0, g = 200, b =0}, --rgb(0,200,0)
    ["b"] = {r = 0, g = 0, b =200}, --rgb(0,0,200)
    ["c"] = {r = 0, g = 200, b =200}, --rgb(0, 200, 200)
    ["y"] = {r = 200, g = 200, b =0}, --rgb(200, 200, 0)
    ["m"] = {r = 200, g = 0, b =200}, --rgb(200, 0, 200)
    ["w"] = {r = 220, g = 220, b =220}, --rgb(220, 220, 220)
}

local code_word_table =
{
    ["C"] = "circle",
    ["R"] = "square",
    ["S"] = "star",
    ["D"] = "diamond",
    ["--"] = "--",
    ["-"] = "-",
}

local shift_table = 
{
    ["RU"] = util.by_pixel(15, 16),
    ["RL"] = util.by_pixel(15, -16),
    ["LL"] = util.by_pixel(-16, -16),
    ["LU"] = util.by_pixel(-16, 16),
}


local quarter_code = {}
--[[
for i,shape in pairs(shape_code) do
    for j, color in pairs(color_code) do
        local q = shape .. color
        table.insert(quarter_code,q)
    end
end

table.insert(quarter_code,"--") --blank
--log(serpent.block(quarter_code))
--]]


local shape_layer = {} --each la

local stored_string = settings.startup["shape-layers"].value
--log(serpent.block(stored_string))

--[[
index = 0
for s in string.gmatch(stored_string, "[^%s]+") do
    --local value = nil
    log(serpent.block(s))
    index = index + 1
    if(index > 100) then
        break
    end
end
--]]
--HOLY COW THIS WORKS leaving it for debug

--Might have to bite the bullet and not build the shape_layer object
--Shapez lab


local debug_mode = settings.startup["debug"].value
local n = 1
all_shape_names = {}
for s in string.gmatch(stored_string, "[^%s]+") do
    --log(serpent.block(s))
    shape_layer[s] =
    {
        ["RU"] = string.sub(s,1,2),
        ["RL"] = string.sub(s,3,4),
        ["LL"] = string.sub(s,5,6),
        ["LU"] = string.sub(s,7,8),
    }
    table.insert(all_shape_names,s)
    if(debug_mode == true) then

        n = n + 1
        if(n > 2000) then
            log(serpent.block(s))
            break --debug
        end

    end
end

data:extend(
{
    {
        type = "item",
        name = "shapez-lab",
        icon = "__shapeztorio__/graphics/icons/lab.png",
        subgroup = "shapez",
        order = "b",
        inventory_move_sound = item_sounds.lab_inventory_move,
        pick_sound = item_sounds.lab_inventory_pickup,
        drop_sound = item_sounds.lab_inventory_move,
        place_result = "shapez-lab",
        stack_size = 10,
        weight = 20*kg,
        localised_name = {"","Shapez lab"},
    },
    {
        type = "lab",
        name = "shapez-lab",
        localised_name = {"","Shapez lab"},
        icon = "__shapeztorio__/graphics/icons/lab.png",
        flags = {"placeable-player", "player-creation"},
        minable = {mining_time = 0.2, result = "shapez-lab"},
        fast_replaceable_group = "lab",
        max_health = 150,
        corpse = "lab-remnants",
        dying_explosion = "lab-explosion",
        collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        damaged_trigger_effect = hit_effects.entity(),
        on_animation =
        {
            layers =
            {
            {
                filename = "__shapeztorio__/graphics/entity/lab-entity.png",
                width = 194,
                height = 174,
                frame_count = 33,
                line_length = 11,
                animation_speed = 1 / 3,
                shift = util.by_pixel(0, 1.5),
                scale = 0.5
            },
            {
                filename = "__base__/graphics/entity/lab/lab-integration.png",
                width = 242,
                height = 162,
                line_length = 1,
                repeat_count = 33,
                animation_speed = 1 / 3,
                shift = util.by_pixel(0, 15.5),
                scale = 0.5
            },
            {
                filename = "__shapeztorio__/graphics/entity/lab-light.png",
                blend_mode = "additive",
                draw_as_light = true,
                width = 216,
                height = 194,
                frame_count = 33,
                line_length = 11,
                animation_speed = 1 / 3,
                shift = util.by_pixel(0, 0),
                scale = 0.5
            },
            {
                filename = "__base__/graphics/entity/lab/lab-shadow.png",
                width = 242,
                height = 136,
                line_length = 1,
                repeat_count = 33,
                animation_speed = 1 / 3,
                shift = util.by_pixel(13, 11),
                scale = 0.5,
                draw_as_shadow = true
            }
            }
        },
        off_animation =
        {
            layers =
            {
            {
                filename = "__shapeztorio__/graphics/entity/lab-entity.png",
                width = 194,
                height = 174,
                shift = util.by_pixel(0, 1.5),
                scale = 0.5
            },
            {
                filename = "__base__/graphics/entity/lab/lab-integration.png",
                width = 242,
                height = 162,
                shift = util.by_pixel(0, 15.5),
                scale = 0.5
            },
            {
                filename = "__base__/graphics/entity/lab/lab-shadow.png",
                width = 242,
                height = 136,
                shift = util.by_pixel(13, 11),
                draw_as_shadow = true,
                scale = 0.5
            }
            }
        },
        working_sound =
        {
            sound =
            {
            filename = "__base__/sound/lab.ogg",
            volume = 0.7,
            modifiers = {volume_multiplier("main-menu", 2.2), volume_multiplier("tips-and-tricks", 0.8)},
            audible_distance_modifier = 0.7,
            },
            fade_in_ticks = 4,
            fade_out_ticks = 20
        },
        impact_category = "glass",
        open_sound = sounds.lab_open,
        close_sound = sounds.lab_close,
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input"
        },
        energy_usage = "90kW",
        researching_speed = 1,
        inputs = all_shape_names, --easiest way to do it without iterating through everything again in data updates
        module_slots = 2,
        icons_positioning =
        {
            {inventory_index = defines.inventory.lab_modules, shift = {0, 0.9}},
            {inventory_index = defines.inventory.lab_input, shift = {0, 0}, max_icons_per_row = 4, separation_multiplier = 1/1.1}
        },
    },
}    
)
all_shape_names = nil --free up memory

--Don't like a quad for loop. No access to the coroutine function 
--quad for loop is crashing the engine at the prototype stage.
--We have to be much more clever about how we build the layer array at runtime 
--Well we don't have access to storage module at prototype stage. 
--Since the list is always the same between playthroughs, I can in theory save it to a mod setting, and read the string back.
--[[
for a,RU in pairs(quarter_code) do
    for b,RL in pairs(quarter_code) do
        for c,LL in pairs(quarter_code) do
            for d,LU in pairs(quarter_code) do
                local layer = {}
                layer["RU"] = RU
                layer["RL"] = RL
                layer["LL"] = LL
                layer["LU"] = LU
                --table.insert(shape_layer,layer)
                local key = RU .. RL .. LL .. LU
                shape_layer[key] = layer
            end
        end
    end
end
--]] 

--log(serpent.block(shape_layer))



function convert_layer_to_string(in_layer)
    return (in_layer.RU or "--") .. (in_layer.RL or "--").. (in_layer.LL or "--") .. (in_layer.LU or "--")
end

function convert_string_to_layer(in_string)
    local out = {}
    out[in_string] = 
    {
        ["RU"] = string.sub(in_string,1,2),
        ["RL"] = string.sub(in_string,3,4),
        ["LL"] = string.sub(in_string,5,6),
        ["LU"] = string.sub(in_string,7,8),
    }
    return out
end

function convert_layer_array_to_string(in_layer_array)
    local out = ""
    for k,v in pairs(in_layer_array) do
        out = out .. ":" .. convert_layer_to_string(v)
    end
    return out
end

function convert_quarter_to_icon(in_quarter_code,in_orientation, in_scale)
    local out = {}
    local valid = false
    local shape = string.sub(in_quarter_code,1,1)
    local color = string.sub(in_quarter_code,2,2)
    if(shape == "-" or shape == "--") then
        return out, valid
    end
    local prefix = "__shapeztorio__/graphics/icons/"
    local shape_word = code_word_table[shape]
    return
    {
        icon = prefix .. shape_word .. "/" .. shape_word .. "_" .. in_orientation .. ".png",
        scale = in_scale,
        tint = tint_code[color],
        shift = shift_table[in_orientation],
        icon_size = 32,
    }, true

end

function make_layer_icon_array(in_layer,in_scale)
    local out = {}
    local layer_table = 
    {
       ["RU"] =  in_layer.RU,
       ["RL"] =  in_layer.RL,
       ["LL"] = in_layer.LL,
       ["LU"] =  in_layer.LU,
    }

    for k,v in pairs(layer_table) do
        index, valid = convert_quarter_to_icon(v,k,in_scale)
        if (valid == true and index ~= {}) then
            table.insert(out,index)
        end
    end

    return out
end

function make_icon_array_from_n_layers(in_layer_array)
    local out = {}
    local n = 1 
    for k,v in in_layer_array do
        scale = (5 - n ) * 0.3
        table.insert(out,make_layer_icon_array(v,scale))
        n = n + 1
    end
    return out
end


function rotate_single_layer_CW(in_layer)
    local out = 
    {
        ["RU"] = in_layer.LU,
        ["RL"] = in_layer.RU,
        ["LL"] = in_layer.RL,
        ["LU"] = in_layer.LL,
    }
    return out
end

function rotate_single_layer_CCW(in_layer)
    local out = 
    {
        ["RU"] = in_layer.RL,
        ["RL"] = in_layer.LL,
        ["LL"] = in_layer.LU,
        ["LU"] = in_layer.RU,
    }
    return out
end

function rotate_single_layer_180(in_layer)
    local out = 
    {
        ["RU"] = in_layer.LL,
        ["RL"] = in_layer.LU,
        ["LL"] = in_layer.RU,
        ["LU"] = in_layer.RL,
    }
    return out
end

function half_destroy_RU_RL(in_layer)
    local out = 
    {
        ["RU"] = "--",
        ["RL"] = "--",
        ["LL"] = in_layer.LL,
        ["LU"] = in_layer.LU,
    }
    return out
end

function half_destroy_LU_LL(in_layer)
    local out = 
    {
        ["RU"] = in_layer.RU,
        ["RL"] = in_layer.RL,
        ["LL"] = "--",
        ["LU"] = "--",
    }
    return out
end

function paint(in_layer, in_paint_code)
    local out = 
    {
        ["RU"] = string.sub(in_layer.RU,1,1) .. in_paint_code,
        ["RL"] = string.sub(in_layer.RL,1,1) .. in_paint_code,
        ["LL"] = string.sub(in_layer.LL,1,1) .. in_paint_code,
        ["LU"] = string.sub(in_layer.LU,1,1) .. in_paint_code,
    }
    return out
end

function is_blank(in_layer,in_key)
    if(in_layer == nil or in_key == nil) then
        return true
    end
    return in_layer[in_key] == "--" or in_layer[in_key] == "-"
end

function pseudo_stack_quarter_layer(in_source_layer,in_target_layer,q)
    local out = in_target_layer[q]
    --Drop the source shape ontop of the target.
    --if any of the targets slots are blank - then it becomes the source. Otherwise it stays as the target
    if(is_blank(in_target_layer,q) and is_blank(in_source_layer,q) == false ) then
        out = in_source_layer[q]
    end


    return out
end

--Doesn't create new layers, but fills in blank slots on shape quarters. Target quarter is discarded if it would make a new layer
function pseudo_stack(in_source_layer,in_target_layer)
    local out = 
    {
        ["RU"] = pseudo_stack_quarter_layer(in_source_layer,in_target_layer,"RU"),
        ["RL"] = pseudo_stack_quarter_layer(in_source_layer,in_target_layer,"RL"),
        ["LL"] = pseudo_stack_quarter_layer(in_source_layer,in_target_layer,"LL"),
        ["LU"] = pseudo_stack_quarter_layer(in_source_layer,in_target_layer,"LU"),
    }


    return out
end

function split_single_layer_RL(in_layer)
    local half_a =
    {
        ["RU"] = in_layer.RU,
        ["RL"] = in_layer.RL,
        ["LL"] = "--",
        ["LU"] = "--",
    }

    local half_b = 
    {
        ["RU"] = "--",
        ["RL"] = "--",
        ["LL"] = in_layer.LL,
        ["LU"] = in_layer.LU,
    }
    return half_a,half_b
end

function layer_to_recipe_ingredient_or_result_table(in_layer)
    local out = 
    {
        {   
            type = "item",
            name = convert_layer_to_string(in_layer),
            amount = 1,
        },
    }
    return out
end

function layer_to_recipe(in_layer,in_shape_recipe_parameters,in_function)
    
    local result_layer = in_function(in_layer)
    local ingredient_table = layer_to_recipe_ingredient_or_result_table(in_layer)
    local result_table = layer_to_recipe_ingredient_or_result_table(result_layer)
    local in_name_ingredient_string = convert_layer_to_string(in_layer)
    local in_name_result_string = convert_layer_to_string(result_layer)
    local recipe_name_prefix = in_name_ingredient_string .. "_to_" .. in_name_result_string .. "_"
    local out_recipe = 
    {
        type = "recipe",
        allow_productivity = false,
        allow_quality = false,
        hide_from_player_crafting = true,
        hidden = false, 
        --icons = data.raw["tool"][convert_layer_to_string(result_layer)].icons,
        enabled = true,
        category = in_shape_recipe_parameters.category,
        energy_required = in_shape_recipe_parameters.energy_required or 1,
        subgroup = "shapez",
        main_product = in_name_result_string,
        ingredients = ingredient_table,
        results = result_table,
        name = recipe_name_prefix .. in_shape_recipe_parameters.name,
        localised_name = {"",in_name_ingredient_string .. in_shape_recipe_parameters.name},
        auto_recycle = false,
    }

    return out_recipe
end

function paint_layer_to_recipe(in_layer,in_shape_recipe_parameters,in_paint_code)
    
    --log(serpent.block("in_layer="))
    --log(serpent.block(in_layer))
    local result_layer = paint(in_layer,in_paint_code)
    --log(serpent.block("result_layer="))
    --log(serpent.block(result_layer))
    local ingredient_table = 
    {
        {   
            ["type"] = "item",
            ["name"] = convert_layer_to_string(in_layer),
            ["amount"] = 1,
        },
        {
            ["type"] = "fluid", 
            ["name"] = ("paint-" .. in_paint_code),
            ["amount"] = 30,
        }
    }
    local result_table = layer_to_recipe_ingredient_or_result_table(result_layer)
    local in_name_ingredient_string = convert_layer_to_string(in_layer)
    local in_name_result_string = convert_layer_to_string(result_layer)

    local recipe_name_prefix = in_name_ingredient_string .. "_to_" .. in_name_result_string .. "_"
    local out_recipe = 
    {
        type = "recipe",
        allow_productivity = false,
        hide_from_player_crafting = true,
        hidden = false, 
        order = in_paint_code .. in_name_ingredient_string,
        --icons = data.raw["tool"][convert_layer_to_string(result_layer)].icons,
        enabled = true,
        category = "paint",
        energy_required = in_shape_recipe_parameters.energy_required or 1,
        subgroup = "shapez",
        main_product = in_name_result_string,
        ingredients = ingredient_table,
        results = result_table,
        name = recipe_name_prefix .. in_shape_recipe_parameters.name,
        localised_name = {"",in_name_ingredient_string .. in_shape_recipe_parameters.name},
        auto_recycle = false,
    }

    return out_recipe
end

function layer_to_split_recipe(in_layer,in_shape_recipe_parameters)
    
    local result_layer_a,result_layer_b = split_single_layer_RL(in_layer)
    local ingredient_table = layer_to_recipe_ingredient_or_result_table(in_layer)
    local in_name_ingredient_string = convert_layer_to_string(in_layer)
    local recipe_name_prefix = in_name_ingredient_string .. "_split_RL"
    local out_recipe = 
    {
        type = "recipe",
        allow_productivity = false,
        allow_quality = true,
        hide_from_player_crafting = true,
        hidden = false, --hide like recycling recipes
        --icons = data.raw["tool"][convert_layer_to_string(result_layer)].icons,
        enabled = true,
        category = "splitter-RL", 
        energy_required = in_shape_recipe_parameters.energy_required or 1,
        subgroup = "shapez",
        main_product = convert_layer_to_string(result_layer_a),
        ingredients = ingredient_table,
        results = 
        {
            {   
                type = "item",
                name = convert_layer_to_string(result_layer_a),
                amount = 1,
            },
            {   
                type = "item",
                name = convert_layer_to_string(result_layer_b),
                amount = 1,
            },
        },
        name = recipe_name_prefix,
        localised_name = {"",in_name_ingredient_string .. in_shape_recipe_parameters.name},
        auto_recycle = false,
    }

    return out_recipe
end
function recycle_layer(in_layer)
    
    local ingredient_table = layer_to_recipe_ingredient_or_result_table(in_layer)


    local in_name_ingredient_string = convert_layer_to_string(in_layer)
    local recipe_name = in_name_ingredient_string .. "-recycling"
    local out_recipe = 
    {
        type = "recipe",
        allow_productivity = true,
        allow_quality = true,
        hide_from_player_crafting = true,
        hidden = true, --hide like recycling recipes
        --icons = data.raw["tool"][convert_layer_to_string(result_layer)].icons,
        enabled = true,
        category = "recycling",
        energy_required =1,
        subgroup = "shapez",
        main_product = "plastic-bar",
        ingredients = ingredient_table,
        results = 
        {
            {
                type = "item",
                name = "plastic-bar",
                amount = 1,
                probability = 0.25
            }
        },
        name = recipe_name,
        localised_name = {"",in_name_ingredient_string .. " recycling"},
        auto_recycle = false,
    }

    return out_recipe
end

function rotate_stack_90_CW(in_layer)
    local rotate = rotate_single_layer_CW(in_layer)
    return pseudo_stack(rotate,in_layer)
end

function rotate_stack_180(in_layer)
    local rotate = rotate_single_layer_180(in_layer)
    return pseudo_stack(rotate,in_layer)
end

function rotate_stack_recipe(in_layer,in_shape_recipe_parameters,in_function)
    
    local result_layer = in_function(in_layer)

    local result_table = layer_to_recipe_ingredient_or_result_table(result_layer)
    local in_name_ingredient_string = convert_layer_to_string(in_layer)
    local in_name_result_string = convert_layer_to_string(result_layer)
    local recipe_name_prefix = in_name_ingredient_string .. "_to_" .. in_name_result_string .. "_"
    local out_recipe = 
    {
        type = "recipe",
        allow_productivity = false,
        hide_from_player_crafting = true,
        allow_quality = false,
        hidden = false, 
        --icons = data.raw["tool"][convert_layer_to_string(result_layer)].icons,
        enabled = true,
        category = in_shape_recipe_parameters.category,
        energy_required = in_shape_recipe_parameters.energy_required or 1,
        subgroup = "shapez",
        main_product = in_name_result_string,
        ingredients =
        {
            {   
                type = "item",
                name = convert_layer_to_string(in_layer),
                amount = 2, --this is why we have our own function
            },
        },
        results = result_table,
        name = recipe_name_prefix .. in_shape_recipe_parameters.name,
        localised_name = {"",in_name_ingredient_string .. in_shape_recipe_parameters.name},
        auto_recycle = false,
    }

    return out_recipe
end


local single_layer_shape = shape_layer --table.deepcopy(shape_layer)



for k,v in pairs(single_layer_shape) do
    local item = 
    {
        type = "tool",
        name = k,
        localised_description = {"item-description.science-pack"},
        localised_name = {"",k},
        icons = make_layer_icon_array(v,0.9),
        icon_size = 32,
        subgroup = "shapez",
        color_hint = { text = "Y" },
        order = "d",
        inventory_move_sound = item_sounds.science_inventory_move, --consider changing to plastic sound
        pick_sound = item_sounds.science_inventory_pickup,
        drop_sound = item_sounds.science_inventory_move,
        stack_size = 200,
        default_import_location = "nauvis", -- TODO
        weight = 1*kg,
        durability = 1,
        durability_description_key = "description.science-pack-remaining-amount-key",
        factoriopedia_durability_description_key = "description.factoriopedia-science-pack-remaining-amount-key",
        durability_description_value = "description.science-pack-remaining-amount-value",
        random_tint_color = item_tints.bluish_science,
        --auto_recycle = false 
    }
    


    data:extend(
    {
        item,

        layer_to_recipe(v,{category = "half-destroy-1-2", energy_required = 1,name = "half_destroy_right" },half_destroy_RU_RL),
        layer_to_recipe(v,{category = "half-destroy-3-4", energy_required = 1,name = "half_destroy_left" },half_destroy_LU_LL),
        layer_to_recipe(v,{category = "rotate-CW-90", energy_required = 1,name = "rotate_CW_90" },rotate_single_layer_CW),
        layer_to_recipe(v,{category = "rotate-CCW-90", energy_required = 1,name = "rotate_CCW_90" },rotate_single_layer_CCW),
        --TODO, swapper and splitter
        --layer_to_recipe(v,{category = "rotate-stack-180", energy_required = 1,name = "pseudo_stacker" },pseudo_stack), Need to handle seperately. Even item stacking with every other item....
        layer_to_split_recipe(v,{category = "splitter-RL", energy_required = 1,name = "splitter_RL" }),
        rotate_stack_recipe(v,{category = "rotate-stack-90-CW", energy_required = 1,name = "rotate_stack_90_CW" },rotate_stack_90_CW),
        rotate_stack_recipe(v,{category = "rotate-stack-180", energy_required = 1,name = "rotate_stack_180" },rotate_stack_180),
        recycle_layer(v)
    }
    )
end

local shape_to_paint = 
{
    ["a"] = "C",
    ["b"] = "R",
}

local in_quarter_color_code = 
{
    ["c"] = "w",
    ["d"] = "r",
    ["e"] = "g",
    ["f"] = "b",
}

local shape_paint_code = 
{
    ["c"] = "w",
    ["d"] = "r",
    ["e"] = "g",
    ["f"] = "b",
}



for i,s in pairs(shape_to_paint) do
    for j,t in pairs(in_quarter_color_code) do
        for k,p in pairs(shape_paint_code) do
            local to_paint_layer = 
            {
                ["RU"] = s .. t,
                ["RL"] = s .. t,
                ["LL"] = s .. t,
                ["LU"] = s .. t,
            }

            if(t ~= p) then

                data:extend(
                    {
                        paint_layer_to_recipe(to_paint_layer,{category = "paint", energy_required = 1,name = ("paint" .. "_" .. p) },p)
                    })
                
            end
        end
    end
end

--Recipes for CwCwCwCw and RwRwRwRw
data:extend(
{
    {
        allow_productivity = true,
        hide_from_player_crafting = true,
        hidden = false, 
        --icons = data.raw["tool"][convert_layer_to_string(result_layer)].icons,
        enabled = true,
        category = "shapez-creation",
        energy_required =1,
        subgroup = "shapez",
        main_product = "CwCwCwCw",
        ingredients = 
        {
            {
                type = "item",
                name = "plastic-bar",
                amount = 4,
            }
        },
        results = 
        {
            {
                type = "item",
                name = "CwCwCwCw",
                amount = 1,
            }
        },
        name = "CwCwCwCw",
        type = "recipe",
        localised_name = {"","CwCwCwCw"},
        auto_recycle = false
    },
    {
        allow_productivity = true,
        hide_from_player_crafting = true,
        hidden = false, 
        --icons = data.raw["tool"][convert_layer_to_string(result_layer)].icons,
        enabled = true,
        category = "shapez-creation",
        energy_required =1,
        subgroup = "shapez",
        main_product = "RwRwRwRw",
        ingredients = 
        {
            {
                type = "item",
                name = "plastic-bar",
                amount = 4,
            }
        },
        results = 
        {
            {
                type = "item",
                name = "RwRwRwRw",
                amount = 1,
            },
        },
        name = "RwRwRwRw",
        type = "recipe",
        localised_name = {"","RwRwRwRw"},
        auto_recycle = false,
    },
    --NULL ITEM easier to have this then to check all cases for an empty item.
    {
        type = "tool",
        name = "--------",
        localised_description = {"item-description.science-pack"},
        localised_name = {"","---------"},
        icons = 
        {
            {
                icon = "__base__/graphics/icons/plastic-bar.png",
                icon_size = 64,
                tint = {0,0,0},
            }
        },

        subgroup = "shapez",
        color_hint = { text = "Y" },
        order = "e",
        inventory_move_sound = item_sounds.science_inventory_move,
        pick_sound = item_sounds.science_inventory_pickup,
        drop_sound = item_sounds.science_inventory_move,
        stack_size = 200,
        default_import_location = "nauvis", -- TODO
        weight = 1*kg,
        durability = 1,
        durability_description_key = "description.science-pack-remaining-amount-key",
        factoriopedia_durability_description_key = "description.factoriopedia-science-pack-remaining-amount-key",
        durability_description_value = "description.science-pack-remaining-amount-value",
        random_tint_color = item_tints.bluish_science,
        --auto_recycle = false 
    }
}
)


