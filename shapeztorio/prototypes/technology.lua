local shape_code = {"C","R"}
local color_code = {"r","g","b","w"}

function pick_random_quarter()
    return (shape_code[math.random(1, #shape_code)] .. color_code[math.random(1, #color_code)])
end

function pick_random_full_shape()
    return pick_random_quarter() .. pick_random_quarter()  .. pick_random_quarter() .. pick_random_quarter()
end

function pick_quarter_shape()
    local pre_quarter = math.random(0,3)
    local post_quarter = 3 - pre_quarter
    local pre_quarter_string = ""
    local post_quarter_string = ""
    local i = 1
    while i <  pre_quarter do
        pre_quarter_string = pre_quarter_string .. "--"
        i = i + 1
    end

    local j = 1
    while j <  post_quarter do
        post_quarter_string = post_quarter_string .. "--"
        j = j + 1
    end

    return pre_quarter_string .. pick_random_quarter() .. post_quarter_string

end

function pick_pattern_shape()
    local a = pick_random_quarter()
    local b = pick_random_quarter()

    return a .. b .. a .. b

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
        essential = true, --transcendental-RwRwRwRw
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
        essential = true, --transcendental-RwRwRwRw
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
        essential = true, --transcendental-RwRwRwRw
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
        essential = true, --transcendental-RwRwRwRw
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
          ingredients = create_shapes_technology_ingredient_array({pattern_shape = 1,full_shape_random = 4}),
          time = 60
        }
    },
    
})