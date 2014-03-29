settings = gideros.class(Sprite)
pack = TexturePack.new("assets/atlas.txt", "assets/atlas.png")
function settings:init()
	--here we'd probably want to set up a background picture
	local screen = Bitmap.new(Texture.new("images/gideros_mobile.png"))
	self:addChild(screen)
	screen:setPosition((application:getContentWidth()-screen:getWidth())/2, (application:getContentHeight()-screen:getHeight())/2)
	
	--create layer for menu buttons
	local menu = Shape.new()
	menu:setFillStyle(Shape.SOLID, 330000, 0.5)   
	menu:beginPath(Shape.NON_ZERO)
	menu:moveTo(application:getContentWidth()/5,application:getContentHeight()/16)
	menu:lineTo((application:getContentWidth()/5)*4, application:getContentHeight()/16)
	menu:lineTo((application:getContentWidth()/5)*4, application:getContentHeight()-(application:getContentHeight()/16))
	menu:lineTo(application:getContentWidth()/5, application:getContentHeight()-(application:getContentHeight()/16))
	menu:lineTo(application:getContentWidth()/5, application:getContentHeight()/16)
	menu:endPath()
	self:addChild(menu)
	
	self.volBar = Bitmap.new(pack:getTextureRegion("fgSeekBar.png"))
	self.volBarBg = Bitmap.new(pack:getTextureRegion("bgSeekBar.png"))
	self.volPointer = DragableButton.new(Bitmap.new(pack:getTextureRegion("seekPointer.png")),'v');
	if(volValue == nil) then volValue = 1 end
	
	
	self.volBar:setPosition(300,300)
	self.volBar:setScaleX(0.8)
	self.volBar:setScaleY(1.6)
	self.volBarBg:setPosition(301,304)
	self.volBarBg:setScaleX(0.6)
	self.volBarBg:setScaleX(0.8*volValue);
	
	self.volPointer:setMinX(self.volBar:getX()-5)
	self.volPointer:setMaxX(self.volBar:getX() + (self.volBar:getWidth() - 10)-5)
	self.volPointer:setPosition(((1-volValue)*(self.volPointer:getMaxX() - self.volPointer:getMinX())) + 313,285)
	self.volPointer:addEventListener("move", self.onChangeVolume, self)
	self.volPointer:addEventListener("finish", self.onFinishChangeVolume, self)
	
	self:addChild(self.volBar)
	self:addChild(self.volBarBg)
	self:addChild(self.volPointer)
	
	local musicOnButton = menuButton("images/musicon_up.png","images/musicon_down.png", menu, 1,3)
	local musicOffButton = menuButton("images/musicoff_up.png","images/musicoff_down.png", menu, 1,3)
	musicOnButton:addEventListener("click", 
		function()
			menu:removeChild(musicOnButton)
			music.off()
			menu:addChild(musicOffButton)
		end
	)

	musicOffButton:addEventListener("click", 
		function()
			menu:removeChild(musicOffButton)
			music.on()
			menu:addChild(musicOnButton)
		end
	)
	
	if sets.music then
		menu:addChild(musicOnButton)
	else
		menu:addChild(musicOffButton)
	end
	
	local soundsOnButton = menuButton("images/soundson_up.png","images/soundson_down.png", menu, 2,3)
	local soundsOffButton = menuButton("images/soundsoff_up.png","images/soundsoff_down.png", menu, 2,3)
	
	soundsOnButton:addEventListener("click", 
		function()
			menu:removeChild(soundsOnButton)
			menu:addChild(soundsOffButton)
			sounds.off()
		end
	)
	
	soundsOffButton:addEventListener("click", 
		function()
			menu:removeChild(soundsOffButton)
			menu:addChild(soundsOnButton)
			sounds.on()
		end
	)
	
	if sets.sounds then
		menu:addChild(soundsOnButton)
	else
		menu:addChild(soundsOffButton)
	end
	
	local backButton = menuButton("images/back_up.png","images/back_down.png", menu, 3,3)
	menu:addChild(backButton)
	backButton:addEventListener("click", 
		function()	
			sceneManager:changeScene("main_menu", 1, SceneManager.moveFromRight, easing.outBack) 
		end
	)
	
	
end


function settings:onChangeVolume(event)
	local ratio = (self.volPointer:getX()-285) / (self.volPointer:getMaxX() - self.volPointer:getMinX())
	self.volBarBg:setScaleX(0.8*(1-ratio));
	volValue = 1-ratio;
end

function settings:onFinishChangeVolume(event)
	if(not(soundChannel == nil)) then
		--soundChannel:setVolume(volValue);
		music.channel:setVolume(volValue);
	end
end