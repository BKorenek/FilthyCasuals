require "Items/ItemPicker"
require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"

-- add items to ProceduralDistributions
local function preDistributionMergeSD5()
----------------------------------------------------------------------------------------
	--[[local propaneSpawn = {
		--CampingStoreGear = 0.01,
		--FireStorageTools = 0.01,
		GigamartTools = 0.025,
		--GardenStoreTools = 0.025,
		--ToolStoreTools = 0.05,
		--GarageMechanics = 0.025,
		GasStorageMechanics = 0.15,
		--StoreShelfMechanics = 0.05,
		--CrateMechanics = 0.025,
		CrateMetalwork = 0.05,
		Chemistry = 0.05,
		CratePropane = 1,
		--CrateRandomJunk = 0.05,
		GarageMetalwork = 0.025,
		MetalShopTools = 0.25,
		ToolStoreMetalwork = 0.05
	}
	
	for distribution, chance in pairs(propaneSpawn) do
		table.insert(ProceduralDistributions.list[distribution].items, "PropaneTank")
		table.insert(ProceduralDistributions.list[distribution].items, chance)
		table.insert(ProceduralDistributions.list[distribution].items, "TW.LargePropaneTank")
		table.insert(ProceduralDistributions.list[distribution].items, chance)
	end]]--
----------------------------------------------------------------------------------------	
	local weaponCacheData = {
		CampingStoreGear = 0.01,
		FireStorageTools = 0.01,
		GigamartTools = 0.01,
		PawnShopGunsSpecial = 0.02,
		MeleeWeapons = 0.04,
		JanitorTools = 0.001,
		BurglarTools = 0.001,
		PoliceStorageGuns = 0.02,
		WardrobeWoman = 0.0001,
		PawnShopKnives = 0.01,
		GardenStoreTools = 0.001,
		BarCounterWeapon = 0.001,
		BedroomDresser = 0.0001,
		ToolStoreTools = 0.01,
		GunStoreAmmunition = 0.01,
		WardrobeMan = 0.001,
		GunStoreDisplayCase = 0.02,
		PoliceStorageAmmunition = 0.01,
		ArmyStorageGuns = 0.01,
		GunStoreShelf = 0.02
	}

	for distribution, chance in pairs(weaponCacheData) do
		table.insert(ProceduralDistributions.list[distribution].items, "WeaponCache")
		table.insert(ProceduralDistributions.list[distribution].items, chance)
	end
----------------------------------------------------------------------------------------	
	local MechMWCacheData = {
		CampingStoreGear = 0.001,
		FireStorageTools = 0.001,
		GigamartTools = 0.001,
		JanitorTools = 0.001,
		BurglarTools = 0.001,
		GardenStoreTools = 0.0001,
		ToolStoreTools = 0.001,
		GarageMechanics = 0.0001,
		GasStorageMechanics = 0.0001,
		StoreShelfMechanics = 0.001,
		CrateMechanics = 0.001,
		GarageMetalwork = 0.001,
		ToolStoreMetalwork = 0.001,
		CrateMetalwork = 0.001
	}

	for distribution, chance in pairs(MechMWCacheData) do
		table.insert(ProceduralDistributions.list[distribution].items, "MechanicCache")
		table.insert(ProceduralDistributions.list[distribution].items, chance)
		table.insert(ProceduralDistributions.list[distribution].items, "MetalworkCache")
		table.insert(ProceduralDistributions.list[distribution].items, chance)
	end
----------------------------------------------------------------------------------------
--[[local FarmerCacheData = {
		GigamartTools = 0.0001,
		GardenStoreTools = 0.001,
		ToolStoreTools = 0.0001,
		GarageMechanics = 0.001,
		GasStorageMechanics = 0.001,
		StoreShelfMechanics = 0.001,
		CrateMechanics = 0.001,
		GarageMetalwork = 0.001,
		ToolStoreMetalwork = 0.001,
		CrateMetalwork = 0.001,
		CrateFarming = 0.001,
		GardenStoreMisc = 0.001,
		GigamartFarming = 0.001,
		ToolStoreFarming = 0.001
	}

	for distribution, chance in pairs(FarmerCacheData) do
		table.insert(ProceduralDistributions.list[distribution].items, "FarmerCache")
		table.insert(ProceduralDistributions.list[distribution].items, chance)
	end]]--
