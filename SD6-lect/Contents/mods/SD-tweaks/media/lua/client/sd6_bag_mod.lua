local SD6_containers = {}
SD6_containers.bag_mod = ISPanel:derive("SD6_containers.bag_mod")

--************************************************************************--
--** ISPanel:initialise
--************************************************************************--

function SD6_containers.bag_mod:initialise()
	ISPanel.initialise(self);
end

function SD6_containers.bag_mod:noBackground()
	self.background = false;
end

function SD6_containers.bag_mod:close()
	self:setVisible(false);
    self:removeFromUIManager()
end

local bag
local modcap = false
local modredux = false
local args = {}

function SD6_containers.bag_mod:modal(button, player)
	if button.internal ~= "OK" then return end
	
	local player = getSpecificPlayer(0)
	
	local iFT = bag:getFullType()
	local itemID = bag:getID()
	
	args.player_name = getOnlineUsername()
	args.item = iFT
	args.itemID = itemID

	
	if modcap then
		local capacity = button.parent.entry:getText()
		bag:setCapacity(tonumber(capacity))
		args.modBagCap = capacity
		modcap = false
		bag = nil
		sendClientCommand(player, 'sdLogger', 'modBagCap', args);
		return
	end
		
	if modredux then
		local redux = button.parent.entry:getText()
		bag:setWeightReduction(tonumber(redux))
		args.modBagRedux = redux
		modredux = false
		bag = nil
		sendClientCommand(player, 'sdLogger', 'modBagRedux', args);
		return
	end

end

function SD6_containers.bag_mod:capacity()
	modcap = true
	local modal = ISTextBox:new(0, 0, 280, 180, "Set Bag Capacity", "25", nil, SD6_containers.bag_mod.modal, nil, 1,1,self)
    modal:initialise()
    modal:addToUIManager()
end

function SD6_containers.bag_mod:weight()
	modredux = true
    local modal = ISTextBox:new(0, 0, 280, 180, "Set Bag Reduction", "70", nil, SD6_containers.bag_mod.modal, nil, 1,1,self)
    modal:initialise()
    modal:addToUIManager()
end

function SD6_containers.bag_mod:modal1(button, player)
	if button.internal ~= "YES" then return end
	
	local player = getSpecificPlayer(0)
	local playerInv = player:getInventory()
	
	local iFT = bag:getFullType()
	local itemID = bag:getID()
	
	args.player_name = getOnlineUsername()
	args.item = iFT
	args.itemID = itemID
	
	if modcap1 then
		modcap1 = false
		local bagCapacityTicket = playerInv:getItemsFromFullType("Base.bagCapacityTicket", false)
		if not bagCapacityTicket then
			self.character:Say("I cannot do that.")
			return
		end
		
		local bagCap = bag:getCapacity()
		local newBag = InventoryItemFactory.CreateItem(iFT)
		local scriptCap = newBag:getCapacity()
		
		if bagCap >= math.min(35, math.floor(scriptCap*1.5)) then
			player:Say("This bag is already at maximum carry capacity.")
			return
		else
			bagCap = bagCap + 1
		end
		bag:setCapacity(bagCap)
		args.modBagCap = bagCap
		
		bag = nil
		sendClientCommand(player, 'sdLogger', 'modBagCap', args);
		
		local playerInv = player:getInventory()
		playerInv:RemoveOneOf("Base.bagCapacityTicket")
		return
	end
		
	if modredux1 then
		modredux1 = false
		local bagWeightTicket = playerInv:getItemsFromFullType("Base.bagWeightTicket", false)
		if not bagWeightTicket then
			player:Say("I cannot do that.")
			return
		end
		
		local bagWeight = bag:getWeightReduction()
		if bagWeight >= 95 then
			player:Say("This bag is already at maximum weight reduction.")
			return
		else
			bagWeight = bagWeight + 1
		end
		bag:setWeightReduction(bagWeight)
		args.modBagRedux = bagWeight
		
		bag = nil
		sendClientCommand(player, 'sdLogger', 'modBagRedux', args);
		playerInv:RemoveOneOf("Base.bagWeightTicket")
		return
	end
end

function SD6_containers.bag_mod:capacity1()
	modcap1 = true
	local player = 0
	local width = 350;
	local x = getPlayerScreenLeft(player) + (getPlayerScreenWidth(player) - width) / 2
	local height = 120;
	local y = getPlayerScreenTop(player) + (getPlayerScreenHeight(player) - height) / 2
	local modal1 = ISModalDialog:new(x,y, width, height, "Add 1 to bag capacity?", true, self, SD6_containers.bag_mod.modal1, player);
	modal1:initialise()
	modal1:addToUIManager()
end

