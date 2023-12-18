require "Items/ItemPicker"
require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"

local function OnPostDistributionMerge()

	table.remove(ProceduralDistributions.list.GarageMetalwork.junk.items, 2)
	table.remove(ProceduralDistributions.list.GarageMetalwork.junk.items, 1)

	--Duplicate loot chances (or remove loot)
	local function CopyLoot(old_name, new_name, mult)
		local cache = {}
		local function patch(t)
			for i=#t,1,-1 do
				if t[i] == old_name then
					local num = (t[i+1] or 0.01) * mult;
					if old_name == new_name then
						t[i+1] = num; --overwrite
					elseif new_name == 0 then
						table.remove(t,i)
						table.remove(t,i)
					else
						table.insert(t, new_name)
						table.insert(t, num)
					end
				end
			end
		end
		mult = mult or 1;
		for room,r in ipairs(SuburbsDistributions) do
			for container,c in pairs(r) do
				if c.items and not cache[c.items] then
					cache[c.items] = true
					patch(c.items)
				end
			end
		end
		for proc,p in pairs(ProceduralDistributions.list) do
			if p.items and not cache[p.items] then
				cache[p.items] = true
				patch(p.items)
			end
			if p.junk and not cache[p.junk] then
				cache[p.junk] = true
				patch(p.junk)
			end
		end
		for vehicle,p in pairs(VehicleDistributions) do
			if p.items and not cache[p.items] then
				cache[p.items] = true
				patch(p.items)
			end
			if p.junk and not cache[p.junk] then
				cache[p.junk] = true
				patch(p.junk)
			end
		end
	end

	local yeetitem = {"Base.AssaultRifleBayonet", "Base.SKSSpiker", "Base.SKSSpikerBayonet", "Base.M16Bayonet", "Base.Tec9", "Base.9mmClip20", "GWP.Wakizashi", "GWP.KatanaGoldRed", "CanteensAndBottles.JerryCanTank", "CanteensAndBottles.JumboJerryCanTank", "Extinguisher", "Hat_DustMask", "Glasses_SafetyGoggles", "PropaneTank", "BlowTorch", "TW.LargePropaneTank", "Base.AmmoCanLoot", "Base.AmmoCanSmallLoot", "VHS", "VHS_Retail", "VHS_Home", "Base.PropaneTank", "TW.HugePropaneTank", "Disc", "Disc_Retail", "TW.WorkshopMag4", "PetrolCan", "Base.PetrolCan", "TW.Chain", "TW.File", "TW.LargeBolt", "TW.BoxLargeBolts", "RMWeapons.RikuMag1", "RMWeapons.RikuMag2", "RMWeapons.Thawk", "RMWeapons.BrushAxe", "RMWeapons.waraxe", "RMWeapons.warhammer", "RMWeapons.LastHope", "RMWeapons.Dadao", "RMWeapons.TrenchShovel", "RMWeapons.Crimson1Sword", "RMWeapons.SpikedClub1", "RMWeapons.bladebat", "RMWeapons.bassax", "RMWeapons.hellokittyax", "RMWeapons.dexkama", "RMWeapons.steinbeer", "RMWeapons.spinecrusher", "RMWeapons.FlangedMace", "RMWeapons.VikingWarhammer", "RMWeapons.MagicMace", "RMWeapons.CrimsonLance", "RMWeapons.MedSword", "RMWeapons.glaive", "RMWeapons.MorningStar", "Trelai.BaseballBatTrelai"}
	local yeetno = #yeetitem
		
	local skillbooks1 = {"BookTrapping1", "BookFishing1", "BookCarpentry1", "BookMechanic1", "BookFirstAid1", "BookBlacksmith1", "BookMetalWelding1", "BookElectrician1", "BookCooking1", "BookFarming1", "BookForaging1", "BookTailoring1"}
	local skillbooks2 = {"BookTrapping2", "BookFishing2", "BookCarpentry2", "BookMechanic2", "BookFirstAid2", "BookBlacksmith2", "BookMetalWelding2", "BookElectrician2", "BookCooking2", "BookFarming2", "BookForaging2", "BookTailoring2"}
	local skillbooks3 = {"BookTrapping3", "BookFishing3", "BookCarpentry3", "BookMechanic3", "BookFirstAid3", "BookBlacksmith3", "BookMetalWelding3", "BookElectrician3", "BookCooking3", "BookFarming3", "BookForaging3", "BookTailoring3"}
	local skillbooks4 = {"BookTrapping4", "BookFishing4", "BookCarpentry4", "BookMechanic4", "BookFirstAid4", "BookBlacksmith4", "BookMetalWelding4", "BookElectrician4", "BookCooking4", "BookFarming4", "BookForaging4", "BookTailoring4"}	
	local skillbooks5 = {"BookTrapping5", "BookFishing5", "BookCarpentry5", "BookMechanic5", "BookFirstAid5", "BookBlacksmith5", "BookMetalWelding5", "BookElectrician5", "BookCooking5", "BookFarming5", "BookForaging5", "BookTailoring5"}	
	
	local s1 = #skillbooks1
	local s2 = #skillbooks2
	local s3 = #skillbooks3
	local s4 = #skillbooks4
	local s5 = #skillbooks5
	
	for i=1,s1 do
		CopyLoot(skillbooks1[i],skillbooks1[i], 0.1)
	end

	for i=1,s2 do
		CopyLoot(skillbooks2[i],skillbooks2[i], 0.08)
	end	
	
	for i=1,s3 do
		CopyLoot(skillbooks3[i],skillbooks3[i], 0.06)
	end	

	for i=1,s4 do
		CopyLoot(skillbooks4[i],skillbooks4[i], 0.04)
	end	

	for i=1,s5 do
		CopyLoot(skillbooks5[i],skillbooks5[i], 0.02)
	end	
	
	CopyLoot("Book", "Book", 0.125)
	
	CopyLoot("WeaponCache", "WeaponCache", 5)
	CopyLoot("MechanicCache", "MechanicCache", 3)
	CopyLoot("MetalworkCache", "MetalworkCache", 3)
	CopyLoot("FarmerCache", "FarmerCache", 3)
	
	for i=1,yeetno do
		CopyLoot(yeetitem[i], 0)
	end
	
end

Events.OnPostDistributionMerge.Add(OnPostDistributionMerge)