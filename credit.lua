credit = gideros.class(Sprite)

function credit:init()
	--here we'd probably want to set up a background picture
	local screen = Bitmap.new(Texture.new("images/gideros_mobile.png"))
	local titleFont = TTFont.new("Assets/VERDANAB.TTF", 30)
	local creditFont = TTFont.new("Assets/VERDANAB.TTF", 20)
	self:addChild(screen)
	screen:setPosition((application:getContentWidth()-screen:getWidth())/2, (application:getContentHeight()-screen:getHeight())/2)
	
	--create level description
	local description = Shape.new()
	description:setFillStyle(Shape.SOLID, 330000, 0.5)   
	description:beginPath(Shape.NON_ZERO)
	description:moveTo(application:getContentWidth()/5,application:getContentHeight()/16)
	description:lineTo((application:getContentWidth()/5)*4, application:getContentHeight()/16)
	description:lineTo((application:getContentWidth()/5)*4, application:getContentHeight()-(application:getContentHeight()/16))
	description:lineTo(application:getContentWidth()/5, application:getContentHeight()-(application:getContentHeight()/16))
	description:lineTo(application:getContentWidth()/5, application:getContentHeight()/16)
	description:endPath()
	self:addChild(description)
	
	--setting up description texts
	local lastHeight = (application:getContentHeight()/16)*4
	local textWidth = ((application:getContentWidth()/5)*3) - ((application:getContentHeight()/16)*2)
	--title
	local title = TextWrap.new("Credit", textWidth, "center")
	title:setPosition((application:getContentWidth()/5)+application:getContentHeight()/16, lastHeight)
	title:setTextColor(0xffffff)
	title:setFont(titleFont)
	description:addChild(title)
	lastHeight = lastHeight + 20 + title:getHeight()
	
	--credit text
	local credit1Desc = TextWrap.new("Andreas Bara Timur    (13510019)", textWidth, "center")
	credit1Desc:setPosition((application:getContentWidth()/5)+application:getContentHeight()/16, lastHeight)
	credit1Desc:setTextColor(0xffffff)
	credit1Desc:setFont(creditFont)
	description:addChild(credit1Desc)
	
	lastHeight = lastHeight + 20 + title:getHeight()
	
	--credit text
	local credit2Desc = TextWrap.new("Kevin Alfianto Jangtjik  (13510043)", textWidth, "center")
	credit2Desc:setPosition((application:getContentWidth()/5)+application:getContentHeight()/16, lastHeight)
	credit2Desc:setTextColor(0xffffff)
	credit2Desc:setFont(creditFont)
	description:addChild(credit2Desc)
	
	--back button
	local backButton = Button.new(Bitmap.new(Texture.new("images/back_up.png")), Bitmap.new(Texture.new("images/back_down.png")))
	backButton:setPosition((application:getContentWidth()-backButton:getWidth())/2, application:getContentHeight()-backButton:getHeight()*2)
	description:addChild(backButton)

	backButton:addEventListener("click", 
		function()	
			sceneManager:changeScene("main_menu", 1, SceneManager.moveFromLeft, easing.outBack) 
		end
	)
end