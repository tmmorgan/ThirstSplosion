--==============================================================================
-- File:     menu.lua
-- Author:   Kevin Harriss
-- Modified: April 27, 2015
-- Descript: 
--==============================================================================

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )

--------------------------------------------

-- forward declarations and other locals
local playBtn

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()

	-- go to game.lua scene
	composer.gotoScene( "game", "fade", 500 )

	return true	-- indicates successful touch
end

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------

--==============================================================================
-- Function: scene:create( event (table) )
-- Author:   Kevin Harris
-- Modified: April 27, 2015
-- Returns:  
-- Descript: Called when the scene's view does not exist.
--==============================================================================
function scene:create( event )

	local sceneGroup = self.view

	-- display a background image
	local background = display.newImageRect( "images/space.png", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	
	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newImageRect( "images/title.png", 661, 160 )
	titleLogo.x = 600
	titleLogo.y = 150
	
	local robot = display.newImageRect( "images/robot.png", 350, 510 )
	robot.x = 250
	robot.y = 450

	--
	-- Create a widget button (which will load game.lua on release)
	--

	playBtn = widget.newButton{
		label="",
		labelColor = { default={255}, over={128} },
		defaultFile="images/play.png",
		overFile="images/play-clicked.png",
		width=300, height=68,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn.x = 680
	playBtn.y = 480

	local leftBorder = display.newRect(-500,0,500, display.contentHeight)
	leftBorder.anchorX = 0
	leftBorder.anchorY = 0
	leftBorder:setFillColor(0,0,0,255)

	local rightBorder = display.newRect(display.contentWidth,0,500,display.contentHeight)
	rightBorder.anchorX = 0
	rightBorder.anchorY = 0
	rightBorder:setFillColor(0,0,0,255)

	sceneGroup:insert(background)
	sceneGroup:insert(robot)
	sceneGroup:insert(titleLogo)
	sceneGroup:insert(playBtn)
	sceneGroup:insert(leftBorder)
	sceneGroup:insert(rightBorder)

end

--==============================================================================
-- Function: scene:show( event (table) )
-- Author:   Kevin Harris
-- Modified: December 17, 2014
-- Returns:
-- Descript:
--==============================================================================
function scene:show( event )
	
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

--==============================================================================
-- Function: scene:hide( event (table) )
-- Author:   Kevin Harris
-- Modified: December 17, 2014
-- Returns:
-- Descript:
--==============================================================================
function scene:hide( event )
	
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

--==============================================================================
-- Function: scene:destroy( event (table) )
-- Author:   Kevin Harris
-- Modified: December 17, 2014
-- Returns:
-- Descript:
--==============================================================================
function scene:destroy( event )
	
	local sceneGroup = self.view
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene