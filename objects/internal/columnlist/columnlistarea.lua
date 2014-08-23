--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

-- columnlistarea class
local newobject = loveframes.NewObject("columnlistarea", "loveframes_object_columnlistarea", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: intializes the element
--]]---------------------------------------------------------
function newobject:initialize(parent)
	
	self.type = "columnlistarea"
	self.display = "vertical"
	self.parent = parent
	self.width = 80
	self.height = 25
	self.clickx = 0
	self.clicky = 0
	self.offsety = 0
	self.offsetx = 0
	self.extrawidth = 0
	self.extraheight = 0
	self.rowcolorindex = 1
	self.rowcolorindexmax = 2
	self.buttonscrollamount = parent.buttonscrollamount
	self.mousewheelscrollamount = parent.mousewheelscrollamount
	self.vbar = false
	self.hbar = false
	self.dtscrolling = parent.dtscrolling
	self.internal = true
	self.internals = {}
	self.children = {}

	-- apply template properties to the object
	loveframes.templates.ApplyToObject(self)
	
end

--[[---------------------------------------------------------
	- func: update(deltatime)
	- desc: updates the object
--]]---------------------------------------------------------
function newobject:update(dt)
	
	local visible = self.visible
	local alwaysupdate = self.alwaysupdate
	
	if not visible then
		if not alwaysupdate then
			return
		end
	end
	
	local cwidth, cheight = self.parent:GetColumnSize()
	local parent = self.parent
	local base = loveframes.base
	local update = self.Update
	local internals = self.internals
	local children = self.children
	
	self:CheckHover()
	
	-- move to parent if there is a parent
	if parent ~= base then
		self.x = parent.x + self.staticx
		self.y = parent.y + self.staticy
	end
	
	for k, v in ipairs(children) do
		local col = loveframes.util.BoundingBox(self.x, v.x, self.y, v.y, self.width, v.width, self.height, v.height)
		if col then
			v:update(dt)
		end
		v:SetClickBounds(self.x, self.y, self.width, self.height)
		v.y = (v.parent.y + v.staticy) - self.offsety + cheight
		v.x = (v.parent.x + v.staticx) - self.offsetx
	end
	
	for k, v in ipairs(self.internals) do
		v:update(dt)
	end
	
	if update then
		update(self, dt)
	end

end

--[[---------------------------------------------------------
	- func: draw()
	- desc: draws the object
--]]---------------------------------------------------------
function newobject:draw()

	local visible = self.visible
	
	if not visible then
		return
	end
	
	local x = self.x
	local y = self.y
	local width = self.width
	local height = self.height
	local skins = loveframes.skins.available
	local skinindex = loveframes.config["ACTIVESKIN"]
	local defaultskin = loveframes.config["DEFAULTSKIN"]
	local selfskin = self.skin
	local skin = skins[selfskin] or skins[skinindex]
	local drawfunc = skin.DrawColumnListArea or skins[defaultskin].DrawColumnListArea
	local drawoverfunc = skin.DrawOverColumnListArea or skins[defaultskin].DrawOverColumnListArea
	local draw = self.Draw
	local drawcount = loveframes.drawcount
	local internals = self.internals
	local children = self.children
	
	local swidth = width
	local sheight = height
	
	if self.vbar then
		swidth = swidth - self:GetVerticalScrollBar():GetWidth()
	end
	
	if self.hbar then
		sheight = sheight - self:GetHorizontalScrollBar():GetHeight()
	end
	
	local stencilfunc = function() love.graphics.rectangle("fill", x, y, swidth, sheight) end
	
	-- set the object's draw order
	self:SetDrawOrder()
		
	if draw then
		draw(self)
	else
		drawfunc(self)
	end
	
	love.graphics.setStencil(stencilfunc)
	
	for k, v in ipairs(children) do
		local col = loveframes.util.BoundingBox(self.x, v.x, self.y, v.y, width, v.width, height, v.height)
		if col then
			v:draw()
		end
	end
	
	love.graphics.setStencil()
	
	for k, v in ipairs(internals) do
		v:draw()
	end
	
	if not draw then
		skin.DrawOverColumnListArea(self)
	end
	
