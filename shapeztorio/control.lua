
local last_tick = -1 --Last time we queried ice-box
--local iceable_array_length = table.getn(iceable_products) Need to use table_size() 

local swap_cache = {}
local initialized_cache = false


local function calculate_stack_count(item_count,stack_size)
  local out = 1
  if(item_count <= stack_size) then
    out = 1
  else 
    local complete_stacks = math.floor(item_count / stack_size) -- // is 5.3 only feature
    out = complete_stacks
    if(item_count % stack_size ~= 0) then --if we have any remainder, we have another incomplete stacks
      out = complete_stacks + 1
    end
  end
  return out
end

local function find_all_entity_of_name(input_name)
  local out_entity_table = {}
  local surface_array = game.surfaces
    for k,q in pairs(surface_array) do --names of surfaces are in keys
        local current_surface = game.get_surface(k)
        --pressure-lab

        local entity_array = current_surface.find_entities_filtered{name = input_name} --input_name
        if(table_size(entity_array) == 0) then
          out_entity_table[current_surface.name] = {}
          goto continue_loop
        end
        local entity_map = {} --need a map that I can easily find and remove entities from
        for i,e in pairs(entity_array ) do 
          --log("e=")
          --log(serpent.block(e))
          entity_map[e.name..e.gps_tag] = e
        end 
        out_entity_table[current_surface.name] = entity_map
        ::continue_loop::
    end
  
  --log(serpent.block(out_entity_table))

  

  return out_entity_table
end 


---@param entity LuaEntity
local function add_to_cache(entity,cache)
  if(entity.valid == true) then
    local surface_name = entity.surface.name
    local key = entity.name .. entity.gps_tag
    --log(serpent.block(entity.name))
    --log(serpent.block(entity.gps_tag))
    --log(serpent.block(entity.surface.name))
    if(cache[surface_name] == nil) then cache[surface_name] = {} end
    cache[surface_name][key] = entity
  end
end

---@param entity LuaEntity
local function remove_from_cache(entity,cache)
  if(entity.valid == true) then
    local surface_name = entity.surface.name
    local key = entity.name .. entity.gps_tag
    if(cache[surface_name] ~= nil) then
      cache[surface_name][key] = nil
    end
  end
end

local function is_char_shape(in_char) --C","R","S","D"
  if(in_char == "C" or in_char == "R" or in_char == "S" or in_char == "D" or in_char == "-") then
    return true
  end
  return false
end

local function is_char_color(in_char) --{"u","r","g","b","c","y","m","w"} -- don't have shapez of all colors. only red,blue,green,white
  if(in_char == "u" or in_char == "r" or in_char == "g" or in_char == "b" or in_char == "w" or in_char == "-") then
    return true
  end
  return false
end

