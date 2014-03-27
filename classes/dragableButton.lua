DragableButton = gideros.class(Sprite)

function DragableButton:init(sprite, mode)
	
	self.focus = false
	self.mode = mode;
	self:addChild(sprite);
	
	self.minX=0;
	self.minY=0;
	self.maxX=application:getContentWidth();
	self.maxY=application:getContentHeight();
	self:addEventListener(Event.MOUSE_DOWN, self.onMouseDown, self)
	self:addEventListener(Event.MOUSE_MOVE, self.onMouseMove, self)
	self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)

	self:addEventListener(Event.TOUCHES_BEGIN, self.onTouchesBegin, self)
	self:addEventListener(Event.TOUCHES_MOVE, self.onTouchesMove, self)
	self:addEventListener(Event.TOUCHES_END, self.onTouchesEnd, self)
	self:addEventListener(Event.TOUCHES_CANCEL, self.onTouchesCancel, self)
end

function DragableButton:setMinX(minVal)
	self.minX = minVal;
end

function DragableButton:setMinY(minVal)
	self.minY = minVal;
end

function DragableButton:setMaxX(maxVal)
	self.maxX = maxVal;
end

function DragableButton:setMaxY(maxVal)
	self.maxY = maxVal;
end

function DragableButton:getMinX()
	return self.minX ;
end

function DragableButton:getMinY()
	return self.minY ;
end

function DragableButton:getMaxX()
	return self.maxX ;
end

function DragableButton:getMaxY(maxVal)
	return self.maxY ;
end

function DragableButton:onMouseDown(event)
	if self:hitTestPoint(event.x, event.y) then
		self.focus = true
		self.offsetX = self:getX() - event.x;
		self.offsetY = self:getY() - event.y;
		self:dispatchEvent(Event.new("begin"))
		event:stopPropagation()
	end
end

function DragableButton:onMouseMove(event)
	if self.focus then
		if not self:hitTestPoint(event.x, event.y) then
			self.focus = false;
		else
			local newX = self:getX()
			local newY = self:getY()
			if(self.mode == 'h') then
				newX = self.offsetX + event.x;
			elseif(self.mode == 'v') then
				newY = event.y + self.offsetY;
			else
				newX = self.offsetX + event.x;
				newY = event.y + self.offsetY;
			end
			
			if(newX > self.maxX) then newX = self:getX() end
			if(newX < self.minX) then newX = self:getX() end
			if(newY > self.maxY) then newY = self:getY() end
			if(newY < self.minY) then newY = self:getY() end
			
			self:setPosition(newX,newY)
		end
		self:dispatchEvent(Event.new("move"))
		event:stopPropagation()
	end
end

function DragableButton:onMouseUp(event)
	if self.focus then
		self.focus = false;
		self:dispatchEvent(Event.new("finish"))
		event:stopPropagation()		
	end
end

-- if DragableButton is on focus, stop propagation of touch events
function DragableButton:onTouchesBegin(event)
	if self.focus then
	self:dispatchEvent(Event.new("begin"))
		event:stopPropagation()
	end
end

-- if DragableButton is on focus, stop propagation of touch events
function DragableButton:onTouchesMove(event)
	if self.focus then
		self:dispatchEvent(Event.new("move"))
		event:stopPropagation()
	end
end

-- if DragableButton is on focus, stop propagation of touch events
function DragableButton:onTouchesEnd(event)
	if self.focus then
		self:dispatchEvent(Event.new("finish"))
		event:stopPropagation()
	end
end

-- if touches are cancelled, reset the state of the DragableButton
function DragableButton:onTouchesCancel(event)
	if self.focus then
		self.focus = false;
		event:stopPropagation()
	end
end