----------------------------------------------------------------------------------------
	local AmmoCacheData = {
		PoliceStorageAmmunition = 0.01,
		GunStoreAmmunition = 0.01,
		ArmyStorageAmmunition = 0.01,
		GunStoreCounter = 0.001,
		GunStoreDisplayCase = 0.001,
		GunStoreShelf= 0.001,
		PoliceStorageGuns = 0.001,
		ArmyStorageGuns = 0.001
	}
	
	for distribution, chance in pairs(AmmoCacheData) do
		table.insert(ProceduralDistributions.list[distribution].items, "AmmoCache")
		table.insert(ProceduralDistributions.list[distribution].items, chance)
	end
----------------------------------------------------------------------------------------	
	local medData = {
		StoreShelfMedical = 0.001,
		MedicalStorageDrugs = 0.01,
		MedicalClinicDrugs = 0.01,
		ArmyStorageMedical = 0.01,
		MedicalStorageTools = 0.01,
		MedicalClinicTools = 0.01,
		MedicalClinicOutfit = 0.01,
		MedicalStorageOutfit = 0.01,
		HospitalLockers = 0.02
	}
	
	for distribution, chance in pairs(medData) do
		table.insert(ProceduralDistributions.list[distribution].items, "MedicalCache")
		table.insert(ProceduralDistributions.list[distribution].items, chance)
	end
----------------------------------------------------------------------------------------		
end
	
Events.OnPreDistributionMerge.Add(preDistributionMergeSD5)