local function is_item_a_shape(item_name_as_string)
  
  if(#item_name_as_string < 8 or item_name_as_string == "") then 
    return false
  end

  local out = true
  for i = 1,8 do
    local c = string.sub(item_name_as_string,i,i)
    local b = is_char_shape(c) or is_char_color(c)
    if(b ~= true) then
      out = false
      break
    end
  end

  return out

end




local function swap_string_halves(in_a,in_b)  
  if(#in_a < 2 or #in_b < 2) then
    return in_b,in_a
  end
  --not bothering with the odd case, all shape layers have an even number of strings
  local in_a_first = string.sub(in_a,1,#in_a/2)
  local in_a_last = string.sub(in_a,#in_a/2 + 1,#in_a)

  local in_b_first = string.sub(in_b,1,#in_b/2)
  local in_b_last = string.sub(in_b,#in_b/2 + 1,#in_b)

  --log(serpent.block("in_a="))
  --log(serpent.block(in_a))
  --log(serpent.block("in_b="))
  --log(serpent.block(in_b))

  --log(serpent.block("in_a_first="))
  --log(serpent.block(in_a_first))
  --log(serpent.block("in_a_last="))
  --log(serpent.block(in_a_last))
  --log(serpent.block("in_b_first="))
  --log(serpent.block(in_b_first))
  --log(serpent.block("in_b_last="))
  --log(serpent.block(in_b_last))

  return (in_a_first ..in_b_last ),(in_b_first .. in_a_last)

end


--[[
for inventory inswap box
if index 1 and 2 are shapez. And slots 3 and 4 are empty
  add items to 3,4 slot
  remove items in 1,2 slot
--]]


local function process_swap_box(swap_boxes)
  local nil_ent = nil
  ---@cast nil_ent LuaEntity
  --log("PROCESS BEGIN")
  for i,v in pairs(swap_boxes) do
    --log("i="..i)
    --log("v=")
    --log(serpent.block(v))

    if(v == nil or v.valid == false or v == nil_ent ) then --If we messed up with the cache somehow.
      swap_cache = find_all_entity_of_name("swap-box")
      return
      --goto continue_loop
    end

    if(v.valid == false or v == nil ) then --or v.status ~= defines.entity_status_diode.red
      log(serpent.block("Box invalid!"))
      goto continue_loop 

    end
    local inventory = v.get_inventory(defines.inventory.chest)
    
    if(inventory == nil) then
      goto continue_loop 
    end

    --If we have items in slots 3 or 4, cannot process inventory
    if (inventory[1] == nil  or inventory[2] == nil) then
      log(serpent.block("No items in slots one and two"))
      goto continue_loop 
    elseif(inventory[1].valid_for_read == false or inventory[2].valid_for_read == false) then
      log(serpent.block("No items in slots one and two"))
      goto continue_loop 
    elseif(inventory[3] ~= nil) then
      if( inventory[3].valid_for_read == true ) then --valid for read will be false if the slot is blank - which we want
        goto continue_loop 
      end
    elseif(inventory[4] ~= nil) then
      if(inventory[4].valid_for_read == true) then
        goto continue_loop 
      end
    end

    local n = inventory[1].name
    local m = inventory[2].name
    local n_qual = inventory[1].quality
    local m_qual = inventory[1].quality
    log(serpent.block("--------------"))
    --log(serpent.block("n="))
    --log(serpent.block(n))
    --log(serpent.block("m="))
    --log(serpent.block(m))

    if(is_item_a_shape(n) and is_item_a_shape(m)) then
      local result_a,result_b = swap_string_halves(n,m)
      --log(serpent.block("result_a="))
      --log(serpent.block(result_a))
      --log(serpent.block("result_b="))
      --log(serpent.block(result_b))
      if(result_a == "" or result_b == "") then
        goto continue_loop
      end 

      inventory.insert({name=result_a, count=1,quality = n_qual })
      inventory.insert({name=result_b, count=1,quality = m_qual})
      inventory.remove({name = n, count = 1})
      inventory.remove({name = m, count = 1})
      log(serpent.block("Swap complete!"))
    end
  
    ::continue_loop::

  end
end



script.on_nth_tick(10, --closest we get to begin play
  function(NthTickEventData)
    if(initialized_cache == false) then
      swap_cache = find_all_entity_of_name("swap-box")
      initialized_cache = true
    end
    
  end
)


--Can't have multiple of the same event. New event will override the old one. This isn't what I want.

--Thanks StephenB
for _, eventType in pairs({
	defines.events.on_built_entity,
	defines.events.on_robot_built_entity,
}) do
	script.on_event(eventType,
		function(event)
			---@cast event EventData.on_built_entity | EventData.on_player_mined_entity | EventData.on_robot_built_entity | EventData.on_robot_mined_entity | EventData.on_entity_died
			local entity = event.entity
			---@cast entity LuaEntity -- Guaranteed to be LuaEntity when read.
      if (entity.name == "swap-box") then
        add_to_cache(entity,swap_cache)
      end
      

		end)
end

for _, eventType in pairs({
	defines.events.on_player_mined_entity,
	defines.events.on_robot_mined_entity,
	defines.events.on_entity_died,
}) do
	script.on_event(eventType,
		function(event)
			---@cast event EventData.on_built_entity | EventData.on_player_mined_entity | EventData.on_robot_built_entity | EventData.on_robot_mined_entity | EventData.on_entity_died
			local entity = event.entity
			---@cast entity LuaEntity -- Guaranteed to be LuaEntity when read.

      if (entity.name == "swap-box") then
        remove_from_cache(entity,swap_cache)
      end


		end)
		--{{ filter = "name", name = "pressure-lab" }})
end





script.on_nth_tick(45,
  function(NthTickEventData)
    for s,box_array in pairs(swap_cache) do
      process_swap_box(box_array)
    end
  end
)


--]]