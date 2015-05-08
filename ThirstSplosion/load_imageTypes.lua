--==============================================================================
-- File:     load_imageTypes.lua
-- Author:   Kevin Harris
-- Modified: April 15, 2015
-- Descript: A collection of functions for loading image type data from disc.
--==============================================================================

if USE_TEMP_TABLES then
    require( "data.imageTypes_table" )
end

--==============================================================================
-- Function: parseDelimitedString( valueString (string), separator (string) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  New index table of strings.
-- Descript: Parses through a string of values (gathered from a CSV file)
--           and creates an index table from them.
--==============================================================================
function parseDelimitedString( valueString, separator )

--Check to make sure that valueString is a string
if type(valueString) ~= "string" then
    print("Please input valid strings for the parameters")
    return {}
else
    
    local sep = ","

    --Sanitize the string input and remove all spaces
    local sanitizedString = string.gsub(valueString, " ", "")

    --If the separator is a valid string then replace "," as the default separator
    if type(separator) == "string" then
        sep = separator
    else
        print("Please input a string as the second parameter")
        print("Otherwise ',' will be used as the default separator")
    end

    --Initialize the table
    local myTable = {}
    --Hold the current string
    local curString = sanitizedString

    local beginIndex = 0
    local endIndex = 0
    local newValue = ""

    --While there is another instance of separator
    while  string.find(curString, sep) ~= nil do
        --Find the beginning and end of the delimiter
        beginIndex, endIndex = string.find(curString, sep)

        --Get the string between the beginning of the total string and the beginning
        --of the separator
        newValue = string.sub(curString, 1, beginIndex - 1)

        --If the value is a non empty string then insert it into the table
        if newValue ~= "" then
            table.insert(myTable, newValue)
        end

        --Chop off the beginning of the current string up until the end of the separator
        curString = string.sub(curString, endIndex + 1, string.len(curString))
    end

    --Insert the final value into the table unless it's an empty string
    if curString ~= "" then
        table.insert(myTable,curString)
    end

    return myTable

    end

end

--==============================================================================
-- Function: readCSVFile( fileName (string) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  The table and number of lines.
-- Descript: Reads a CSV (Comma Separated Values) formatted data file into an
--           index table.
--==============================================================================
function readCSVFile( fileName )

    --Open the file, catch any errors
    local myFile, myError = io.open(fileName, "r")

    --Print an error and return if there is an error
    if myError ~= nil then
        print("Call to io.open failed: " .. myError .. "\n")
        return
    end

    --Create the table to be used
    local myTable = {}
    local myTemp = ""

    --For each line in the file, insert it into a table
    for line in myFile:lines() do
        table.insert(myTable, line)
    end

    --Close the file.  Very important.
    myFile:close()

    --Return the table of entries
    return myTable

end

--==============================================================================
-- Function: loadCSVData( fileName (string) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  dataTable (table)
-- Descript: Builds Lua tables from CSV data and then loads them into a single
--           index table.
--==============================================================================
function loadCSVData( fileName )

--Add .csv to the file type if it does not already exist
    local myFile = fileName

    if string.find(fileName, ".csv") == nil then
        myFile = fileName .. ".csv"
    end

    --Set up local variables
    local csvLines = readCSVFile( myFile )
    local myTables = {}
    local myTempTable = {}
    local myParsedTable = {}
    local tempNumber = 0

    --Find the key header values for the CSV
    local myKeys = parseDelimitedString(csvLines[1], ',')

    --For each of the remaining entries in the table
    for i = 2, #csvLines do
        --Take the entry and parse it into its pieces
        myParsedTable = parseDelimitedString(csvLines[i], ',')
        myTempTable = {}

        --For each of those pieces
        for j = 1, #myKeys do

            --Check to see in the incoming value is a number
            tempNumber = tonumber(myParsedTable[j])

            --If it is, store it as a number with its appropriate key
            if tempNumber ~= nil then
                myTempTable[myKeys[j]] = tempNumber

            --Otherwise store it as whatever it was.
            else
                myTempTable[myKeys[j]] = myParsedTable[j]
            end
        end
        --Add the tables of pairs to the table of tables to be returned
        table.insert(myTables, myTempTable)


    end

    return myTables

end

--==============================================================================
-- Function: loadImageTypes( fileName (string) )
-- Author:   Kevin Harris
-- Modified: September 1, 2010
-- Returns:  dataTable (table)
-- Descript: Load data about the game's image types into an index table.
--==============================================================================
function loadImageTypes( fileName )

    local typesTable = nil

    if USE_TEMP_TABLES then
        typesTable = gImageTypesTable
    else
        typesTable = loadCSVData( fileName )
    end

    for i,v in ipairs( typesTable ) do

		v.width = tonumber( v.width )
        v.height = tonumber( v.height )

-- TODO: Can Corona build a collision map?
--[[
        if type( v.useCollisionMap ) == "string" then
            if v.useCollisionMap == "TRUE" then
                v.useCollisionMap = true
                v.collisionMap = newCollisionMap( "Images/" .. v.imageFile )
            else
                v.useCollisionMap = false
            end
        end
--]]

        if type( v.obstacle ) == "string" then
            if v.obstacle == "TRUE" then
                v.obstacle = true
            else
                v.obstacle = false
            end
        end

        if type( v.background ) == "string" then
            if v.background == "TRUE" then
                v.background = true
            else
                v.background = false
            end
        end

        v.weaponOffsetX = tonumber( v.weaponOffsetX )
        v.weaponOffsetY = tonumber( v.weaponOffsetY )

        if type( v.animated ) == "string" then
            if v.animated == "TRUE" then
                v.animated = true
            else
                v.animated = false
            end
        end

        v.animationDuration = tonumber( v.animationDuration )
        v.numFrames = tonumber( v.numFrames )
        
        if v.animated then

			local options =
			{
			    -- Required parameters
			    width = v.width,
			    height = v.height,
			    numFrames = v.numFrames
			}

			local imageSheet = graphics.newImageSheet( "images/" .. v.imageFile, options )

			local loopCount = 0
			local loopDirection = "forward"

			if v.animationMode == "loop_forever" then
				loopCount = 0
			elseif string.find( v.animationMode, "loop_") then
				-- Chop off the "loop_" part and the remaining substring should be a number.
				local numberOfLoops = string.gsub( v.animationMode, "loop_", "" )
				loopCount = tonumber(numberOfLoops)
				
				if loopCount == nil then
					print( "Error calling loadImageTypes() - animationMode was set to 'loop_#', but the # part did not convert to a number!" )
					loopCount = 0
				end
			elseif v.animationMode == "once" then
				loopCount = 1
			elseif v.animationMode == "bounce" then
				loopDirection = "bounce"
			elseif v.animationMode == "bounce_forever" then
				loopDirection = "bounce"
				loopCount = 0
			end

			local sequenceData =
			{
			    name = "seq1",
			    start = 1,
			    count = v.numFrames,
			    time = v.animationDuration,   -- Optional. In ms.  If not supplied, then sprite is frame-based.
			    loopCount = loopCount,        -- Optional. Default is 0 (loop indefinitely)
			    loopDirection = loopDirection -- Optional. Values include: "forward","bounce"
			}
		
			gImageSheets[v.imageType] = imageSheet
			gSequenceData[v.imageType] = sequenceData

        end

    end

    return typesTable

end