function SD6_containers.bag_mod:weight1()
	modredux1 = true
	local player = 0
	local width = 350;
	local x = getPlayerScreenLeft(player) + (getPlayerScreenWidth(player) - width) / 2
	local height = 120;
	local y = getPlayerScreenTop(player) + (getPlayerScreenHeight(player) - height) / 2
	local modal1 = ISModalDialog:new(x,y, width, height, "Add 1% to bag weight reducton?", true, self, SD6_containers.bag_mod.modal1, player);
	modal1:initialise()
	modal1:addToUIManager()
end
--************************************************************************--
--** ISPanel:render
--************************************************************************--

function SD6_containers.bag_mod:prerender()

end

function SD6_containers.bag_mod:onMouseUp(x, y)
    if not self.moveWithMouse then return; end
    if not self:getIsVisible() then
        return;
    end

    self.moving = false;
    if ISMouseDrag.tabPanel then
        ISMouseDrag.tabPanel:onMouseUp(x,y);
    end

    ISMouseDrag.dragView = nil;
end

function SD6_containers.bag_mod:onMouseUpOutside(x, y)
    if not self.moveWithMouse then return; end
    if not self:getIsVisible() then
        return;
    end

    self.moving = false;
    ISMouseDrag.dragView = nil;
end

function SD6_containers.bag_mod:onMouseDown(x, y)
    if not self.moveWithMouse then return true; end
    if not self:getIsVisible() then
        return;
    end
    if not self:isMouseOver() then
        return -- this happens with setCapture(true)
    end
    
    self.downX = x;
    self.downY = y;
    self.moving = true;
    self:bringToTop();
end

function SD6_containers.bag_mod:onMouseMoveOutside(dx, dy)
    if not self.moveWithMouse then return; end
    self.mouseOver = false;

    if self.moving then
        if self.parent then
            self.parent:setX(self.parent.x + dx);
            self.parent:setY(self.parent.y + dy);
        else
            self:setX(self.x + dx);
            self:setY(self.y + dy);
            self:bringToTop();
        end
    end
end

function SD6_containers.bag_mod:onMouseMove(dx, dy)
    if not self.moveWithMouse then return; end
    self.mouseOver = true;

    if self.moving then
        if self.parent then
            self.parent:setX(self.parent.x + dx);
            self.parent:setY(self.parent.y + dy);
        else
            self:setX(self.x + dx);
            self:setY(self.y + dy);
            self:bringToTop();
        end
        --ISMouseDrag.dragView = self;
    end
end

--************************************************************************--
--** ISPanel:new
--************************************************************************--
function SD6_containers.bag_mod:new (x, y, width, height,object,character)
	local o = {}
	--o.data = {}
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
	o.x = x;
	o.y = y;
	o.background = true;
	o.backgroundColor = {r=0, g=0, b=0, a=0.5};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.width = width;
	o.height = height;
	o.anchorLeft = false;
	o.anchorRight = false;
	o.anchorTop = false;
	o.anchorBottom = false;
    o.moveWithMouse = true;
    o.stoneobject = object;
    o.character = character;
   return o
end

local function SD6_bag_modification(player, context, items) -- # When an inventory item context menu is opened
	if isAdmin() or isDebugEnabled() then 
		local playerObj = getSpecificPlayer(player)
		items = ISInventoryPane.getActualItems(items)
		for i=1, #items do
			item = items[i]
			if instanceof(item, "InventoryContainer") then
				bag = item
				context:addOption("Change Bag Capacity", item, SD6_containers.bag_mod.capacity, playerObj)
				context:addOption("Change Weight Reduction", item, SD6_containers.bag_mod.weight, playerObj)
				break
			end
		end
	end
end

Events.OnPreFillInventoryObjectContextMenu.Add(SD6_bag_modification)

local function SD6_bag_modification_ticket(player, context, items) -- # When an inventory item context menu is opened
	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()
	local bagCapacityTicket = playerInv:getItemsFromFullType("Base.bagCapacityTicket", false)
	local bagWeightTicket = playerInv:getItemsFromFullType("Base.bagWeightTicket", false)
	
	if bagCapacityTicket then
		items = ISInventoryPane.getActualItems(items)
		for i=1, #items do
			item = items[i]
			if instanceof(item, "InventoryContainer") then
				bag = item
				context:addOption("Add +1 Bag Capacity", item, SD6_containers.bag_mod.capacity1, playerObj)
				--context:addOption("Add +1% Weight Reduction", item, SD6_containers.bag_mod.weight1, playerObj)
				break
			end
		end
	end
	
	if bagWeightTicket then
		items = ISInventoryPane.getActualItems(items)
		for i=1, #items do
			item = items[i]
			if instanceof(item, "InventoryContainer") then
				bag = item
				--context:addOption("Add +1 Bag Capacity", item, SD6_containers.bag_mod.capacity1, playerObj)
				context:addOption("Add +1 Weight Reduction", item, SD6_containers.bag_mod.weight1, playerObj)
				break
			end
		end
	end
end
Events.OnPreFillInventoryObjectContextMenu.Add(SD6_bag_modification_ticket)