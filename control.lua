local function has_expected_freeplay_interface()
	
	if not remote.interfaces.freeplay then return false end
	
	local expected_methods = {
	  'get_created_items', 'set_created_items',
	  'get_debris_items' , 'set_debris_items' ,
	  }

	for _,method in pairs(expected_methods) do
	  if not remote.interfaces.freeplay[method] then return false end
	end
	
	return true
end

local function add_item_to_freeplay(interface_method,new_items)
  local items = remote.call('freeplay','get_'..interface_method)
  for name,count in pairs(new_items) do
    if (not items[name]) or (items[name] and items[name] < count) then
      items[name] = count
      end
    end
  remote.call('freeplay','set_'..interface_method,items)
end

function modInit()
	if has_expected_freeplay_interface() then
		remote.call("freeplay", "set_disable_crashsite", true)
		remote.call("freeplay", "set_skip_intro", true)

		local items = {
			-- resources
			{"coal", 150},
			{"iron-plate", 500},
			{"copper-plate", 300},
			{"iron-gear-wheel", 100},
			{"electronic-circuit", 100},
			{"wood", 50},
			-- belts
			{"transport-belt", 2000},
			{"underground-belt", 200},
			{"splitter", 50},
			-- pipes
			{"pipe-to-ground", 300},
			{"pipe", 300},
			-- other logistic
			{"inserter", 500},
			{"steel-chest", 20},
			{"construction-robot", 25},
			-- buildings
			{"steel-furnace", 50},
			{"assembling-machine-2", 100},
			{"electric-mining-drill", 20},
			-- electricity
			{"medium-electric-pole", 100},
			{"big-electric-pole", 50},
			{"boiler", 10},
			{"steam-engine", 20},
			{"offshore-pump", 2},
			-- equipment
			{"power-armor", 1},
			{"fusion-reactor-equipment", 1},
			{"exoskeleton-equipment", 1},
			{"personal-roboport-mk2-equipment", 1},
			{"night-vision-equipment", 1},
			{"battery-equipment", 4},
			-- weapons
			{"submachine-gun", 1},
			{"piercing-rounds-magazine", 200},
		}

		for _, v in pairs(items) do
			add_item_to_freeplay('created_items',{[v[1]]=v[2]})
			add_item_to_freeplay('debris_items' ,{[v[1]]=v[2]})
		end
	
	  else
	
		for _,p in pairs(game.connected_players) do
		  if p.admin then
			p.print("ROBOTIC START - Freeplay Interface not found")
			end
		  end
	
		log("ROBOTIC START - Freeplay Interface not found")
	
	end
end

script.on_init(modInit)
script.on_configuration_changed(modInit)