end

--[[---------------------------------------------------------
	- func: mousepressed(x, y, button)
	- desc: called when the player presses a mouse button
--]]---------------------------------------------------------
function newobject:mousepressed(x, y, button)

	local toplist = self:IsTopList()
	local scrollamount = self.mousewheelscrollamount
	local internals = self.internals
	local children = self.children
	
	if self.hover and button == "l" then
		local baseparent = self:GetBaseParent()
		if baseparent and baseparent.type == "frame" then
			baseparent:MakeTop()
		end
	end
	
	if self.bar and toplist then
		local bar = self:GetScrollBar()
		local dtscrolling = self.dtscrolling
		if dtscrolling then
			local dt = love.timer.getDelta()
			if button == "wu" then
				bar:Scroll(-scrollamount * dt)
			elseif button == "wd" then
				bar:Scroll(scrollamount * dt)
			end
		else
			if button == "wu" then
				bar:Scroll(-scrollamount)
			elseif button == "wd" then
				bar:Scroll(scrollamount)
			end
		end
	end
	
	for k, v in ipairs(internals) do
		v:mousepressed(x, y, button)
	end
	
	for k, v in ipairs(children) do
		v:mousepressed(x, y, button)
	end
	
end

--[[---------------------------------------------------------
	- func: mousereleased(x, y, button)
	- desc: called when the player releases a mouse button
--]]---------------------------------------------------------
function newobject:mousereleased(x, y, button)

	local internals = self.internals
	local children  = self.children
	
	for k, v in ipairs(internals) do
		v:mousereleased(x, y, button)
	end
	
	for k, v in ipairs(children) do
		v:mousereleased(x, y, button)
	end

end

--[[---------------------------------------------------------
	- func: CalculateSize()
	- desc: calculates the size of the object's children
--]]---------------------------------------------------------
function newobject:CalculateSize()
	
	local columnheight = self.parent.columnheight
	local numitems = #self.children
	local height = self.height
	local width = self.width
	local itemheight = columnheight
	local itemwidth = 0
	local bar = self.bar      
	local children = self.children
	
	for k, v in ipairs(children) do
		itemheight = itemheight + v.height
	end
	
	self.itemheight = itemheight
	self.itemwidth = self.parent:GetTotalColumnWidth()
	
	local hbarheight = 0
	local hbar = self:GetHorizontalScrollBar()
	if hbar then
		hbarheight = hbar.height
	end
	
	if self.itemheight > (height - hbarheight) then
		if hbar then
			self.itemheight = self.itemheight + hbarheight
		end
		self.extraheight = self.itemheight - height
		if not self.vbar then
			table.insert(self.internals, loveframes.objects["scrollbody"]:new(self, "vertical"))
			self.vbar = true
			self:GetVerticalScrollBar().autoscroll = self.parent.autoscroll
		end
	else
		if self.vbar then
			self:GetVerticalScrollBar():Remove()
			self.vbar = false
			self.offsety = 0
		end
	end
	
	local vbarwidth = 0
	local vbar = self:GetVerticalScrollBar()
	if vbar then
		vbarwidth = vbar.width
	end
	
	if self.itemwidth > (self.width - vbarwidth) then
		if vbar then
			self.itemwidth = self.itemwidth + vbarwidth
		end
		self.extrawidth = self.itemwidth - self.width
		if not self.hbar then
			table.insert(self.internals, loveframes.objects["scrollbody"]:new(self, "horizontal"))
			self.hbar = true
			self:GetHorizontalScrollBar().autoscroll = self.parent.autoscroll
		end
	else
		if self.hbar then
			self:GetHorizontalScrollBar():Remove()
			self.hbar = false
			self.offsetx = 0
		end
	end
	
end

