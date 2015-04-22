--==============================================================================
-- File:     delete_functions.lua
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Descript: A collection of delete functions to be used by sprites that wish
--           to do something special just before they get cleaned up and removed
--           from play.
--==============================================================================

--==============================================================================
-- Function: deleteDefault( sprite (table), dt (number) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  Nothing
-- Descript: The default delete function simply adds the points value to the 
--           player's score if the sprite was destroyed by the player.
--==============================================================================
function deleteDefault( sprite, dt )

    if sprite.destroyedByPlayer then
        gPlayer.score = gPlayer.score + sprite.points

        print("SCORE: " .. gPlayer.score)
    end

end

--==============================================================================
-- Function: deletePlus500( sprite (table), dt (number) )
-- Author:   Kevin Harris
-- Modified: February 9, 2015
-- Returns:  Nothing
-- Descript: This delete function spawns a +500 point bonus sprite that 
--           automatically seeks toward the player's score and adds itself to 
--           player's score when it hits the score on-screen.
--==============================================================================
function deletePlus500( sprite, dt )

    if not sprite.destroyedByPlayer then
        return
    end

    local imageTypesIndex = 0

    for i,v in ipairs( gSprites.imageTypes ) do

        if v.imageType == "plus500" then
            imageTypesIndex = i
        end

    end

    if imageTypeAsIndex == 0 then
        print( "Error calling deletePlus500() - Could not find an image type " .. 
        "of 'plus500'. Has this image type been added to the ImageTypes.csv file?" )
    end

    local newSprite = {}

    newSprite.imageTypesIndex = imageTypesIndex
    newSprite.update = assignUpdateFunction( "updateSeekScore" )
    newSprite.delete = assignDeleteFunction( "deleteDefault" )
    newSprite.destroyedByPlayer = true
    newSprite.x = sprite.x
    newSprite.y = sprite.y
    newSprite.speed = 400
    newSprite.points = 500
    newSprite.rateOfFire = 0
    newSprite.shields = 0
    newSprite.maxShields = 0
    newSprite.active = true
    
    newSprite.image = display.newImageRect( "images/" .. gSprites.imageTypes[newSprite.imageTypesIndex].imageFile, 
                                            gSprites.imageTypes[newSprite.imageTypesIndex].width, 
                                            gSprites.imageTypes[newSprite.imageTypesIndex].height )
    newSprite.image.anchorX = 0
    newSprite.image.anchorY = 0
    newSprite.image.x = newSprite.x
    newSprite.image.y = newSprite.y

    table.insert( gSprites.onscreen, newSprite )

end

--==============================================================================
-- Function: assignDeleteFunction( functionName (string) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  A delete function.
-- Descript: Given a function name, returns an delete function to be used to
--           delete a sprite. If nil is passed - the 'deleteDefault'
--           function will be returned.
--==============================================================================
function assignDeleteFunction( functionName )

    if functionName == nil or functionName == "deleteDefault" then
        return deleteDefault
    elseif functionName == "deletePlus500" then
        return deletePlus500
    else
        print( "Error calling assignUpdateFunction() - Unknown function name '" .. functionName .. "' passed." )
        return updateDefault
    end

end
