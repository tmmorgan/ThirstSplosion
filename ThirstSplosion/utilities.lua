--==============================================================================
-- File:     utilities.lua
-- Author:   Kevin Harris
-- Modified: April 15, 2015
-- Descript: A collection of misc game functions.
--==============================================================================

require( "update_functions" )
require( "delete_functions" )

-- Pre-Load our ogg or mp3 audio files.
local laserSound = audio.loadSound( "audio/laser.mp3" )
local loadMissilesSound = audio.loadSound( "audio/loadMissiles.mp3" )
local plasmaSound = audio.loadSound( "audio/plasma.mp3" )
local shieldsActivateSound = audio.loadSound( "audio/shieldsActivate.mp3" )
local warpSound = audio.loadSound( "audio/warp.mp3" )
local explosionSound = audio.loadSound( "audio/explosion.ogg" )
local hitSound = audio.loadSound( "audio/hit.ogg" )
local launchSound = audio.loadSound( "audio/launch.ogg" )

--==============================================================================
-- Function: newVector( direction (number in radians),
--                      length (number) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  vector (table)
-- Descript: Creates a 2D vector from a given direction (in radians) and a
--           length.
--==============================================================================
function newVector( direction, length )

    local vector =
    {
        x = math.cos( direction ) * length,
        y = math.sin( direction ) * length
    }

    return vector

end

--==============================================================================
-- Function: normalizeVector( vector (table) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  normalizedVector (table)
-- Descript: Normalizes a 2D vector to unit length (1.0).
--==============================================================================
function normalizeVector( vector )

    normalizedVector = {}

    length = math.sqrt( vector.x * vector.x +
                        vector.y * vector.y )

    normalizedVector.x = vector.x / length
    normalizedVector.y = vector.y / length

    return normalizedVector

end

--==============================================================================
-- Function: playSound( soundName (string) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  Nothing
-- Descript: Plays a sound by name from its pre-allocated sound bank.
--==============================================================================
function playSound( soundName )

    if soundName == "laser" then
        audio.play( laserSound )
    elseif soundName == "missile" then
		audio.play( launchSound )
    elseif soundName == "explosion" then
		audio.play( explosionSound )
    elseif soundName == "hit" then
		audio.play( hitSound )
    elseif soundName == "shieldsActivate" then
		audio.play( shieldsActivateSound )
    elseif soundName == "loadMissiles" then
		audio.play( loadMissilesSound )
    elseif soundName == "warp" then
		audio.play( warpSound )
    elseif soundName == "plasma" then
		audio.play( plasmaSound )
    else
        print( "Error calling playSound() - Unknown sound name '" .. soundName .. "' passed." )
        return
    end

end

--==============================================================================
-- Function: createSprite( spriteData (table) )
-- Author:   Kevin Harris
-- Modified: April 15, 2015
-- Returns:  Nothing
-- Descript: Using a table of sprite data, create an active sprite.
--==============================================================================
function createSprite( spriteData )
    
    -- Turn the imageType string in to an index that points into the types table.
    -- This allows the level file to use easy to read names, such as "enemy1",
    -- while the game can use an index, such as 5, which is faster.
    local imageTypesIndex = 0

    for i,v in ipairs( gSprites.imageTypes ) do

        if v.imageType == spriteData.imageType then
            imageTypesIndex = i
        end

    end

    if imageTypesIndex == 0 then
        print( "Error calling createSprite() - Could not find an image type of '"
        .. spriteData.imageType .. "' Has this image type been added to the " ..
        "ImageTypes.csv file?" )
    end

    -- Start off by making a copy of the spriteData table.
    local newSprite = {}

    for k,v in pairs( spriteData ) do
        newSprite[k] = v
    end

    -- Then, add a few extras for book keeping.
	newSprite.imageTypesIndex = imageTypesIndex
    newSprite.maxShields = spriteData.shields -- Useful for debugging.
    newSprite.update = assignUpdateFunction( spriteData.updateFunction )
    newSprite.delete = assignDeleteFunction( spriteData.deleteFunction )
    newSprite.active = true

    if newSprite.speed == nil then
        newSprite.speed = 64 -- Default value - if not set.
    end

    if newSprite.shields == nil then
        newSprite.shields = 0 -- Default value - if not set.
    end

    if newSprite.points == nil then
        newSprite.points = 0 -- Default value - if not set.
    end

	if gSprites.imageTypes[imageTypesIndex].animated then

		newSprite.animation = display.newSprite( gImageSheets[spriteData.imageType], gSequenceData[spriteData.imageType] )
        newSprite.animation.anchorX = 0
        newSprite.animation.anchorY = 0
		newSprite.animation.x = newSprite.x
		newSprite.animation.y = newSprite.y

		newSprite.animation:play()

        local function spriteEventListener( event )

            if event.phase == "ended" then
                newSprite.active = false -- Have it cleaned up by the game.
            end
        end

       newSprite.animation:addEventListener( "sprite", spriteEventListener )

	else
		
		newSprite.image = display.newImageRect( "images/" .. gSprites.imageTypes[newSprite.imageTypesIndex].imageFile, 
												gSprites.imageTypes[newSprite.imageTypesIndex].width, 
												gSprites.imageTypes[newSprite.imageTypesIndex].height )

        newSprite.image.anchorX = 0
        newSprite.image.anchorY = 0
		newSprite.image.x = newSprite.x
		newSprite.image.y = newSprite.y
		
		if newSprite.imageType == "columnMarker" and SHOW_COLUMN_MARKERS == false then
			newSprite.image.isVisible = false
		end
		
	end
		
    -- Due to rounding errors from moving game sprites via (delta-time * speed),
    -- the default x position, which is set to the screen's width, cannot be used
    -- to place sprites that must march across the screen in lock-step
    -- (such as obstacles), so we need to find the columnMarker from the last
    -- column spawned and place our new obstacle exactly 64 pixels away from it.
    -- This will make sure that all sprites (including obstacles) move together
    -- and touch exactly along their edges. If we don't manually align at least
    -- the obstacles, small cracks will appear between these sprites.

    -- Start from the bottom of the game sprites onscreen table and work our way
    -- up until we hit the columnMarker from the last column spawned and offset
    -- from it exactly 64 pixels. An obstacle from the previous column will always
    -- have a spawn time that is one second less than the sprite we are about to
    -- spawn.
    for i = #gSprites.onscreen, 1,-1 do

        if gSprites.onscreen[i].columnMarker and
           gSprites.onscreen[i].timeToSpawn == (newSprite.timeToSpawn - 1) then

            -- Once we find the columnMarker from the previous column to the right,
            -- we can use its current x position to align this new sprite with.
            newSprite.x = gSprites.onscreen[i].x + 64

            break

        end

    end

	table.insert( gSprites.onscreen, newSprite )

    -- Everytime we add new sprites, we'll need to move our borders back up
    -- in the Z order or the newly created sprites will render on top of them.
	
end

--==============================================================================
-- Function: createExplosion( explosionName (string),
--                            x (number),
--                            y (number) )
-- Author:   Kevin Harris
-- Modified: December 17, 2014
-- Returns:  Nothing
-- Descript:
--==============================================================================
function createExplosion( imageType, x, y )

    local imageTypesIndex = 0

    for i,v in ipairs( gSprites.imageTypes ) do

        if v.imageType == imageType then
            imageTypesIndex = i
        end

    end

    if imageTypesIndex == 0 then
        print( "Error calling createExplosion() - Could not find an image type of '"
        .. imageType .. "' Has this image type been added to the " ..
        "ImageTypes.csv file?" )
    end

	local animation = display.newSprite( gImageSheets[imageType], gSequenceData[imageType] )

	animation.x = x
	animation.y = y
	animation:play()
	

    local explosion =
    {
        animation = animation,
        active = true,
        x = x,
        y = y
    }

    local function spriteEventListener( event )

        if event.phase == "ended" then
            explosion.active = false -- Have it cleaned up by the game.
        end
    end

   explosion.animation:addEventListener( "sprite", spriteEventListener )

    table.insert( gExplosions.onscreen, explosion )

    playSound( "explosion" )

end

--==============================================================================
-- Function: createPowerUp( powerUpType (string),
--                          x (number),
--                          y (number) )
-- Author:   Kevin Harris
-- Modified: September 25, 2013
-- Returns:  Nothing
-- Descript: Creates a power up.
--==============================================================================
function createPowerUp( powerUpType, x, y )

    -- Turn the type name into a type index that points into the types table.
    -- This allows the level file to use easy to read names, such as "shields",
    -- while the game can use an index, such as 1, which is faster.

    local imageTypesIndex = 0

	for i,v in ipairs( gSprites.imageTypes ) do

        if v.imageType == powerUpType then
            imageTypesIndex = i
        end

    end

    local powerUp =
    {
		powerUp = powerUpType, -- Have the powerUpType name double as the powerUp identifier.
		imageTypesIndex = imageTypesIndex,
        x = x,
        y = y,
        active = true
    }

	powerUp.image = display.newImageRect( "images/" .. gSprites.imageTypes[powerUp.imageTypesIndex].imageFile, 
			                              gSprites.imageTypes[powerUp.imageTypesIndex].width, 
			                              gSprites.imageTypes[powerUp.imageTypesIndex].height )
	powerUp.image.x = powerUp.x
	powerUp.image.y = powerUp.y
	
    table.insert( gPowerUps.onscreen, powerUp )

end

--==============================================================================
-- Function: fireEnemyProjectile( x (number),
--                                y (number) )
-- Author:   Kevin Harris
-- Modified: December 17, 2014
-- Returns:  Nothing
-- Descript:
--==============================================================================
function fireEnemyProjectile( imageType, x, y )

    local imageTypesIndex = 0

    for i,v in ipairs( gSprites.imageTypes ) do

        if v.imageType == imageType then
            imageTypesIndex = i
        end

    end

    if imageTypesIndex == 0 then
        print( "Error calling fireEnemyProjectile() - Could not find an image type of '"
        .. imageType .. "' Has this image type been added to the " ..
        "ImageTypes.csv file?" )
    end
	
    -- Aim enemy projectiles at the player's midpoint.
    local targetX = gPlayer.x + (gPlayer.images.fighter.width / 2)
    local targetY = gPlayer.y + (gPlayer.images.fighter.height / 2)

	local animation = display.newSprite( gImageSheets[imageType], gSequenceData[imageType] )
	animation.x = x
	animation.y = y
	animation:play()

    local projectile =
    {
        weapon = imageType, -- Have the imageType name double as the weapon identifier.
        animation = animation,
        x = x,
        y = y,

        directionVector =
        {
            x = targetX - x,
            y = targetY - y
        },

        speed = 200,
        damage = 10,
        active = true
    }

    -- Normalize the direction vector to unit length.
    projectile.directionVector = normalizeVector( projectile.directionVector )

    table.insert( gProjectiles.enemy, projectile )

    playSound( "plasma" )

end

--==============================================================================
-- Function: firePlayerProjectile( weaponType (string) )
-- Author:   Kevin Harris
-- Modified: September 25, 2013
-- Returns:  Nothing
-- Descript: Fires a player projectile from the player's fighter position plus
--           some offset.
--==============================================================================
function firePlayerProjectile( weaponType )

    local currentTime = system.getTimer()

    if gPreviousTime == nil then
        gPreviousTime = currentTime
    end

    if currentTime - gPreviousTime < gPlayer.rateOfFire then
        -- Too soon to fire - return early.
        return
    else
        -- Enough time has elapsed - fire!
        gPreviousTime = currentTime
    end

    if weaponType == "missile" and gPlayer.numMissiles <= 0 then
        return
    end

    -- Player fire simply goes straight out of the ship and proceeds to the right!
    -- This may change in the future depending on new weapons.
    local targetX = gScreenWidth
    local targetY = gPlayer.y

    local projectile =
    {
        weapon = weaponType, -- Have the weaponType name double as the weapon identifier.
        x = gPlayer.x + 90,
        y = gPlayer.y + 25,
        active = true,
		addedToDisplay = false
    }

    if projectile.weapon == "laser" then

       projectile.speed = 400
       projectile.damage = 1
	   projectile.image = display.newImage( "images/laser.png" )

       playSound( "laser" )

    elseif projectile.weapon == "missile" then

        projectile.speed = 25
        projectile.damage = 10
		projectile.image = display.newImage( "images/missile.png" )

        playSound( "missile" )

        gPlayer.numMissiles = gPlayer.numMissiles - 1

        print("MISSILES: " .. gPlayer.numMissiles)

    elseif projectile.weapon == "bomb" then
        projectile.speed = 0
        projectile.damage = 100
        projectile.image = display.newImage("images/shields.png")

        playSound("missile")
    end
	
	projectile.image.x = projectile.x
	projectile.image.y = projectile.y
	
    table.insert( gProjectiles.player, projectile )
end

--==============================================================================
-- Function: firePlayerProjectile( weaponType (string) )
-- Author:   Kevin Harris
-- Modified: September 25, 2013
-- Returns:  Nothing
-- Descript: Fires a player projectile from the player's fighter position plus
--           some offset.
--==============================================================================
function fireBomb()

    local currentTime = system.getTimer()

    if gPreviousTime == nil then
        gPreviousTime = currentTime
    end

    if currentTime - gPreviousTime < gPlayer.rateOfFire then
        -- Too soon to fire - return early.
        return
    else
        -- Enough time has elapsed - fire!
        gPreviousTime = currentTime
    end

    local bomb =
    {
        timeToDie = currentTime + 1000,
        x = gPlayer.x + gPlayer.images.fighter.width,
        y = gPlayer.y,
        active = true,
        addedToDisplay = false
    }
    print("Time to die: " .. bomb.timeToDie)
    bomb.damage = 100
    bomb.image = display.newImage("images/shields.png")

    bomb.image.x = bomb.x
    bomb.image.y = bomb.y

    table.insert( gBombs.onscreen, bomb )
end