--[[---------------------------------------------------------
	- func: RedoLayout()
	- desc: used to redo the layour of the object
--]]---------------------------------------------------------
function newobject:RedoLayout()
	
	local children = self.children
	local starty = 0
	local startx = 0
	local bar = self.bar
	local display = self.display
	
	if #children > 0 then
		self.rowcolorindex = 1
		for k, v in ipairs(children) do
			v:SetWidth(self.parent:GetTotalColumnWidth())
			local height = v.height
			v.staticx = startx
			v.staticy = starty
			if self.vbar then
				local vbar = self:GetVerticalScrollBar()
				--v:SetWidth(self.width - vbar.width)
				vbar.staticx = self.width - vbar.width
				if self.hbar then
					vbar.height = self.height - self:GetHorizontalScrollBar().height
				else
					vbar.height = self.height
				end
			else
				--v:SetWidth(self.width)
			end
			if self.hbar then
				local hbar = self:GetHorizontalScrollBar()
				--self:SetHeight(self.parent.height - hbar.height)
				if self.vbar then
					hbar.width = self.width - self:GetVerticalScrollBar().width
				else
					hbar.width = self.width
				end
			else
				--self:SetHeight(self.parent.height)
			end
			starty = starty + v.height
			v.lastheight = v.height
			v.colorindex = self.rowcolorindex
			if self.rowcolorindex == self.rowcolorindexmax then
				self.rowcolorindex = 1
			else
				self.rowcolorindex = self.rowcolorindex + 1
			end
		end
	end
	
end

--[[---------------------------------------------------------
	- func: AddRow(data)
	- desc: adds a row to the object
--]]---------------------------------------------------------
function newobject:AddRow(data)

	local row = loveframes.objects["columnlistrow"]:new(self, data)
	local colorindex = self.rowcolorindex
	local colorindexmax = self.rowcolorindexmax
	
	if colorindex == colorindexmax then
		self.rowcolorindex = 1
	else
		self.rowcolorindex = colorindex + 1
	end
	
	table.insert(self.children, row)
	self:CalculateSize()
	self:RedoLayout()
	self.parent:AdjustColumns()
	
end

--[[---------------------------------------------------------
	- func: GetScrollBar()
	- desc: gets the object's scroll bar
--]]---------------------------------------------------------
function newobject:GetScrollBar()

	local internals = self.internals
	
	if self.bar then
		local scrollbody = internals[1]
		local scrollarea = scrollbody.internals[1]
		local scrollbar  = scrollarea.internals[1]
		return scrollbar
	else
		return false
	end
	
end

--[[---------------------------------------------------------
	- func: Sort()
	- desc: sorts the object's children
--]]---------------------------------------------------------
function newobject:Sort(column, desc)
	
	self.rowcolorindex = 1
	
	local colorindexmax = self.rowcolorindexmax
	local children = self.children
	
	table.sort(children, function(a, b)
		if desc then
            return (tostring(a.columndata[column]) or a.columndata[column]) < (tostring(b.columndata[column]) or b.columndata[column])
        else
			return (tostring(a.columndata[column]) or a.columndata[column]) > (tostring(b.columndata[column]) or b.columndata[column])
		end
	end)
	
	for k, v in ipairs(children) do
		local colorindex = self.rowcolorindex
		v.colorindex = colorindex
		if colorindex == colorindexmax then
			self.rowcolorindex = 1
		else
			self.rowcolorindex = colorindex + 1
		end
	end
	
	self:CalculateSize()
	self:RedoLayout()
	
end

--[[---------------------------------------------------------
	- func: Clear()
	- desc: removes all items from the object's list
--]]---------------------------------------------------------
function newobject:Clear()

	self.children = {}
	self:CalculateSize()
	self:RedoLayout()
	self.parent:AdjustColumns()
	self.rowcolorindex = 1
	
end

function newobject:GetVerticalScrollBar()

	for k, v in ipairs(self.internals) do
		if v.bartype == "vertical" then
			return v
		end
	end
	
	return false
	
end

function newobject:GetHorizontalScrollBar()

	for k, v in ipairs(self.internals) do
		if v.bartype == "horizontal" then
			return v
		end
	end
	
	return false
	
end