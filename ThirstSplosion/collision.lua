--==============================================================================
-- File:     collision.lua
-- Author:   Kevin Harris
-- Modified: September 25, 2013
-- Descript: Collision functions for rectangles and game sprites which contain
--           transparent pixels.
--==============================================================================

-- TODO: Can Corona build a collision map?
--[[
--==============================================================================
-- Function: newCollisionMap( imageFileName (string) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  collisionMap (table)
-- Descript: Creates a collision map or a 2D table of 1's and 0's where the
--           transparent pixels of a PNG image file map to a 0 and colored
--           pixels map to a 1?
--
--           The collsionMaps created by this function are intended for use by
--           the spritesCollide function.
--==============================================================================
function newCollisionMap( imageFileName )

    local imageData = love.image.newImageData( imageFileName )
    local width = imageData:getWidth()
    local height = imageData:getHeight()
    local collisionMap = {}

    -- Build a collision map as a table of row tables that contains 1's and 0's.
    -- A 1 means the pixel at this position is non-transparent and 0 means it
    -- transparent.
    for y = 1, height do

        collisionMap[y] = {}

        for x = 1, width do

            -- Use -1 since getPixel() starts indexing at 0 not 1 like Lua.
            local r, g, b, a = imageData:getPixel( x-1, y-1 )

            if a == 0 then
                collisionMap[y][x] = 0
            else
                collisionMap[y][x] = 1
            end

        end
    end

    return collisionMap

end
--]]

--==============================================================================
-- Function: rectsCollide( rect1x (number), 
--                         rect1y (number),
--                         rect1Width (number),
--                         rect1Height (number),
--                         rect2x (number),
--                         rect2y (number),
--                         rect2Width (number),
--                         rect2Height (number) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  true (boolean) if they collide or false (boolean) if they do not.
-- Descript: Test whether or not two rectangular regions collide by touching 
--          or overlapping?
--==============================================================================
function rectsCollide( rect1x, rect1y, rect1Width, rect1Height,
                       rect2x, rect2y, rect2Width, rect2Height )

  if((rect1x >= rect2x and rect1x <= rect2x + rect2Width) and (rect1y >= rect2y and rect1y <= rect2y + rect2Height)) or 
    ((rect1x + rect1Width>= rect2x and rect1x + rect1Width <= rect2x + rect2Width) and (rect1y >= rect2y and rect1y <= rect2y + rect2Height)) or
    ((rect1x >= rect2x and rect1x <= rect2x + rect2Width) and (rect1y + rect1Height>= rect2y and rect1y  + rect1Height<= rect2y + rect2Height)) or
    ((rect1x + rect1Width>= rect2x and rect1x + rect1Width <= rect2x + rect2Width) and (rect1y + rect1Height>= rect2y and rect1y  + rect1Height<= rect2y + rect2Height))  then
    return true
  end
  
  return false

end

--==============================================================================
-- Function: spritesCollide( sprite1x (number),
--                           sprite1y (number),
--                           sprite1Width (number),
--                           sprite1Height (number),
--                           sprite1CollisionMap (collisionMap),
--                           sprite2x (number),
--                           sprite2y (number),
--                           sprite2Width (number),
--                           sprite2Height (number),
--                           sprite2CollisionMap (collisionMap) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  true (boolean) if they collide or false (boolean) if they do not.
-- Descript: Test whether or not two game sprites collide via per-pixel collision
--          using the transparent pixels of PNG image files?
--
--          Use the function newCollisionMap() to create the collisionMaps
--          required as arguments sprite1CollisionMap and sprite2CollisionMap.
--==============================================================================
function spritesCollide( sprite1x, sprite1y, sprite1Width, sprite1Height, sprite1CollisionMap,
                         sprite2x, sprite2y, sprite2Width, sprite2Height, sprite2CollisionMap )

--[[ For debugging only.
    if sprite1x == nil then
        print( "Error calling spritesCollide() - The argument sprite1x was nil." )
        return false
    end

    if sprite1y == nil then
        print( "Error calling spritesCollide() - The argument sprite1y was nil." )
        return false
    end

    if sprite1Width == nil then
        print( "Error calling spritesCollide() - The argument sprite1Width was nil." )
        return false
    end

    if sprite1Height == nil then
        print( "Error calling spritesCollide() - The argument sprite1Height was nil." )
        return false
    end

    if sprite2x == nil then
        print( "Error calling spritesCollide() - The argument sprite2x was nil." )
        return false
    end
    
    if sprite2y == nil then
        print( "Error calling spritesCollide() - The argument sprite2y was nil." )
        return false
    end
    
    if sprite2Width == nil then
        print( "Error calling spritesCollide() - The argument sprite2Width was nil." )
        return false
    end
    
    if sprite2Height == nil then
        print( "Error calling spritesCollide() - The argument sprite2Height was nil." )
        return false
    end
--]]

    -- First, we do a simple bounding box collision check. This will let
    -- us know if the two sprites overlap in any way.
    if not rectsCollide( sprite1x, sprite1y, sprite1Width, sprite1Height,
                         sprite2x, sprite2y, sprite2Width, sprite2Height ) then
        return false
    end

    -- If we made it this far, our two sprites definitely touch or overlap,
    -- but that doesn't mean that that we have an actual collision between
    -- two non-transparent pixels. If we have two collision maps we can 
    -- continue refining out test. If not, we simply return true.
    if sprite1CollisionMap == nil or sprite2CollisionMap == nil then
       return true
    end

    -- Loop through each row of sprite1's collision map and check it against
    -- sprite2's corresponding collision map row.
    for indexY = 1, sprite1Height do

        local screenY = math.floor( (sprite1y + indexY) - 1  )

        if screenY > sprite2y and screenY <= sprite2y + sprite2Height then

            -- Some, or all, of the current row (Y) of sprite1's collision map overlaps
            -- sprite2's collision map. Calculate the start and end indices (X) for each
            -- row, so we can test this area of overlap for a collision of 
            -- non-transparent pixels.

            local y1 = math.floor( indexY )
            local y2 = 1

            if screenY > sprite2y then
                y2 = math.floor( screenY - sprite2y ) + 1
            elseif screenY < sprite2y then
                y2 = math.floor( sprite2y - screenY )
            end

            local sprite1Index1 = 1
            local sprite1Index2 = sprite1Width
            local sprite2Index1 = 1
            local sprite2Index2 = sprite2Width

            if sprite1x < sprite2x then

               sprite1Index1 = math.floor( sprite2x - sprite1x ) + 1
               sprite1Index2 = sprite1Width

               sprite2Index1 = 1
               sprite2Index2 = math.floor( (sprite1x + sprite1Width) - sprite2x ) + 1

               -- If the sprites being tested are of different sizes it's possible
               -- for this index to get too big - so clamp it.
               if sprite2Index2 > sprite2Width then
                  sprite2Index2 = sprite2Width
               end

            elseif sprite1x > sprite2x then

               sprite1Index1 = 1
               sprite1Index2 = math.floor( (sprite2x + sprite2Width) - sprite1x ) + 1

               -- If the sprites being tested are of different sizes it's possible
               -- for this index to get too big - so clamp it.
               if sprite1Index2 > sprite1Width then
                  sprite1Index2 = sprite1Width
               end

               sprite2Index1 = math.floor( sprite1x - sprite2x ) + 1
               sprite2Index2 = sprite2Width

            else -- sprite1x == sprite2x

               -- If the two sprites have the same x position - the width of 
               -- overlap is simply the shortest width.
               shortest = sprite1Width

               if sprite2Width < shortest then
                  shortest = sprite2Width
               end

               sprite1Index1 = 1
               sprite1Index2 = shortest

               sprite2Index1 = 1
               sprite2Index2 = shortest

            end

            local index1 = sprite1Index1
            local index2 = sprite2Index1

            while index1 < sprite1Index2 and index2 < sprite2Index2 do

--[[ For debugging only.
                if y1 <= 0 or index1 > sprite1Width then
                    print( "Error calling spritesCollide() - Resulting indices out of bounds: y1 = "
                    .. y1 .. ", index1 = " .. index1 )
                    return false
                end

                if y2 <= 0 or index2 > sprite2Width then
                    print( "Error calling spritesCollide() - Resulting indices out of bounds: y2 = "
                    .. y2 .. ", index2 = " .. index2 )
                    return false
                end
--]]

                if sprite1CollisionMap[y1][index1] == 1 and sprite2CollisionMap[y2][index2] == 1 then
                    return true -- We have a collision of two non-transparent pixels!
                end

                index1 = index1 + 1
                index2 = index2 + 1

            end

        end

    end

    return false -- We do NOT have a collision of two non-transparent pixels.

end
