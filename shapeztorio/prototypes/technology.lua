local shape_code = {"C","R"}
local color_code = {"r","g","b","w"}

function pick_random_quarter()
    return (shape_code[math.random(1, #shape_code)] .. color_code[math.random(1, #color_code)])
end

function pick_random_full_shape()
    return pick_random_quarter() .. pick_random_quarter()  .. pick_random_quarter() .. pick_random_quarter()
end

function pick_quarter_shape()
    local n = math.random(1, 4)
    local a = pick_random_quarter()
    if(n == 1) then
        return a .. "--" .. "--" .. "--"
    elseif(n == 2) then
        return "--" .. a .. "--" .. "--"
    elseif(n == 3) then
        return "--" .. "--" .. a .. "--"
    elseif(n == 4) then
        return "--" .. "--" .. "--" .. a
    end

    return "--" .. "--" .. "--" .. "--" --will cause an error, null shape isn't added to the lab
end


function pick_three_quarter_shape()
    local n = math.random(1, 4)
    local a = pick_random_quarter()
    local b = pick_random_quarter()
    local c = pick_random_quarter()
    if(n == 1) then
        return a .. b .. c .. "--"
    elseif(n == 2) then
        return "--" .. a .. b .. c
    elseif(n == 3) then
        return c .. "--" .. a .. b
    elseif(n == 4) then
        return b .. c .. "--" .. a
    end

    return "--" .. "--" .. "--" .. "--" --will cause an error, null shape isn't added to the lab
end

function pick_pattern_shape()
    local a = pick_random_quarter()
    local b = pick_random_quarter()

    return a .. b .. a .. b

end

function pick_null_pattern_shape_a()
    local a = pick_random_quarter()

    return a .. "--" .. a .. "--"

end

function pick_null_pattern_shape_b()
    local b= pick_random_quarter()

    return "--" .. b .. "--" .. b 

end

function pick_half_pattern_R()
    local a = pick_random_quarter()
    local b = pick_random_quarter()

    return a .. b .. "--" .. "--"

end

function pick_half_pattern_L()
    local a = pick_random_quarter()
    local b = pick_random_quarter()

    return  "--" .. "--" .. a .. b

end


function pick_full_symmetrical_shape()
    local a = pick_random_quarter()
    return a .. a .. a .. a
end

function create_shapes_technology_ingredient_array(in_params)
    local prelim_out = {}

    if((in_params.full_shape_random or 0) >= 1) then 
        for i =1,in_params.full_shape_random do
            local a = pick_random_full_shape()
            prelim_out[a] = a --Creating a k,v table any copies will override the existing value in the array. Cannot have repeats on the out array
        end
    end

    if((in_params.quarter_shape or 0) >= 1) then 
        for i =1,in_params.quarter_shape do
            local a = pick_quarter_shape()
            prelim_out[a] = a --Creating a k,v table any copies will override the existing value in the array. Cannot have repeats on the out array
        end
    end

    if((in_params.pattern_shape or 0) >= 1) then 
        for i =1,in_params.pattern_shape do
            local a = pick_pattern_shape()
            prelim_out[a] = a --Creating a k,v table any copies will override the existing value in the array. Cannot have repeats on the out array
        end
    end

    if((in_params.symmetrical_shape or 0) >= 1) then 
        for i =1,in_params.symmetrical_shape do
            local a = pick_full_symmetrical_shape()
            prelim_out[a] = a --Creating a k,v table any copies will override the existing value in the array. Cannot have repeats on the out array
        end
    end

    if((in_params.pattern_null_a or 0) >= 1) then 
        for i =1,in_params.pattern_null_a do
            local a = pick_null_pattern_shape_a()
            prelim_out[a] = a --Creating a k,v table any copies will override the existing value in the array. Cannot have repeats on the out array
        end
    end

    if((in_params.pattern_null_b or 0) >= 1) then 
        for i =1,in_params.pattern_null_b do
            local a = pick_null_pattern_shape_b()
            prelim_out[a] = a --Creating a k,v table any copies will override the existing value in the array. Cannot have repeats on the out array
        end
    end

    if((in_params.half_shape_r or 0) >= 1) then 
        for i =1,in_params.half_shape_r do
            local a = pick_half_pattern_R()
            prelim_out[a] = a --Creating a k,v table any copies will override the existing value in the array. Cannot have repeats on the out array
        end
    end

    if((in_params.half_shape_l or 0) >= 1) then 
        for i =1,in_params.half_shape_l do
            local a = pick_half_pattern_L()
            prelim_out[a] = a --Creating a k,v table any copies will override the existing value in the array. Cannot have repeats on the out array
        end
    end

    if((in_params.three_quarter_shape or 0) >= 1) then 
        for i =1,in_params.three_quarter_shape do
            local a = pick_three_quarter_shape()
            prelim_out[a] = a --Creating a k,v table any copies will override the existing value in the array. Cannot have repeats on the out array
        end
    end

    out = {}

    for k,v in pairs(prelim_out) do
        table.insert(out,{k,1})
    end


    return out

end

data:extend(
{
    {
        type = "technology",
        name = "shapez-discovery",
        icon = "__shapeztorio__/graphics/shapezlogo.png",
        icon_size = 128,
        essential = true,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "painter-plant"
            },
            {
                type = "unlock-recipe",
                recipe = "shapez-plant"
            },
            {
                type = "unlock-recipe",
                recipe = "rotator-CW"
            },
            {
                type = "unlock-recipe",
                recipe = "rotator-CCW"
            },
            {
              type = "unlock-recipe",
              recipe = "half-destroyer-L"
            },
            {
              type = "unlock-recipe",
              recipe = "half-destroyer-R"
            },
            {
               type = "unlock-recipe",
               recipe = "shapez-splitter"
            },
            {
               type = "unlock-recipe",
               recipe = "rotate-stack-180"
            },
            {
                type = "unlock-recipe",
                recipe = "rotate-stack-90-CW"
            },
            {
                type = "unlock-recipe",
                recipe = "swap-box"
            },
            {
                type = "unlock-recipe",
                recipe = "shapez-lab"
            },
            {
                type = "unlock-recipe",
                recipe = "paint-r"
            },
            {
                type = "unlock-recipe",
                recipe = "paint-g"
            },
            {
                type = "unlock-recipe",
                recipe = "paint-b"
            },
            {
                type = "unlock-recipe",
                recipe = "paint-w"
            },
  
        },
        prerequisites = {"automation-science-pack","logistic-science-pack","chemical-science-pack"},
        unit =
        {
          count = 100,
          ingredients =
          {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
          },
          time = 60
        }
    },
    {
        type = "technology",
        name = "operator-level-1",
        icon = "__shapeztorio__/graphics/shapezlogo.png",
        icon_size = 128,
        essential = true, 
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "transcendental-RwRwRwRw",
            },
            {
                type = "unlock-recipe",
                recipe = "transcendental-CwCwCwCw",
            },
            {
                type = "give-item",
                item = "transcendental-creator"
            }
  
        },
        prerequisites = {"shapez-discovery"},
        unit =
        {
          count = 100,
          ingredients = create_shapes_technology_ingredient_array({symmetrical_shape = 2}),
          time = 60
        }
    },
    {
        type = "technology",
        name = "operator-level-2",
        icon = "__shapeztorio__/graphics/shapezlogo.png",
        icon_size = 128,
        essential = true, 
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "transcendental-RwRwRwRw",
            },
            {
                type = "unlock-recipe",
                recipe = "transcendental-CwCwCwCw",
            },
            {
                type = "give-item",
                item = "transcendental-creator"
            }
  
        },
        prerequisites = {"shapez-discovery","operator-level-1"},
        unit = 
        {
          count = 150,
          ingredients = create_shapes_technology_ingredient_array({symmetrical_shape = 1,pattern_shape = 2}),
          time = 60,
        }
    },
    {
        type = "technology",
        name = "operator-level-3",
        icon = "__shapeztorio__/graphics/shapezlogo.png",
        icon_size = 128,
        essential = true, 
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "transcendental-iron",
            },
            {
                type = "give-item",
                item = "transcendental-creator"
            }
  
        },
        prerequisites = {"shapez-discovery","operator-level-2"},
        unit =
        {
          count = 200,
          ingredients = create_shapes_technology_ingredient_array({pattern_shape = 3,full_shape_random = 1}),
          time = 60
        }
    },
    {
        type = "technology",
        name = "operator-level-4",
        icon = "__shapeztorio__/graphics/shapezlogo.png",
        icon_size = 128,
        essential = true, 
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "transcendental-copper",
            },
            {
                type = "give-item",
                item = "transcendental-creator"
            }
  
        },
        prerequisites = {"shapez-discovery","operator-level-3"},
        unit =
        {
          count = 250,
          ingredients = create_shapes_technology_ingredient_array({pattern_shape = 1,full_shape_random = 4, quarter_shape = 1}),
          time = 60
        }
    },
    {
        type = "technology",
        name = "operator-level-5",
        icon = "__shapeztorio__/graphics/shapezlogo.png",
        icon_size = 128,
        essential = true,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "transcendental-factory",
            },
            {
                type = "give-item",
                item = "transcendental-creator"
            }
  
        },
        prerequisites = {"shapez-discovery","operator-level-4"},
        unit =
        {
          count = 300,
          ingredients = create_shapes_technology_ingredient_array({pattern_shape = 1,full_shape_random = 4, quarter_shape = 1, symmetrical_shape = 1}),
          time = 60
        }
    },
    {
        type = "technology",
        name = "operator-level-6",
        icon = "__shapeztorio__/graphics/shapezlogo.png",
        icon_size = 128,
        essential = true,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "transcendental-power",
            },
            {
                type = "give-item",
                item = "transcendental-creator"
            }
  
        },
        prerequisites = {"shapez-discovery","operator-level-5"},
        unit =
        {
          count = 350,
          ingredients = create_shapes_technology_ingredient_array({pattern_shape = 2,full_shape_random = 4, quarter_shape = 1, symmetrical_shape = 1}),
          time = 60
        }
    },
    {
        type = "technology",
        name = "operator-level-7",
        icon = "__shapeztorio__/graphics/shapezlogo.png",
        icon_size = 128,
        essential = true,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "transcendental-process",
            },
            {
                type = "give-item",
                item = "transcendental-creator"
            }
  
        },
        prerequisites = {"shapez-discovery","operator-level-6"},
        unit =
        {
          count = 500,
          ingredients = create_shapes_technology_ingredient_array({pattern_shape = 2,full_shape_random = 3, quarter_shape = 1, symmetrical_shape = 1, pattern_null_a = 1}),
          time = 60
        }
    },
    {
        type = "technology",
        name = "operator-level-8",
        icon = "__shapeztorio__/graphics/shapezlogo.png",
        icon_size = 128,
        essential = true,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "transcendental-ammo",
            },
            {
                type = "give-item",
                item = "transcendental-creator"
            }
  
        },
        prerequisites = {"shapez-discovery","operator-level-7"},
        unit =
        {
          count = 600,
          ingredients = create_shapes_technology_ingredient_array({pattern_shape = 2,full_shape_random = 2, quarter_shape = 1, symmetrical_shape = 1, pattern_null_a = 1, pattern_null_b = 1, three_quarter_shape = 1}),
          time = 60
        }
    },
    {
        type = "technology",
        name = "operator-level-9",
        icon = "__shapeztorio__/graphics/shapezlogo.png",
        icon_size = 128,
        essential = true,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "transcendental-rocket",
            },
            {
                type = "give-item",
                item = "transcendental-creator"
            }
  
        },
        prerequisites = {"shapez-discovery","operator-level-8"},
        unit =
        {
          count = 700,
          ingredients = create_shapes_technology_ingredient_array({pattern_shape = 2,full_shape_random = 2, quarter_shape = 1, symmetrical_shape = 1, pattern_null_a = 1, pattern_null_b = 1, half_shape_r = 1, half_shape_l = 1, three_quarter_shape = 1}),
          time = 60
        }
    },
    {
        type = "technology",
        name = "operator-level-10",
        icon = "__shapeztorio__/graphics/shapezlogo.png",
        icon_size = 128,
        essential = true,
        effects =
        {
            {
                type = "give-item",
                item = "transcendental-creator",
                count = 2
            },
            {
                type = "change-recipe-productivity",
                recipe = "transcendental-iron",
                change = 0.15
            },
            {
                type = "change-recipe-productivity",
                recipe = "transcendental-copper",
                change = 0.15
            },
            {
                type = "change-recipe-productivity",
                recipe = "transcendental-factory",
                change = 0.15
            },
            {
                type = "change-recipe-productivity",
                recipe = "transcendental-power",
                change = 0.15
            },
            {
                type = "change-recipe-productivity",
                recipe = "transcendental-process",
                change = 0.15
            },
            {
                type = "change-recipe-productivity",
                recipe = "transcendental-CwCwCwCw",
                change = 0.15
            },
            {
                type = "change-recipe-productivity",
                recipe = "transcendental-RwRwRwRw",
                change = 0.15
            },
            {
                type = "change-recipe-productivity",
                recipe = "transcendental-ammo",
                change = 0.15
            },
            {
                type = "change-recipe-productivity",
                recipe = "transcendental-rocket",
                change = 0.15
            },
  
        },
        prerequisites = {"shapez-discovery","operator-level-9"},
        unit =
        {
          count_formula = "L*1000",
          ingredients = create_shapes_technology_ingredient_array({pattern_shape = 2,full_shape_random = 3, quarter_shape = 2, symmetrical_shape = 1, pattern_null_a = 2, pattern_null_b = 2, half_shape_r = 2, half_shape_l = 2, three_quarter_shape = 2}),
          time = 60
        },
        max_level = "infinite",
        upgrade = true,
    },
    
})