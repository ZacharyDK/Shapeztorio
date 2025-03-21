require ("util")
require ("__base__.prototypes.entity.pipecovers")
require ("circuit-connector-sprites")
require ("__base__.prototypes.entity.assemblerpipes")


--Control lua handles p lab rejecting items of normal, "", nil, or common quality
local simulations = require("__base__.prototypes.factoriopedia-simulations")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

local smoke_animations = require("__base__.prototypes.entity.smoke-animations")
local smoke_fast_animation = smoke_animations.trivial_smoke_fast
local trivial_smoke = smoke_animations.trivial_smoke

function make_4way_animation_from_spritesheet(animation)
    local function make_animation_layer(idx, anim)
      local frame_count = anim.frame_count or 1
      local start_frame = frame_count * idx
      local x = 0
      local y = 0
      if anim.line_length then
        y = anim.height * math.floor(start_frame / (anim.line_length or 1))
        if anim.line_length > frame_count then
          error("single line must not contain animations for multiple directions when line_lenght is specified: " .. anim.filename)
        end
      else
        x = idx * anim.width
        
      end
      return
      {
        filename = anim.filename,
        priority = anim.priority or "high",
        flags = anim.flags,
        x = x,
        y = y,
        width = anim.width,
        height = anim.height,
        frame_count = anim.frame_count,
        line_length = anim.line_length,
        repeat_count = anim.repeat_count,
        shift = anim.shift,
        draw_as_shadow = anim.draw_as_shadow,
        draw_as_glow = anim.draw_as_glow,
        draw_as_light = anim.draw_as_light,
        apply_runtime_tint = anim.apply_runtime_tint,
        tint_as_overlay = anim.tint_as_overlay or false,
        animation_speed = anim.animation_speed,
        scale = anim.scale or 1,
        tint = anim.tint,
        blend_mode = anim.blend_mode,
        load_in_minimal_mode = anim.load_in_minimal_mode,
        premul_alpha = anim.premul_alpha,
        generate_sdf = anim.generate_sdf
      }
    end
  
    local function make_animation(idx)
      if animation.layers then
        local tab = { layers = {} }
        for k,v in ipairs(animation.layers) do
          table.insert(tab.layers, make_animation_layer(idx, v))
        end
        return tab
      else
        return make_animation_layer(idx, animation)
      end
    end
  
    return
    {
      north = make_animation(0),
      east = make_animation(1),
      south = make_animation(2),
      west = make_animation(3)
    }
end

function boiler_reflection()
  return
  {
    pictures =
    {
      filename = "__base__/graphics/entity/boiler/boiler-reflection.png",
      priority = "extra-high",
      width = 28,
      height = 32,
      shift = util.by_pixel(5, 30),
      variation_count = 4,
      scale = 5
    },
    rotate = false,
    orientation_to_variation = true
  }
end


function create_tinted_assembler(assemble_params)
  return 
  {
    type = "furnace", --want it be furnace but this is for debug
    name = assemble_params.name,
    source_inventory_size = 1,
    result_inventory_size = 2,
    icons = 
    {
      {
        icon = "__shapeztorio__/graphics/icons/shapez-machine-white.png",
        icon_size = 64,
        tint = assemble_params.tint,
      }
    },
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = assemble_params.name},
    max_health = 300,
    corpse = "assembling-machine-1-remnants",
    dying_explosion = "assembling-machine-1-explosion",
    icon_draw_specification = {shift = {0, -0.3}},
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    fast_replaceable_group = "assembling-machine",
    circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions["assembling-machine"],
    alert_icon_shift = util.by_pixel(0, -12),
    localised_name = {"",assemble_params.localised_name}, --filename = "__shapeztorio__/graphics/entity/shapez/assembling-machine-white.png", --tint = assemble_params.tint,
    graphics_set =
    {
      animation =
      {
        layers =
        {
          {
            filename = "__shapeztorio__/graphics/entity/shapez/assembling-machine-white.png",
            priority = "high",
            width = 214,
            height = 218,
            frame_count = 32,
            line_length = 8,
            shift = util.by_pixel(0, 4),
            scale = 0.5,
            tint = assemble_params.tint,
          },
          {
            filename = "__base__/graphics/entity/assembling-machine-2/assembling-machine-2-shadow.png",
            priority = "high",
            width = 196,
            height = 163,
            frame_count = 32,
            line_length = 8,
            draw_as_shadow = true,
            shift = util.by_pixel(12, 4.75),
            scale = 0.5
          }
        }
      },
    },
    crafting_categories = assemble_params.category,
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 4 }
    },
    energy_usage = "100kW",
    module_slots = 1,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    allowed_effects = {"speed", "consumption", "pollution"},
    effect_receiver = {uses_module_effects = true, uses_beacon_effects = true, uses_surface_effects = true},
    impact_category = "metal",
    working_sound =
    {
      sound = {filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.5, audible_distance_modifier = 0.5},
      fade_in_ticks = 4,
      fade_out_ticks = 20
    }
  }

