main_menu = gideros.class(Sprite)

function main_menu:init()
	--here we'd probably want to set up a background picture
	local screen = Bitmap.new(Texture.new("images/main.png"))
	self:addChild(screen)
	screen:setPosition((application:getContentWidth()-screen:getWidth())/2, (application:getContentHeight()-screen:getHeight())/2)

	--create main_menu button
	local main_menuButton = Button.new(Bitmap.new(Texture.new("images/start_up.png")), Bitmap.new(Texture.new("images/start_down.png")))
	main_menuButton:setPosition((application:getContentWidth()-main_menuButton:getWidth())/2, ((application:getContentHeight()-main_menuButton:getHeight())/2)-(main_menuButton:getHeight()+20))
	self:addChild(main_menuButton)

	--main_menu button on click event
	main_menuButton:addEventListener("click", 
		function()
			--go to pack select scene
			sceneManager:changeScene("level_select", 1, transition, easing.outBack) 
		end
	)
	
	--create main_menu button
	local settingsButton = Button.new(Bitmap.new(Texture.new("images/settings_up.png")), Bitmap.new(Texture.new("images/settings_down.png")))
	settingsButton:setPosition((application:getContentWidth()-settingsButton:getWidth())/2, ((application:getContentHeight()-settingsButton:getHeight())/2))
	self:addChild(settingsButton)

	--main_menu button on click event
	settingsButton:addEventListener("click", 
		function()	
			--go to pack select scene
			sceneManager:changeScene("settings", 1, SceneManager.moveFromLeft, easing.outBack) 
		end
	)
	
	--create main_menu button
	local creditButton = Button.new(Bitmap.new(Texture.new("images/credit_up.png")), Bitmap.new(Texture.new("images/credit_down.png")))
	creditButton:setPosition((application:getContentWidth()-creditButton:getWidth())/2, ((application:getContentHeight()-creditButton:getHeight())/2)+(creditButton:getHeight()+20))
	self:addChild(creditButton)

	--main_menu button on click event
	creditButton:addEventListener("click", 
		function()	
			--go to pack select scene
			sceneManager:changeScene("credit", 1, SceneManager.moveFromRight, easing.outBack) 
		end
	)
end