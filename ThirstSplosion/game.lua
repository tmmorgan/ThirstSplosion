--==============================================================================
-- File:     game.lua
-- Author:   Kevin Harris
-- Modified: April 15, 2015
-- Descript: 
--==============================================================================

-- TODO: Set USE_TEMP_TABLES to false to switch from the loading of table data
-- to the loading of the actual game data!
USE_TEMP_TABLES = false
SHOW_COLUMN_MARKERS = false

local composer = require( "composer" )
local scene = composer.newScene()

local collision = require( "collision" )

require( "utilities" )
require( "collision" )
require( "load_imageTypes" )
require( "load_levelData" )
system.activate("multitouch")

--local screenW = display.contentWidth
--local screenH = display.contentHeight
--local halfW = display.contentWidth * 0.5
local screenW = 21 * 64
local screenH = 21 * 64
local halfW = screenW / 2

local startAnimating = false
local prevX = 0
local prevY = 0
--local joyRect = display.newRect(0, 0, 60, 60)
local bombSpeed = 20

local loadNextRoom = false
local isRunning = false
roomLength = (21*12)
isChangingRooms = false
roomTransitionPoint = 128 + 28
tileSize = 64
roomNum = 0
roomTransitionSpeed = 15

--==============================================================================
-- Function: scene:create( event (table) )
-- Author:   Kevin Harris
-- Modified: April 27, 2015
-- Returns:  
-- Descript: Called when the scene's view does not exist.
--==============================================================================
function scene:create( event )

	local sceneGroup = self.view

	-- Initialize misc. global variables.

	gGameMode = "menu"
	gPaused = false
	gDisplayDebugInfo = false
	gMuteSound = false
	gFireLaser = false
	gFireThrusters = false
	gSpeed = 0
	gElapsedTimeForThruster = 0
	gElapsedTimeDropping = 0
	gImageSheets = {}
	gSequenceData = {}
	gXDir = 0
	gYDir = 0

	local jslib = require( "simpleJoystick" )

		js = jslib.new( 50, 100)
		js.x = display.contentWidth/2 - 500
		js.y = display.contentHeight/2 + 250
	--
		function catchTimer( e )
			--[[
			print( "  joystick info: "
				.. " dir=" .. js:getDirection()
				.. " angle=" .. js:getAngle()
				.. " dist="..js:getDistance() )
			return true
			]]--
		end


	--
	js:activate()
	timer.performWithDelay( 500, catchTimer, -1 )
	js:putToFront()

	local backgroundImage = display.newImageRect( "images/floor.png", display.contentWidth, display.contentHeight )
	backgroundImage.anchorX = 0
	backgroundImage.anchorY = 0
	backgroundImage.x, backgroundImage.y = 0, 0

	--
	-- Player...
	
	local sheetOptions_LegDay =
	{
	    width = 128,
	    height = 128,
	    numFrames = 8
	}

	local sheet_LegDay = graphics.newImageSheet( "images/LegDay_Atlas.png", sheetOptions_LegDay )

	local sequence_LegDay = 
	{
		{
	        name = "idle",
	        frames = {1, 2},
	        time = 1000,
	        loopCount = 0,
	        loopDirection = "forward"
    	},

    	{
	        name = "kick",
	        frames = {3, 4},
	        time = 400,
	        loopCount = 1,
	        loopDirection = "forward"
    	},
    	
    	{
	        name = "run",
	        frames = {5, 6, 7, 8},
	        time = 500,
	        loopCount = 0,
	        loopDirection = "forward"
    	},
	}


	gPlayer =
	{
		images =
		{
			fighter =
			{	
				image = display.newSprite( sheet_LegDay, sequence_LegDay ),
				width = 100,
				height = 100
			},

			laser =
			{
				width = 12,
				height = 3
				--collisionMap = newCollisionMap( "Images/Player/laser.png" )
			},

			missile =
			{
				width = 19,
				height = 3
				--collisionMap = newCollisionMap( "Images/Player/missile.png" )
			},

			bomb = 
			{
				width = 64,
				height = 100
			},

			explosion =
			{
				width = 256,
				height = 256
			}
		
		},

		x = 100,
		y = display.contentHeight / 2,
		shields = 100,
		score = 0,
		state = "normal",
		numMissiles = 0,
		activeWeapon = "laser",
		rateOfFire = 600,
		speed = 100,
		active = true
	}

	gPlayer.images.fighter.image:play()
	gPlayer.images.fighter.image.anchorX = 0
    gPlayer.images.fighter.image.anchorY = 0
	gPlayer.images.fighter.image.x = gPlayer.x
	gPlayer.images.fighter.image.y = gPlayer.y

    -- For the "fighter.png" image to line up correctly with the animated frames drawn
    -- from the "animated_fighter.png" image, we will need to apply an offset.
    gPlayer.offsetYForCollision = 30

	--
	-- Explosions...
	--

	gExplosions =
	{
		onscreen = {}
	}

	--
	-- Power Ups...
	--

	gPowerUps =
	{
		shieldBonus = 10,
		missilesBonus = 10,
		
		onscreen = {}
	}

	--
	-- Projectiles...
	--

	gProjectiles =
	{
		player = {},
		enemy = {}
	}

	gBombs = 
	{
		onscreen = {}
	}

	--
	-- Sprites and level data...
	--

	local fullPath = system.pathForFile( "data/imageTypes.csv", system.ResourceDirectory )

	gSprites =
	{
		imageTypes = loadImageTypes( fullPath ),

		onscreen = {}
	}

	fullPath = system.pathForFile( "data/level1.level", system.ResourceDirectory )

	gLevelData = loadLevelData( fullPath )

	--
    -- Setup a scrolling star field.
    --

    gStarField = {}

	local starGroup = display.newGroup()

	--[[
    for i = 1, 50 do

		local speed = math.random( 1, 3 )

        gStarField[i] =
        {
			star = display.newCircle( math.random( 0, screenW ), math.random( 0, screenH ), speed ),
            speed = speed
        }

		gStarField[i].star:setFillColor( 255, 255, 255 )

		starGroup:insert( gStarField[i].star )

    end
	]]--
	--[[
   	local leftBorder = display.newRect(-500,0,500, display.contentHeight)
	leftBorder.anchorX = 0
	leftBorder.anchorY = 0
	leftBorder:setFillColor(0,0,0,255)

	local rightBorder = display.newRect(display.contentWidth,0,500,display.contentHeight)
	rightBorder.anchorX = 0
	rightBorder.anchorY = 0
	rightBorder:setFillColor(0,0,0,255)
	]]--
	gSpriteGroup = display.newGroup()

	sceneGroup:insert(backgroundImage)
	sceneGroup:insert(starGroup)
	sceneGroup:insert(gPlayer.images.fighter.image)
	sceneGroup:insert(gSpriteGroup)
	--sceneGroup:insert(leftBorder)
	--sceneGroup:insert(rightBorder)

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
		
		startAnimating = true

		Runtime:addEventListener( "enterFrame", update )
		
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
		
		gLastDrawTime = nil
		gLevelTimeElapsed = nil
		gElapsedTime = nil
	end	