end

data:extend(
{
    {
        type = "assembling-machine",
        name = "painter-plant",
        source_inventory_size = 1,
        result_inventory_size = 1,
        icon = "__shapeztorio__/graphics/icons/chemical-plant-red.png",
        flags = {"placeable-neutral","placeable-player", "player-creation"},
        minable = {mining_time = 0.1, result = "painter-plant"}, --TODO add recipe and items
        localised_name = {"","Painter plant"},
        fast_replaceable_group = "chemical-plant",
        max_health = 300,
        corpse = "chemical-plant-remnants",
        dying_explosion = "chemical-plant-explosion",
        icon_draw_specification = {shift = {0, -0.3}},
        circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
        circuit_connector = circuit_connector_definitions["chemical-plant"],
        collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        damaged_trigger_effect = hit_effects.entity(),
        drawing_box_vertical_extension = 0.4,
        module_slots = 3,
        allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
    
        graphics_set =
        {
          animation = make_4way_animation_from_spritesheet({ layers =
          {
            {
              filename = "__shapeztorio__/graphics/entity/chemical-plant-red.png",
              width = 220,
              height = 292,
              frame_count = 24,
              line_length = 12,
              shift = util.by_pixel(0.5, -9),
              scale = 0.5
            },
            {
              filename = "__base__/graphics/entity/chemical-plant/chemical-plant-shadow.png",
              width = 312,
              height = 222,
              repeat_count = 24,
              shift = util.by_pixel(27, 6),
              draw_as_shadow = true,
              scale = 0.5
            }
          }}),
          working_visualisations =
          {
            {
              apply_recipe_tint = "primary",
              north_animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-liquid-north.png",
                frame_count = 24,
                line_length = 6,
                width = 66,
                height = 44,
                shift = util.by_pixel(23, 15),
                scale = 0.5
              },
              east_animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-liquid-east.png",
                frame_count = 24,
                line_length = 6,
                width = 70,
                height = 36,
                shift = util.by_pixel(0, 22),
                scale = 0.5
              },
              south_animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-liquid-south.png",
                frame_count = 24,
                line_length = 6,
                width = 66,
                height = 42,
                shift = util.by_pixel(0, 17),
                scale = 0.5
              },
              west_animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-liquid-west.png",
                frame_count = 24,
                line_length = 6,
                width = 74,
                height = 36,
                shift = util.by_pixel(-10, 13),
                scale = 0.5
              }
            },
            {
              apply_recipe_tint = "secondary",
              north_animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-foam-north.png",
                frame_count = 24,
                line_length = 6,
                width = 62,
                height = 42,
                shift = util.by_pixel(24, 15),
                scale = 0.5
              },
              east_animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-foam-east.png",
                frame_count = 24,
                line_length = 6,
                width = 68,
                height = 36,
                shift = util.by_pixel(0, 22),
                scale = 0.5
              },
              south_animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-foam-south.png",
                frame_count = 24,
                line_length = 6,
                width = 60,
                height = 40,
                shift = util.by_pixel(1, 17),
                scale = 0.5
              },
              west_animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-foam-west.png",
                frame_count = 24,
                line_length = 6,
                width = 68,
                height = 28,
                shift = util.by_pixel(-9, 15),
                scale = 0.5
              }
            },
            {
              apply_recipe_tint = "tertiary",
              fadeout = true,
              constant_speed = true,
              north_position = util.by_pixel_hr(-30, -161),
              east_position = util.by_pixel_hr(29, -150),
              south_position = util.by_pixel_hr(12, -134),
              west_position = util.by_pixel_hr(-32, -130),
              render_layer = "wires",
              animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-smoke-outer.png",
                frame_count = 47,
                line_length = 16,
                width = 90,
                height = 188,
                animation_speed = 0.5,
                shift = util.by_pixel(-2, -40),
                scale = 0.5
              }
            },
            {
              apply_recipe_tint = "quaternary",
              fadeout = true,
              constant_speed = true,
              north_position = util.by_pixel_hr(-30, -161),
              east_position = util.by_pixel_hr(29, -150),
              south_position = util.by_pixel_hr(12, -134),
              west_position = util.by_pixel_hr(-32, -130),
              render_layer = "wires",
              animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-smoke-inner.png",
                frame_count = 47,
                line_length = 16,
                width = 40,
                height = 84,
                animation_speed = 0.5,
                shift = util.by_pixel(0, -14),
                scale = 0.5
              }
            }
          }
        },
        impact_category = "metal-large",
        open_sound = {filename = "__base__/sound/open-close/fluid-open.ogg", volume = 0.55},
        close_sound = {filename = "__base__/sound/open-close/fluid-close.ogg", volume = 0.54},
        working_sound =
        {
          sound = sound_variations("__base__/sound/chemical-plant", 3, 0.5),
          fade_in_ticks = 4,
          fade_out_ticks = 20
        },
        crafting_speed = 1,
        energy_source =
        {
          type = "electric",
          usage_priority = "secondary-input",
          emissions_per_minute = { pollution = 4 }
        },
        energy_usage = "210kW",
        crafting_categories = {"paint"},
        fluid_boxes =
        {
          {
            production_type = "input",
            pipe_covers = pipecoverspictures(),
            volume = 1000,
            pipe_connections =
            {
              {
                flow_direction="input",
                direction = defines.direction.north,
                position = {-1, -1}
              }
            }
          },
          {
            production_type = "input",
            pipe_covers = pipecoverspictures(),
            volume = 1000,
            pipe_connections =
            {
              {
                flow_direction="input",
                direction = defines.direction.north,
                position = {1, -1}
              }
            }
          },
          {
            production_type = "output",
            pipe_covers = pipecoverspictures(),
            volume = 100,
            pipe_connections =
            {
              {
                flow_direction = "output",
                direction = defines.direction.south,
                position = {-1, 1}
              }
            }
          },
          {
            production_type = "output",
            pipe_covers = pipecoverspictures(),
            volume = 100,
            pipe_connections =
            {
              {
                flow_direction = "output",
                direction = defines.direction.south,
                position = {1, 1}
              }
            }
          }
        },
        water_reflection =
        {
          pictures =
          {
            filename = "__base__/graphics/entity/chemical-plant/chemical-plant-reflection.png",
            priority = "extra-high",
            width = 28,
            height = 36,
            shift = util.by_pixel(5, 60),
            variation_count = 4,
            scale = 5
          },
          rotate = false,
          orientation_to_variation = true
        }
    },
    {
        type = "assembling-machine",
        name = "shapez-plant",
        icon = "__shapeztorio__/graphics/icons/chemical-plant-white.png",
        flags = {"placeable-neutral","placeable-player", "player-creation"},
        minable = {mining_time = 0.1, result = "shapez-plant"},
        fast_replaceable_group = "chemical-plant",
        max_health = 300,
        corpse = "chemical-plant-remnants",
        dying_explosion = "chemical-plant-explosion",
        icon_draw_specification = {shift = {0, -0.3}},
        circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
        circuit_connector = circuit_connector_definitions["chemical-plant"],
        collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        damaged_trigger_effect = hit_effects.entity(),
        drawing_box_vertical_extension = 0.4,
        module_slots = 3,
        allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
    
        graphics_set =
        {
          animation = make_4way_animation_from_spritesheet({ layers =
          {
            {
              filename = "__shapeztorio__/graphics/entity/chemical-plant-white.png",
              width = 220,
              height = 292,
              frame_count = 24,
              line_length = 12,
              shift = util.by_pixel(0.5, -9),
              scale = 0.5
            },
            {
              filename = "__base__/graphics/entity/chemical-plant/chemical-plant-shadow.png",
              width = 312,
              height = 222,
              repeat_count = 24,
              shift = util.by_pixel(27, 6),
              draw_as_shadow = true,
              scale = 0.5
            }
          }}),
          working_visualisations =
          {
            {
              apply_recipe_tint = "primary",
              north_animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-liquid-north.png",
                frame_count = 24,
                line_length = 6,
                width = 66,
                height = 44,
                shift = util.by_pixel(23, 15),
                scale = 0.5
              },
              east_animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-liquid-east.png",
                frame_count = 24,
                line_length = 6,
                width = 70,
                height = 36,
                shift = util.by_pixel(0, 22),
                scale = 0.5
              },
              south_animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-liquid-south.png",
                frame_count = 24,
                line_length = 6,
                width = 66,
                height = 42,
                shift = util.by_pixel(0, 17),
                scale = 0.5
              },
              west_animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-liquid-west.png",
                frame_count = 24,
                line_length = 6,
                width = 74,
                height = 36,
                shift = util.by_pixel(-10, 13),
                scale = 0.5
              }
            },
            {
              apply_recipe_tint = "secondary",
              north_animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-foam-north.png",
                frame_count = 24,
                line_length = 6,
                width = 62,
                height = 42,
                shift = util.by_pixel(24, 15),
                scale = 0.5
              },
              east_animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-foam-east.png",
                frame_count = 24,
                line_length = 6,
                width = 68,
                height = 36,
                shift = util.by_pixel(0, 22),
                scale = 0.5
              },
              south_animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-foam-south.png",
                frame_count = 24,
                line_length = 6,
                width = 60,
                height = 40,
                shift = util.by_pixel(1, 17),
                scale = 0.5
              },
              west_animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-foam-west.png",
                frame_count = 24,
                line_length = 6,
                width = 68,
                height = 28,
                shift = util.by_pixel(-9, 15),
                scale = 0.5
              }
            },
            {
              apply_recipe_tint = "tertiary",
              fadeout = true,
              constant_speed = true,
              north_position = util.by_pixel_hr(-30, -161),
              east_position = util.by_pixel_hr(29, -150),
              south_position = util.by_pixel_hr(12, -134),
              west_position = util.by_pixel_hr(-32, -130),
              render_layer = "wires",
              animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-smoke-outer.png",
                frame_count = 47,
                line_length = 16,
                width = 90,
                height = 188,
                animation_speed = 0.5,
                shift = util.by_pixel(-2, -40),
                scale = 0.5
              }
            },
            {
              apply_recipe_tint = "quaternary",
              fadeout = true,
              constant_speed = true,
              north_position = util.by_pixel_hr(-30, -161),
              east_position = util.by_pixel_hr(29, -150),
              south_position = util.by_pixel_hr(12, -134),
              west_position = util.by_pixel_hr(-32, -130),
              render_layer = "wires",
              animation =
              {
                filename = "__base__/graphics/entity/chemical-plant/chemical-plant-smoke-inner.png",
                frame_count = 47,
                line_length = 16,
                width = 40,
                height = 84,
                animation_speed = 0.5,
                shift = util.by_pixel(0, -14),
                scale = 0.5
              }
            }
          }
        },
        impact_category = "metal-large",
        open_sound = {filename = "__base__/sound/open-close/fluid-open.ogg", volume = 0.55},
        close_sound = {filename = "__base__/sound/open-close/fluid-close.ogg", volume = 0.54},
        working_sound =
        {
          sound = sound_variations("__base__/sound/chemical-plant", 3, 0.5),
          fade_in_ticks = 4,
          fade_out_ticks = 20
        },
        crafting_speed = 1,
        energy_source =
        {
          type = "electric",
          usage_priority = "secondary-input",
          emissions_per_minute = { pollution = 4 }
        },
        energy_usage = "210kW",
        crafting_categories = {"shapez-creation"},
        fluid_boxes =
        {
          {
            production_type = "input",
            pipe_covers = pipecoverspictures(),
            volume = 1000,
            pipe_connections =
            {
              {
                flow_direction="input",
                direction = defines.direction.north,
                position = {-1, -1}
              }
            }
          },
          {
            production_type = "input",
            pipe_covers = pipecoverspictures(),
            volume = 1000,
            pipe_connections =
            {
              {
                flow_direction="input",
                direction = defines.direction.north,
                position = {1, -1}
              }
            }
          },
          {
            production_type = "output",
            pipe_covers = pipecoverspictures(),
            volume = 100,
            pipe_connections =
            {
              {
                flow_direction = "output",
                direction = defines.direction.south,
                position = {-1, 1}
              }
            }
          },
          {
            production_type = "output",
            pipe_covers = pipecoverspictures(),
            volume = 100,
            pipe_connections =
            {
              {
                flow_direction = "output",
                direction = defines.direction.south,
                position = {1, 1}
              }
            }
          }
        },
        water_reflection =
        {
          pictures =
          {
            filename = "__base__/graphics/entity/chemical-plant/chemical-plant-reflection.png",
            priority = "extra-high",
            width = 28,
            height = 36,
            shift = util.by_pixel(5, 60),
            variation_count = 4,
            scale = 5
          },
          rotate = false,
          orientation_to_variation = true
        }
    },
    create_tinted_assembler({name = "rotator-CW",category = {"rotate-CW-90"},localised_name = "Rotator CW", tint = {200,200,0}}),  --{r = 200, g = 200, b =0}, --rgb(200, 200, 0)
    create_tinted_assembler({name = "rotator-CCW",category = {"rotate-CCW-90"},localised_name = "Rotator CCW", tint = {175,159,55}}), --{r = 200, g = 200, b =0}, --rgb(175, 159, 55)
    create_tinted_assembler({name = "half-destroyer-L",category = {"half-destroy-3-4"},localised_name = "Left half destroyer", tint = {200,100,0}}),  --{r = 200, g = 200, b =0}, --rgb(200, 100, 0)
    create_tinted_assembler({name = "half-destroyer-R",category = {"half-destroy-1-2"},localised_name = "Right half destroyer", tint = {146,73,9}}), --rgb(146, 73, 9)
    create_tinted_assembler({name = "shapez-splitter",category = {"splitter-RL"},localised_name = "Shapez splitter", tint = {146,9,132}}), --rgb(146, 9, 132)
    create_tinted_assembler({name = "rotate-stack-180",category = {"rotate-stack-180"},localised_name = "Rotate 180 + stack", tint = {200,50,50}}), --rgb(247, 7, 7)
    create_tinted_assembler({name = "rotate-stack-90-CW",category = {"rotate-stack-90-CW"},localised_name = "Rotate 90CW + stack", tint = {63,247,7}}), --rgb(63, 247, 7)
    {
      type = "container",
      name = "swap-box",
      icons = 
      {
        {
          icon = "__shapeztorio__/graphics/icons/shapez-machine-white.png",
          icon_size = 64,
        }
      },
      flags = {"placeable-neutral", "player-creation"},
      minable = {mining_time = 0.1, result = "swap-box"},
      max_health = 100,
      collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
      selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
      damaged_trigger_effect = hit_effects.entity(),
      fast_replaceable_group = "assembling-machine",
      corpse = "assembling-machine-1-remnants",
      dying_explosion = "assembling-machine-1-explosion",
      inventory_size = 4,
      open_sound = { filename = "__base__/sound/wooden-chest-open.ogg", volume = 0.6 },
      close_sound = { filename = "__base__/sound/wooden-chest-close.ogg", volume = 0.6 },
      impact_category = "metal",
      localised_name = {"","Swap box"},
      icon_draw_specification = {shift = {0, -0.3}},
      picture =
      {
        layers =
        {
          {
            filename = "__shapeztorio__/graphics/entity/shapez/assembling-machine-white.png",
            priority = "high",
            width = 214,
            height = 218,
            frame_count = 32,
            line_length = 8,
            shift = util.by_pixel(0, 4),
            scale = 0.5,
          },
          {
            filename = "__base__/graphics/entity/assembling-machine-2/assembling-machine-2-shadow.png",
            priority = "high",
            width = 196,
            height = 163,
            frame_count = 32,
            line_length = 8,
            draw_as_shadow = true,
            shift = util.by_pixel(12, 4.75),
            scale = 0.5
          }
        }
      },
      circuit_connector = circuit_connector_definitions["chest"],
      circuit_wire_max_distance = default_circuit_wire_max_distance,
      surface_conditions =
      {
        {
          property = "gravity",
          min = 0.1
        }
      },
    },

}
)

