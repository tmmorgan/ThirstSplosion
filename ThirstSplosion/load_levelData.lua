--==============================================================================
-- File:     load_levelData.lua
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Descript: A collection of functions for loading game level data from disc.
--==============================================================================

if USE_TEMP_TABLES then
    require( "data.Level1_table" )
end

--==============================================================================
-- Function: parseKeyValueString( dataString (string) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  keyValueTable (table)
-- Descript: Takes a string loaded from loadLevelData() and parses it into a
--           separated key and value pair. For example, if the dataString passed
--           in is:
--
--               "mapId = 1"
--
--           This function will return a table laid out like so:
--
--               dataTable =
--               {
--                   key = "mapId",
--                   value = 1
--               }
--
--           Note, if the value, as a string, can be coerced into a number -
--           it will be.
--==============================================================================
function parseKeyValueString( dataString )

--Check to make sure that the item passed in is actually a string
    if type(dataString) ~= "string" then
        print("Please imput a valid string")
        return nil
    end

    --Check to make sure there is a '=' to parse
    if string.find(dataString, "=") == nil then
        print("Please input a key value pair of format 'key = value'")
        return nil
    end

    local myNumberValue = 0

    local sanitizedString = string.gsub(dataString, " ", "")
    local myKey = string.sub(sanitizedString, 0, string.find(sanitizedString, "=") - 1)
    local myValue = string.sub(sanitizedString, string.find(sanitizedString, "=") + 1, string.len(sanitizedString))

    if tonumber(myValue) ~= nil then
        return {key = myKey, value = tonumber(myValue)}
    else
        return {key = myKey, value = myValue}
    end

end

--==============================================================================
-- Function: sortLesserByTimeToSpawn( a, b )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  true (boolean) if the timeToSpawn variable of argument 'a' is lesser
--           than the timeToSpawn variable of argument 'b', or false (boolean)
--           if not.
-- Descript: Custom sorter for game sprites based on timeToSpawn.
--==============================================================================
function sortLesserByTimeToSpawn( a, b )

    return a.timeToSpawn < b.timeToSpawn

end

--==============================================================================
-- Function: loadLevelData( fileName (string) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  levelDataTable (table)
-- Descript: Loads the game from a saved game file.
--==============================================================================
function loadLevelData( fileName )

    if USE_TEMP_TABLES then
        return gLevelDataTable
    end

    if fileName == nil then
        print("Error calling loadLevelData() - The argument fileName was nil.")
        return
    end

    if type( fileName ) ~= "string" then
        print("Error calling loadLevelData() - The argument fileName must be a string.")
        return
    end

    -- Check to make sure the extension is on the fileName. If not, add it.
    if string.find( fileName, ".level", -6 ) == nil then
        fileName = fileName .. ".level"
    end

    -- Grab all the lines in the file and construct a table

    local indxLD = 0
    local levelDataTable = {}

    local indxSprite = 0
    local spriteTable = {}

    local indxMap1 = 0
    local indxMap2 = 0
    local mapTable = {}

    local startingNewTable = false
    local processSprite = false
    local processMapLevelData = false

    -- For all the lines in the file.
    for line in io.lines( fileName ) do

        if line == "" then

            -- NO-OP - Don't process blank lines.

        elseif string.find( line, "%#" ) ~= nil then

            -- NO-OP - Don't process lines that are comments.

        elseif line == "BEGIN_LEVEL_MAP" then

            -- BEGIN_LEVEL_MAP - Switch modes to loading the level's map data.
            processMapLevelData = true

        elseif processMapLevelData then

            if line == "BEGIN_MAP_SECTION" then

                -- If the line says "BEGIN_MAP_SECTION", then start a new table
                -- for the next map section.
                startingNewTable = true
                indxMap2 = 0

            else

                -- It must be a row of map ids...

                if startingNewTable then
                    indxMap1 = indxMap1 + 1
                    startingNewTable = false
                end

                -- If the new index is not already defined as a table - do so.
                if mapTable[indxMap1] == nil then
                    mapTable[indxMap1] = {}
                end

                indxMap2 = indxMap2 + 1
                mapTable[indxMap1][indxMap2] = {}

                -- Cut the long string representing the map's row into single chars.
                -- For example, turn "11221111" into a sub-table that contains
                -- "1", "1", "2", "2", "1", "1", "1", "1".
                for i = 1, string.len( line ) do
                    mapTable[indxMap1][indxMap2][i] = string.sub( line, i, i )
                end

            end

        else

            -- If we're not yet processing the map sections - we must still be 
            -- defining the game sprites.

            if line == "BEGIN_SPRITE" then

                -- If we hit BEGIN_SPRITE we know that the current working
                -- table is done and we need to get ready to make a new table 
                -- is required.
                processSprite = true
                startingNewTable = true

            elseif processSprite then

                if startingNewTable then
                    indxSprite = indxSprite + 1
                    startingNewTable = false
                end

                -- If the output index is not defined as a table, do so
                if spriteTable[indxSprite] == nil then
                    spriteTable[indxSprite] = {}
                end

                -- If the line isn't blank then read it in
                local tmp = parseKeyValueString( line )

                -- Add the key and value from the parsed line
                spriteTable[indxSprite][tmp.key] = tmp.value

            end

        end

    end

    --
    -- Turn the map data into actual level data.
    --

    local totalColumnCount = 0
    local maxColumnForCurrentSection = 0

    for i = 1, #mapTable do

        maxColumnForCurrentSection = 0

        for j = 1, #mapTable[i] do

            for k = 1, #mapTable[i][j] do

                for x = 1, #spriteTable do

                    if spriteTable[x].mapId ~= nil then

                        if mapTable[i][j][k] == tostring( spriteTable[x].mapId ) then

                            -- Create a new spriteTable entry to represent
                            -- what has been identified in the mapTable.
                            indxLD = indxLD + 1
                            levelDataTable[indxLD] = {}

                            -- Use the spriteTable entry that matches the mapId
                            -- to fill-in our new levelDataTable entry, but don't
                            -- copy over the mapId - that is only used by table 
                            -- entries that represent map objects.
                            for k,v in pairs( spriteTable[x] ) do

                                -- Copy over everything but mapId.
                                if k ~= "mapId" then
                                    levelDataTable[indxLD][k] = v
                                end

                            end

                            levelDataTable[indxLD].x = display.contentWidth -- All objects start just off the screen's right side.
                            levelDataTable[indxLD].y = math.floor( (j-1) * 64 ) -- Map positions are all 64x64.
                            levelDataTable[indxLD].timeToSpawn = totalColumnCount + k -- Time to spawn is in whole seconds.

                            -- We don't know how long each map section is going to be, so
                            -- keep track of its max length or number of columns.
                            if k > maxColumnForCurrentSection then
                                maxColumnForCurrentSection = k
                            end

                            break

                        end

                    end

                end

            end

        end

        totalColumnCount = totalColumnCount + maxColumnForCurrentSection

    end
	
    -- For the entire length of the level, create a series of column markers which
    -- can be used to align newly spawning game objects. They will not be rendered
    -- unless debugging is on.
    for i = 1, totalColumnCount do

        indxLD = indxLD + 1
        levelDataTable[indxLD] = {}

        levelDataTable[indxLD].imageType = "columnMarker"
        levelDataTable[indxLD].columnMarker = true
        levelDataTable[indxLD].updateFunction = "updateDefault"
        levelDataTable[indxLD].x = display.contentWidth-- + 64
        levelDataTable[indxLD].y = (display.contentHeight / 2) - 32
        levelDataTable[indxLD].speed = 64
		levelDataTable[indxLD].points = 0
		levelDataTable[indxLD].shields = 0
		levelDataTable[indxLD].maxShields = 0
        levelDataTable[indxLD].timeToSpawn = i -- Each column is 1 second into the level.

    end

    -- Add a spawned property to each one so we can mark them for
    -- cleanup once they've spawned into the level.
    for i,v in ipairs( levelDataTable ) do
        v.spawned = false
    end

    -- Sort the table so game objects with smaller timeToSpawn values can be found
    -- before game objects with larger timeToSpawn values.
    table.sort( levelDataTable, sortLesserByTimeToSpawn )

    return levelDataTable

end
