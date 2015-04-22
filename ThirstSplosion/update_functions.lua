--==============================================================================
-- File:     update_functions.lua
-- Author:   Kevin Harris
-- Modified: September 25, 2013
-- Descript: A collection of update functions to be used by sprites that wish
--           to do something special during game play.
--==============================================================================

--==============================================================================
-- Function: updateDefault( sprite (table), dt (number) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  Nothing
-- Descript: Move the sprite from the right side of screen to the left
--           side via its speed. This is the default for obstacles and any 
--           sprite that does not set an update function.
--==============================================================================
function updateDefault( sprite, dt )

    -- Have the sprite move forward.
    sprite.x = sprite.x - sprite.speed * dt

end

--==============================================================================
-- Function: updateBlocking( sprite (table), dt (number) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  Nothing
-- Descript: Move the sprite from the right side of screen to the left
--           side via its speed, but also have it move up and down in a blocking
--           motion.
--==============================================================================
function updateBlocking( sprite, dt )

    -- One-time init.
    if sprite.movingUp == nil then
        sprite.movingUp = true
        sprite.midPoint = sprite.y + gSprites.imageTypes[sprite.imageTypesIndex].width / 2
    end

    -- Have the sprite move forward.
    updateDefault( sprite, dt )

    -- Now, have the sprite move up and then down.
    if sprite.movingUp then

        sprite.y = sprite.y - sprite.speed * dt

        if sprite.y < sprite.midPoint - 100 or sprite.y < 0 then
            sprite.movingUp = false
        end

    else

        sprite.y = sprite.y + sprite.speed * dt

        if sprite.y > sprite.midPoint + 100 or 
           (sprite.y + gSprites.imageTypes[sprite.imageTypesIndex].height) > display.contentHeight then
            sprite.movingUp = true
        end

    end

end

--==============================================================================
-- Function: updateBlockingAndFiring( sprite (table), dt (number) )
-- Author:   Kevin Harris
-- Modified: September 25, 2013
-- Returns:  Nothing
-- Descript: Move the sprite from the right side of screen to the left
--           side via its speed, but also have it move up and down in a blocking
--           motion while firing projectiles at a fixed rate.
--==============================================================================
function updateBlockingAndFiring( sprite, dt )

    -- One-time init.
    if sprite.countDownToFire == nil then

        sprite.countDownToFire = 0
        
        if sprite.rateOfFire == nil then

            print( "Error calling updateBlockingAndFiring() - This update function " .. 
            "requires that the sprite set 'rateOfFire' to some number, but it was not set." ..
            "Setting 'rateOfFire' to 1." )

            sprite.rateOfFire = 1

        end

    end

    -- Have the sprite move forward and up and down.
    updateBlocking( sprite, dt )

    -- Have the sprite fire a weapon.
    if sprite.rateOfFire > 0 and gPlayer.active then

        sprite.countDownToFire = sprite.countDownToFire + dt

        if sprite.countDownToFire >= sprite.rateOfFire then

            fireEnemyProjectile( "plasmaShot",
                                 sprite.x + gSprites.imageTypes[sprite.imageTypesIndex].weaponOffsetX,
                                 sprite.y + gSprites.imageTypes[sprite.imageTypesIndex].weaponOffsetY )

            sprite.countDownToFire = 0
    
        end

    end

end

--==============================================================================
-- Function: updateSeekUntilPassed( sprite (table), dt (number) )
-- Author:   Kevin Harris
-- Modified: September 25, 2013
-- Returns:  Nothing
-- Descript: Move the sprite toward the player's current position via its 
--           speed until the sprite has past the player's x position.
--           Once the sprite has past the player's x position - simply move 
--           the sprite from the right side of screen to the left side via 
--           its speed.
--==============================================================================
function updateSeekUntilPassed( sprite, dt )

    if gPlayer.x < sprite.x and gPlayer.active then

        -- If the sprite hasn't passed up the player - aim sprite at 
        -- player's mid point.
        local targetX = gPlayer.x + gPlayer.images.fighter.width / 2
        local targetY = gPlayer.y + gPlayer.images.fighter.height / 2

        directionVector =
        {
            x = targetX - sprite.x,
            y = targetY - sprite.y
        }

        -- Normalize the direction vector to unit length.
        directionVector = normalizeVector( directionVector )

        sprite.x = sprite.x + directionVector.x * (sprite.speed * dt)
        sprite.y = sprite.y + directionVector.y * (sprite.speed * dt)

    else

        -- If the player has already left this sprite behind - do a regular update.
        updateDefault( sprite, dt )

    end

end

--==============================================================================
-- Function: updateSeekScore( sprite (table), dt (number) )
-- Author:   Kevin Harris
-- Modified: April 14, 2015
-- Returns:  Nothing
-- Descript:
--==============================================================================
function updateSeekScore( sprite, dt )

    local targetX = (display.contentWidth / 2) - 25
    local targetY = 25

    local directionVector =
    {
        x = targetX - sprite.x,
        y = targetY - sprite.y
    }

    -- Normalize the direction vector to unit length.
    directionVector = normalizeVector( directionVector )

    sprite.x = sprite.x + directionVector.x * (sprite.speed * dt)
    sprite.y = sprite.y + directionVector.y * (sprite.speed * dt)

    if sprite.y < 25 then
        sprite.active = false
    end

end

--==============================================================================
-- Function: assignUpdateFunction( functionName (string) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  An update function.
-- Descript: Given a function name, returns an update function to be used to
--           update a sprite. If nil is passed - the 'updateDefault'
--           function will be returned.
--==============================================================================
function assignUpdateFunction( functionName )

    if functionName == nil or functionName == "updateDefault" then
        return updateDefault
    elseif functionName == "updateBlocking" then
        return updateBlocking
    elseif functionName == "updateBlockingAndFiring" then
        return updateBlockingAndFiring
    elseif functionName == "updateSeekUntilPassed" then
        return updateSeekUntilPassed
    elseif functionName == "updateSeekScore" then
        return updateSeekScore
    else
        print( "Error calling assignUpdateFunction() - Unknown function name '" .. functionName .. "' passed." )
        return updateDefault
    end

end