local function OnPostDistributionMergeSD5()
	
	--create local item index table
	local itemIndex = {}

	--index ProceduralDistributions.container.items and container.junk.items
	for containerName, containerData in pairs(ProceduralDistributions.list) do

	  if containerData.items then
		for i = 1, #containerData.items, 2 do  -- Step by 2 to get item name and weight
		  local itemName = containerData.items[i]
		  itemIndex[itemName] = itemIndex[itemName] or {}
		  table.insert(itemIndex[itemName], { container = containerName, type = "items" })
		end
	  end


	  if containerData.junk and containerData.junk.items then
		for i = 1, #containerData.junk.items, 2 do -- Step by 2 to get item name and weight
		  local itemName = containerData.junk.items[i]
		  itemIndex[itemName] = itemIndex[itemName] or {}
		  table.insert(itemIndex[itemName], { container = containerName, type = "junk" })
		end
	  end
	end


	--[[

	-- Print the entire itemIndex
	for itemName, containerList in pairs(itemIndex) do
	  print("Item:", itemName)
	  for _, containerInfo in ipairs(containerList) do
		print("  - Container:", containerInfo.container, "(Type:", containerInfo.type, ")")
	  end
	end

	-- List of specific items to search for
	local itemsToSearch = {
	  "BookTrapping1", "Book", "PropaneTank"
	}

	for _, itemName in ipairs(itemsToSearch) do
	  if itemIndex[itemName] then
		print("Item:", itemName)
		for _, containerInfo in ipairs(itemIndex[itemName]) do
		  print("  - Container:", containerInfo.container, "(Type:", containerInfo.type, ")")
		end
		print()
	  else
		print("Item '" .. itemName .. "' not found in any containers.")
	  end
	end
	]]--


	-- function to modify item weight
	function modifyItemWeight(itemName, multiplier)
	  if itemIndex[itemName] then
		local processedContainers = {}  -- Track processed containers for this item

		for _, containerInfo in ipairs(itemIndex[itemName]) do
		  local containerName = containerInfo.container
		  if not processedContainers[containerName] then  -- Process each container only once
			local containerData = ProceduralDistributions.list[containerName]
			local itemCount = 0

			if containerInfo.type == "items" then
			  for i = 1, #containerData.items, 2 do
				if containerData.items[i] == itemName then
				  itemCount = itemCount + 1
				  --print("Item:", itemName, "found in", containerName, "(items) - Entry", itemCount)
				  --print("  - Original weight:", containerData.items[i+1])
				  containerData.items[i+1] = containerData.items[i+1] * multiplier
				  --print("  - Modified weight:", containerData.items[i+1])
				end 
			  end
			elseif containerInfo.type == "junk" then
			  for i = 1, #containerData.junk.items, 2 do
				if containerData.junk.items[i] == itemName then
				  itemCount = itemCount + 1
				  --print("Item:", itemName, "found in", containerName, "(junk) - Entry", itemCount)
				  --print("  - Original weight:", containerData.junk.items[i+1])
				  containerData.junk.items[i+1] = containerData.junk.items[i+1] * multiplier
				  --print("  - Modified weight:", containerData.junk.items[i+1])
				end
			  end
			end

			processedContainers[containerName] = true  -- Mark container as processed
		  end
		end
	  end
	end

	--item list for removal (setting to 0 chance on distribution)
	local yeetItems = {"RMWeapons.NulBlade", "RMWeapons.bassax", "RMWeapons.crabspear", "RMWeapons.themauler", "RMWeapons.warhammer40k", "RMWeapons.MizutsuneSword", "RMWeapons.Nikabo", "RMWeapons.firelink", "RMWeapons.mace1", "RMWeapons.Falx", "RMWeapons.kindness", "RMWeapons.Crimson1Sword", "RMWeapons.MorningStar", "RMWeapons.BrushAxe", "RMWeapons.sword40k", "RMWeapons.LastHope", "RMWeapons.sawbat1", "RMWeapons.spikedleg", "RMWeapons.TrenchShovel", "RMWeapons.CrimsonLance", "RMWeapons.warhammer", "RMWeapons.MightCleaver", "RMWeapons.Thawk", "RMWeapons.bonkhammer", "RMWeapons.club1", "RMWeapons.PiroCraftKnife", "RMWeapons.steinbeer"}

	--skill books
	local skillbooks1 = {"BookTrapping1", "BookFishing1", "BookCarpentry1", "BookMechanic1", "BookFirstAid1", "BookBlacksmith1", "BookMetalWelding1", "BookElectrician1", "BookCooking1", "BookFarming1", "BookForaging1", "BookTailoring1"}
	local skillbooks2 = {"BookTrapping2", "BookFishing2", "BookCarpentry2", "BookMechanic2", "BookFirstAid2", "BookBlacksmith2", "BookMetalWelding2", "BookElectrician2", "BookCooking2", "BookFarming2", "BookForaging2", "BookTailoring2"}
	local skillbooks3 = {"BookTrapping3", "BookFishing3", "BookCarpentry3", "BookMechanic3", "BookFirstAid3", "BookBlacksmith3", "BookMetalWelding3", "BookElectrician3", "BookCooking3", "BookFarming3", "BookForaging3", "BookTailoring3"}
	local skillbooks4 = {"BookTrapping4", "BookFishing4", "BookCarpentry4", "BookMechanic4", "BookFirstAid4", "BookBlacksmith4", "BookMetalWelding4", "BookElectrician4", "BookCooking4", "BookFarming4", "BookForaging4", "BookTailoring4"}	
	local skillbooks5 = {"BookTrapping5", "BookFishing5", "BookCarpentry5", "BookMechanic5", "BookFirstAid5", "BookBlacksmith5", "BookMetalWelding5", "BookElectrician5", "BookCooking5", "BookFarming5", "BookForaging5", "BookTailoring5"}	
		
	--print("--------------------------------------------")
	--print("SD5 Modification to Loot Distribution Start.")
	--print("--------------------------------------------")
	
	--set items to zero to effectively yeet off table
	for _, itemName in ipairs(yeetItems) do
	  modifyItemWeight(itemName, 0)
	end

	--modification to skillbooks vol 1
	for i=1,#skillbooks1 do
		modifyItemWeight(skillbooks1[i], 0.1)
	end

	--modification to skillbooks vol 2
	for i=1,#skillbooks2 do
		modifyItemWeight(skillbooks2[i], 0.08)
	end	

	--modification to skillbooks vol 3
	for i=1,#skillbooks3 do
		modifyItemWeight(skillbooks3[i], 0.06)
	end	

	--modification to skillbooks vol 4
	for i=1,#skillbooks4 do
		modifyItemWeight(skillbooks4[i], 0.04)
	end	

	--modification to skillbooks vol 5
	for i=1,#skillbooks5 do
		modifyItemWeight(skillbooks5[i], 0.02)
	end	

	--modification to Books, otherwise it will outbloat skillbooks
	modifyItemWeight("Book", 0.125)
	--modifier to Caches. because I'm lazy
	modifyItemWeight("WeaponCache", 1.5)
	--modifyItemWeight("AmmoCache", 2.0)
	modifyItemWeight("MetalworkCache", 0.5)
	--modifyItemWeight("MechanicCache", 1.0)
	--modifyItemWeight("MedicalCache", 2.0)
	--modifier to Propane Tanks for rarity
	modifyItemWeight("PropaneTank", 0.0)
	--modifier to Workshop Large Propane Tank for rarity
	modifyItemWeight("TW.LargePropaneTank", 0)
	
	table.remove(ProceduralDistributions.list.GarageMetalwork.junk.items, 1)
	table.remove(ProceduralDistributions.list.GarageMetalwork.junk.items, 1)

	--print("-----------------------------------------------")
	--print("SD5 Modification to Loot Distribution Complete.")
	--print("-----------------------------------------------")
	
end

Events.OnPostDistributionMerge.Add(OnPostDistributionMergeSD5)