end

--==============================================================================
-- Function: scene:destroy( event (table) )
-- Author:   Kevin Harris
-- Modified: September 25, 2013
-- Returns:  
-- Descript: If scene's view is removed, scene:destroyScene() will be called 
--           just prior to destruction.
--==============================================================================
function scene:destroy( event )

	local sceneGroup = self.view

end

--==============================================================================
-- Function: scene:update( event (table) )
-- Author:   Kevin Harris
-- Modified: September 25, 2013
-- Returns:  
-- Descript: Called once per frame to update game.
--==============================================================================
function update( event )

	eventTime = event.time * 0.001
	
	if startAnimating == false then
		--print( "event.time * 0.001 = " .. tostring(event.time * 0.001) )
		return
	else
		if gLevelTimeElapsed == nil then
			--gLevelStartTime = event.time
			gLastDrawTime = eventTime
			gLevelTimeElapsed = 0
			gElapsedTime = 0
		end
	end

	gElapsedTime = eventTime - gLastDrawTime
	gLastDrawTime = eventTime
	gLevelTimeElapsed = gLevelTimeElapsed + gElapsedTime

	--
	-- When player starts to change rooms, load the next room (roomWidth x roomHeight sprites)
	--

	if loadNextRoom then

		for i,v in ipairs( gLevelData ) do

			if i <= roomLength then

				createSprite( v ) -- Based on the level data, spawn a sprite!
				v.spawned = true  -- Mark the level data entry for removal.
				js.putToFront()

			else

			-- As soon as we hit a sprite whose spawn time has not yet expired -
			-- we know that all the other sprites in the table are not ready as 
			-- well, since the table is sorted by time.
				break

			end

		end

		loadNextRoom = false

	end


	-- Check for players death!
	if gPlayer.shields <= 0 and gPlayer.active == true then

        createExplosion( "explosionBig", gPlayer.x + 40, gPlayer.y + gPlayer.offsetYForCollision )
        gPlayer.active = false

		gPlayer.images.fighter.image:removeSelf()

		gPlayer.x = 100
		gPlayer.y = display.contentHeight / 2

    end

	local prevX = gPlayer.x
    local prevY = gPlayer.y

	if gPlayer.active then

		if gPlayer.activeWeapon == "missile" and gPlayer.numMissiles <= 0 then
			gPlayer.activeWeapon = "laser"
			gPlayer.rateOfFire = 150
		end
		
		-- Fire like there's no tomorrow!
		--firePlayerProjectile( gPlayer.activeWeapon )
		--firePlayerProjectile("bomb")
		--fireBomb()
		
		--Old player movement
		--[[	
		if gFireThrusters then
			gElapsedTimeDropping = 0
			gElapsedTimeForThruster = gElapsedTimeForThruster + gElapsedTime
			gSpeed = -(300 * gElapsedTimeForThruster)		
		else
			gElapsedTimeForThruster = 0
			gElapsedTimeDropping = gElapsedTimeDropping + gElapsedTime
			gSpeed = 400 * gElapsedTimeDropping
		end
		]]--

		gSpeed = 450

		--Nonfunctional player movement code based on joystick
		--gPlayer.y = gPlayer.y + (gSpeed * gElapsedTime)
		--[[
		gPlayer.y = gPlayer.y + gSpeed*gElapsedTime*math.cos(js:getAngle())
		gPlayer.x = gPlayer.x + gSpeed*gElapsedTime*math.sin(js:getAngle())
		print("sin" .. gPlayer.y + gSpeed*gElapsedTime*math.cos(js:getAngle()))
		print("cos" .. gPlayer.x + gSpeed*gElapsedTime*math.sin(js:getAngle()))
		print("ang" .. js:getAngle())
		]]--
		--[[
		if js:getAngle() > 315 or js:getAngle() <= 45 then
			gPlayer.x = gPlayer.x + gSpeed*gElapsedTime
			gPlayer.y = gPlayer.y
		elseif js:getAngle() > 45 and js:getAngle() <= 135 then
			gPlayer.x = gPlayer.x
			gPlayer.y = gPlayer.y - gSpeed*gElapsedTime
		elseif js:getAngle() > 135 and js:getAngle() <= 225 then
			gPlayer.x = gPlayer.x - gSpeed*gElapsedTime
			gPlayer.y = gPlayer.y 
		elseif js:getAngle() > 225 and js:getAngle() <= 315 then
			gPlayer.x = gPlayer.x
			gPlayer.y = gPlayer.y + gSpeed*gElapsedTime
		end
		]]--


		if (not isChangingRooms) then

		--Player movement

			gPlayer.x = gPlayer.x + gSpeed * gElapsedTime * js:getXCoord()
			gPlayer.y = gPlayer.y + gSpeed * gElapsedTime * js:getYCoord()

			if gPlayer.y < 0 then
				gPlayer.y = 0
			elseif gPlayer.y > (screenH - gPlayer.images.fighter.image.height) then
				gPlayer.y = screenH - gPlayer.images.fighter.image.height
			end

			if gPlayer.x < 0 then
				gPlayer.x = 0
			elseif gPlayer.x > (screenW - gPlayer.images.fighter.image.height) then
				gPlayer.x = (screenW - gPlayer.images.fighter.image.height)
			end

		
			gPlayer.images.fighter.image.x = gPlayer.x
			gPlayer.images.fighter.image.y = gPlayer.y

			if js:getXCoord() ~= 0 or js:getYCoord() ~= 0 then

				if gPlayer.images.fighter.image.sequence == "kick" and gPlayer.images.fighter.image.frame == 2 then

					isRunning = false

				end

				if not isRunning then
					isRunning = true
					gPlayer.images.fighter.image:setSequence("run")
					gPlayer.images.fighter.image:play()
				end

				gXDir = js:getXCoord()
				gYDir = js:getYCoord()

			else

				if isRunning then
					isRunning = false
					gPlayer.images.fighter.image:setSequence("idle")
					gPlayer.images.fighter.image:play()
				end

			end

			if gPlayer.x >= (screenW - roomTransitionPoint) then
				isChangingRooms = true
				loadNextRoom = true
			end

		else 

			--Old transition code
			--[[
			gPlayer.x = gPlayer.x - (roomTransitionSpeed)
			gPlayer.images.fighter.image.x = gPlayer.x
			gPlayer.images.fighter.image.y = gPlayer.y
			
			if gPlayer.x <= roomTransitionPoint then
				
				isChangingRooms = false
			
			end
			]]--

			gPlayer.x = gPlayer.x - (roomTransitionSpeed)
			gPlayer.images.fighter.image.x = gPlayer.x
			gPlayer.images.fighter.image.y = gPlayer.y

			if gPlayer.x <= 0  then
				isChangingRooms = false
			end

		end

	end

	--
	-- Scroll stars from right to left.
	--
	--[[
    for i = 1, #gStarField do

        -- Move the star.
		gStarField[i].star.x = gStarField[i].star.x - gStarField[i].speed

        -- If the star falls off the screen's edge, wrap it around
        if gStarField[i].star.x <= 0 then
            gStarField[i].star.x = screenW
        end

    end
	]]--

	--
	-- Update explosions.
	--

	for i = #gExplosions.onscreen, 1,-1 do

		local e = gExplosions.onscreen[i]

		e.animation.x = e.x
		e.animation.y = e.y

	end

	--
	-- Update bombs.
	--

	for i = #gBombs.onscreen, 1, -1 do
		local e = gBombs.onscreen[i]
		--if timeToDie is greater than the system time, Explode and deal damage to all sprites in rode,ange
		if e.timeToDie <= system.getTimer() then
			
			e.active = false
			createExplosion( "explosionBig", e.x, e.y)
			for i,v in ipairs(gSprites.onscreen) do
				if not gSprites.imageTypes[v.imageTypesIndex].background then
					--If an enemy is colliding with the explosion, deal 100 damage to it
					if rectsCollide(e.x - gPlayer.images.explosion.width/2, 
						e.y - gPlayer.images.explosion.height/2,
						gPlayer.images.explosion.width,
						gPlayer.images.explosion.height,
						v.x, v.y,
						gSprites.imageTypes[v.imageTypesIndex].width,
						gSprites.imageTypes[v.imageTypesIndex].height) then
						if not gSprites.imageTypes[v.imageTypesIndex].background then
							v.shields = v.shields - 100
						end
					end
				end
			end
		end

		--Check for collision with the player, if colliding set velocity based on the
		--Player's position relative to the bomb
		if rectsCollide(gPlayer.x, gPlayer.y,
						gPlayer.images.fighter.width,
						gPlayer.images.fighter.height,
						e.x, e.y,
						gPlayer.images.bomb.width,
						gPlayer.images.bomb.height) then

			local tempXVector = e.x + gPlayer.images.bomb.width / 2 - (gPlayer.x + gPlayer.images.fighter.width / 2)
			local tempYVector = e.y + gPlayer.images.bomb.height / 2 - (gPlayer.y + gPlayer.images.fighter.height / 2)

			directionVector = {
								x = tempXVector,
								y = tempYVector}
			directionVector = normalizeVector( directionVector )

			gPlayer.images.fighter.image:setSequence("kick")
			gPlayer.images.fighter.image:play()


			--Extremely naive way to determine velocity
			--e.xVel = (e.x - gPlayer.x) / 4
			--e.yVel = (e.y - gPlayer.y) / 4

			--Less naive way
			e.xVel = directionVector.x * bombSpeed
			e.yVel = directionVector.y * bombSpeed


			print("x: " .. e.xVel .. " y: " .. e.yVel)
		end


		--If the bomb has a velocity greater than zero, move it
		if e.xVel > 0 or e.yVel > 0 then
			local tempEX = e.x + e.xVel
			local tempEY = e.y + e.yVel

			--Check to see if the bomb is colliding with anything environmental, if not, move it
			for i,v in ipairs(gSprites.onscreen) do
				if not gSprites.imageTypes[v.imageTypesIndex].background then
					if rectsCollide(tempEX, tempEY,
						gPlayer.images.bomb.width,
						gPlayer.images.bomb.height,
						v.x, v.y,
						gSprites.imageTypes[v.imageTypesIndex].width,
						gSprites.imageTypes[v.imageTypesIndex].height) then
						if not gSprites.imageTypes[v.imageTypesIndex].background then
							--If it collides, stay where it is
							tempEX = e.x
							tempEY = e.y
							e.xVel = 0
							e.yVel = 0
						end
					end
				end
			end

			e.x = tempEX
			e.y = tempEY
			e.image.x = e.x
			e.image.y = e.y
		end

		if e.x < 0 or e.x > screenW or
		   e.y < 0 or e.y > screenH then
			v.active = false
		end

	end

	--
	-- Update all game sprites.
	--

	for i,v in ipairs( gSprites.onscreen ) do

		v.update( v, gElapsedTime )

		if v.image then
			v.image.x = v.x
			v.image.y = v.y
		else
			v.animation.x = v.x
			v.animation.y = v.y
		end

	end
	
	--
	-- Update power ups.
	--

	for i,v in ipairs( gPowerUps.onscreen ) do

		v.x = v.x - 100 * gElapsedTime

		-- Remove out-of-bound power ups.
		if v.x < 0 then
			v.active = false
		end
		
		v.image.x = v.x
		v.image.y = v.y

	end

	--
	-- Check for collisions between the player's ship and all active sprites.
	--

	for i,v in ipairs( gSprites.onscreen ) do

		if not gSprites.imageTypes[v.imageTypesIndex].background then

			if spritesCollide( gPlayer.x, gPlayer.y,
							   gPlayer.images.fighter.width,
							   gPlayer.images.fighter.height,
							   gPlayer.images.fighter.collisionMap,
							   v.x, v.y,
							   gSprites.imageTypes[v.imageTypesIndex].width,
							   gSprites.imageTypes[v.imageTypesIndex].height,
							   gSprites.imageTypes[v.imageTypesIndex].collisionMap ) then

				v.collided = true
				

				print("SHIELDS: " .. gPlayer.shields)

				if gSprites.imageTypes[v.imageTypesIndex].obstacle then

					-- If the player hits an obstacle - do not let it pass
					-- through but move it back to where it was before.
					gPlayer.x = prevX
					gPlayer.y = prevY

				else
					gPlayer.shields = gPlayer.shields - 20

				end

			end

		end

	end

	--
	-- Update enemy projectile and check for collisions.
	--

	for i,v in ipairs( gProjectiles.enemy ) do

		v.x = v.x + v.directionVector.x * (v.speed * gElapsedTime)
		v.y = v.y + v.directionVector.y * (v.speed * gElapsedTime)

		v.animation.x = v.x
		v.animation.y = v.y

		-- Check for collisions between the current projectile and the player.
		if rectsCollide( v.x, v.y,
						 10, 10,
						 gPlayer.x, gPlayer.y,
						 gPlayer.images.fighter.width,
						 gPlayer.images.fighter.height ) then

			playSound( "hit" )
			v.active = false -- Kill off enemy projectile.
			gPlayer.shields = gPlayer.shields - v.damage -- Decrease player shields.

			print("SHIELDS: " .. gPlayer.shields)

			-- Create a small explosion.
			createExplosion( "explosionLittle", v.x, v.y )

		end

		-- Remove off-screen projectiles.
		if v.x < 0 or v.x > screenW or
		   v.y < 0 or v.y > screenH then
			v.active = false
		end

	end


	--
	-- Update player projectiles and check for collisions.
	--

	for i,v in ipairs( gProjectiles.player ) do

		v.x = v.x + v.speed * gElapsedTime

		v.image.x = v.x
		v.image.y = v.y

		if v.weapon == "missile" then

			--v.exhaust:setPosition( v.x - 7, v.y + 2 )
			--v.exhaust:update( gElapsedTime )

			-- Update missile speed from slow to a max of 300.
			if v.speed < 300 then
				v.speed = v.speed * 1.1 + 1 * gElapsedTime
			end

		end

		-- Check for collisions between the current projectile
		-- and all game sprites.
		for n,c in ipairs( gSprites.onscreen ) do

			if not gSprites.imageTypes[c.imageTypesIndex].background then

				
				if spritesCollide( v.x, v.y,
								   gPlayer.images.laser.width,
								   gPlayer.images.laser.height,
								   gPlayer.images.laser.collisionMap,
								   c.x, c.y,
								   gSprites.imageTypes[c.imageTypesIndex].width,
								   gSprites.imageTypes[c.imageTypesIndex].height,
								   gSprites.imageTypes[c.imageTypesIndex].collisionMap ) then

					playSound( "hit" )
					--v.active = false -- Cleanup projectile.

					if not gSprites.imageTypes[c.imageTypesIndex].obstacle then
						c.shields = c.shields - v.damage -- Decrease enemy shields.
					end

					-- Create a small explosion at the point of impact.
					createExplosion( "explosionLittle", v.x, v.y )

				end
				
				--[[
				--I tried to do bombs wrong.  This is the result.
				if rectsCollide( v.x - bombWidth / 2, v.y - bombHeight / 2,
								   bombWidth,
								   bombHeight,
								   c.x, c.y,
								   gSprites.imageTypes[c.imageTypesIndex].width,
								   gSprites.imageTypes[c.imageTypesIndex].height) then
				

				if spritesCollide( v.x - gPlayer.images.bomb.width,
								   v.y - gPlayer.images.bomb.height,
								   gPlayer.images.bomb.width,
								   gPlayer.images.bomb.height,
								   gPlayer.images.bomb.collisionMap,
								   c.x, c.y,
								   gSprites.imageTypes[c.imageTypesIndex].width,
								   gSprites.imageTypes[c.imageTypesIndex].height,
								   gSprites.imageTypes[c.imageTypesIndex].collisionMap ) then
					print("Bomb Triggered")

					--Check to see which enemies were hit by the explosion
					for m, d in ipairs(gSprites.onscreen) do
						if not gSprites.imageTypes[d.imageTypesIndex].background then
							--print("Non background asset")
							--For all non background sprites check collision with the explosion
							if rectsCollide( v.x , v.y,
								   explosionWidth,
								   explosionHeight,
								   d.x, d.y,
								   gSprites.imageTypes[d.imageTypesIndex].width,
								   gSprites.imageTypes[d.imageTypesIndex].height) then
									print("Collision!")
								if not gSprites.imageTypes[d.imageTypesIndex].obstacle then
									d.shields = d.shields - v.damage
									print("Dealt Damage at ")
								end
							end
						end
					end

					playSound( "hit" )
					v.active = false -- Cleanup projectile.

					

					if not gSprites.imageTypes[c.imageTypesIndex].obstacle then
						c.shields = c.shields - v.damage -- Decrease enemy shields.
					end

					

					-- Create a small explosion at the point of impact.
					createExplosion( "explosionLittle", v.x, v.y )

				end
				]]--

			end

		end

		-- Remove out-of-bound projectiles. Once they leave the screen - they're gone!
		if v.x < 0 or v.x > display.contentWidth or
		   v.y < 0 or v.y > display.contentHeight then
			v.active = false
		end
	end

	--
	-- Cleaning up game sprites that need removal such as dead enemies and 
	-- obstacles that have left the screen.
	--

	for i = #gSprites.onscreen,1,-1 do

		local t = gSprites.onscreen[i].imageTypesIndex

		if not gSprites.imageTypes[gSprites.onscreen[i].imageTypesIndex].obstacle and
		   not gSprites.imageTypes[gSprites.onscreen[i].imageTypesIndex].columnMarker and
		   not gSprites.imageTypes[gSprites.onscreen[i].imageTypesIndex].background then

			if gSprites.onscreen[i].shields <= 0 then

				-- Player blew it up with lasers or missiles!

				gSprites.onscreen[i].destroyedByPlayer = true

				if gSprites.onscreen[i].powerUpType ~= nil then
					createPowerUp( gSprites.onscreen[i].powerUpType,
								   gSprites.onscreen[i].x + gSprites.imageTypes[t].width / 2,
								   gSprites.onscreen[i].y + gSprites.imageTypes[t].height / 2 )
				end

				createExplosion( "explosionBig",
								 gSprites.onscreen[i].x + gSprites.imageTypes[t].width / 4,
								 gSprites.onscreen[i].y + gSprites.imageTypes[t].height / 4 )

				gSprites.onscreen[i].active = false

			elseif gSprites.onscreen[i].collided then

				-- Player rammed it with the his/her ship!

				createExplosion( "explosionBig",
								 gSprites.onscreen[i].x + gSprites.imageTypes[t].width / 4,
								 gSprites.onscreen[i].y + gSprites.imageTypes[t].height / 4 )

				gSprites.onscreen[i].active = false

			end

		end

		if gSprites.onscreen[i].x < -(gSprites.imageTypes[t].width) then
			-- The sprite has left the screen.
			gSprites.onscreen[i].active = false
		end

	end

	--
	-- Check for collisions between the player's ship and all power ups.
	--
	
	for i = #gPowerUps.onscreen, 1, -1 do

		if rectsCollide( gPowerUps.onscreen[i].x, gPowerUps.onscreen[i].y,
						 gSprites.imageTypes[gPowerUps.onscreen[i].imageTypesIndex].width,
						 gSprites.imageTypes[gPowerUps.onscreen[i].imageTypesIndex].height,
						 gPlayer.x, gPlayer.y,
						 gPlayer.images.fighter.width,
						 gPlayer.images.fighter.height ) then

			if gPowerUps.onscreen[i].powerUp == "shields" and gPlayer.shields < 100 then

				gPlayer.shields = gPlayer.shields + gPowerUps.shieldBonus

				if gPlayer.shields > 100 then
				   gPlayer.shields = 100
				end

				print("SHIELDS: " .. gPlayer.shields)

				playSound( "shieldsActivate" )
				gPowerUps.onscreen[i].active = false

			elseif gPowerUps.onscreen[i].powerUp == "missiles" and gPlayer.numMissiles < 100 then

				gPlayer.numMissiles = gPlayer.numMissiles + gPowerUps.missilesBonus
				
				gPlayer.activeWeapon = "missile"
				gPlayer.rateOfFire = 300

				if gPlayer.numMissiles > 100 then
				   gPlayer.numMissiles = 100
				end

				print("MISSILES: " .. gPlayer.numMissiles)

				playSound( "loadMissiles" )
				gPowerUps.onscreen[i].active = false

			end

		end

	end
		
	--
    -- Remove all game sprites that have been marked for removal.
    --

    for i = #gLevelData, 1,-1 do
        if gLevelData[i].spawned then
            table.remove( gLevelData, i )
        end
    end
		
	for i = #gExplosions.onscreen, 1,-1 do
        if not gExplosions.onscreen[i].active then
			gExplosions.onscreen[i].animation:removeSelf()
            table.remove( gExplosions.onscreen, i )
        end
    end

    
    for i = #gBombs.onscreen, 1, -1 do
    	if not gBombs.onscreen[i].active then
    		gBombs.onscreen[i].image:removeSelf()
    		table.remove(gBombs.onscreen, i)
    	end
    end


    for i = #gProjectiles.player, 1,-1 do

        if not gProjectiles.player[i].active then

			gProjectiles.player[i].image:removeSelf()
			
			table.remove( gProjectiles.player, i )

        end

    end

    for i = #gProjectiles.enemy, 1,-1 do

        if not gProjectiles.enemy[i].active then
		   gProjectiles.enemy[i].animation:removeSelf()
           table.remove( gProjectiles.enemy, i )
        end

    end
			
	for i = #gSprites.onscreen, 1,-1 do
        if not gSprites.onscreen[i].active then

            if gSprites.onscreen[i].delete ~= nil then
                gSprites.onscreen[i].delete( gSprites.onscreen[i], gElapsedTime )
            end

            if gSprites.imageTypes[gSprites.onscreen[i].imageTypesIndex].animated then
                gSprites.onscreen[i].animation:removeSelf()
            else
				gSprites.onscreen[i].image:removeSelf()
			end

            table.remove( gSprites.onscreen, i )
        end
    end

	for i = #gPowerUps.onscreen, 1, -1 do
        if not gPowerUps.onscreen[i].active then
			gPowerUps.onscreen[i].image:removeSelf()
            table.remove( gPowerUps.onscreen, i )
        end
    end

end

--==============================================================================
-- Function: touchListener( event (table) )
-- Author:   Kevin Harris
-- Modified: September 25, 2013
-- Returns:  
-- Descript: Receives touch events for the scene.
--==============================================================================
local function touchListener( event )
	
	--print( "event(" .. event.phase .. ") ("..event.x..","..event.y..")" )
	--[[
	if event.phase == "began" then
		gFireThrusters = true
	elseif event.phase == "ended" then
		gFireThrusters = false
	end
	]]
	--gFireThrusters = true
	--firePlayerProjectile("bomb")
	
end

local function tapListener(event)
	fireBomb()
end

local function joyListener(event)
	print( "Phase: "..event.phase )
    print( "Location: "..event.x..","..event.y )
    print( "Unique touch ID: "..tostring(event.id) )
    print( "----------" )
    return true
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- Event listeners for scene life-cycle events.
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
--joyRect:addEventListener("joyTouch", joyListener)
Runtime:addEventListener( "touch", touchListener )
Runtime:addEventListener("tap", tapListener)

-----------------------------------------------------------------------------------------

return scene
