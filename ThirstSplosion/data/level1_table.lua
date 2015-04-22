--==============================================================================
-- File:     Level1_table.lua
-- Author:   Kevin Harris
-- Modified: July 20, 2011
-- Descript: A table of level data for use by the game until the student has
--           successfully implemented the functions in load_levelData.lua.
--           If the student is successful, this table will be automatically
--           created from the data file "Level1.level" by loadLevelData().
--           Go to "main.lua" and set USE_TEMP_TABLES to false to disable the
--           loading of this temp table.
--==============================================================================

gLevelDataTable =
{

    -- Unnamed table at index [1]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        spawned = false,
        timeToSpawn = 1,
    },


    -- Unnamed table at index [2]
    {
        y = 320,
        x = 1024,
        imageType = "enemy1",
        timeToSpawn = 1,
        speed = 150,
        points = 10,
        spawned = false,
        shields = 5,
    },


    -- Unnamed table at index [3]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 1,
        spawned = false,
    },


    -- Unnamed table at index [4]
    {
        y = 512,
        x = 1024,
        imageType = "enemy1",
        timeToSpawn = 1,
        speed = 150,
        points = 10,
        spawned = false,
        shields = 5,
    },


    -- Unnamed table at index [5]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 1,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [6]
    {
        y = 128,
        x = 1024,
        imageType = "enemy1",
        timeToSpawn = 1,
        speed = 150,
        points = 10,
        spawned = false,
        shields = 5,
    },


    -- Unnamed table at index [7]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 2,
        spawned = false,
    },


    -- Unnamed table at index [8]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 2,
        spawned = false,
    },


    -- Unnamed table at index [9]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 2,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [10]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 3,
        spawned = false,
    },


    -- Unnamed table at index [11]
    {
        spawned = false,
        shields = 5,
        timeToSpawn = 3,
        y = 256,
        x = 1024,
        imageType = "enemy1",
        speed = 150,
        points = 10,
        updateFunction = "updateSeekUntilPassed",
    },


    -- Unnamed table at index [12]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 3,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [13]
    {
        spawned = false,
        shields = 5,
        timeToSpawn = 3,
        y = 448,
        x = 1024,
        imageType = "enemy1",
        speed = 150,
        points = 10,
        updateFunction = "updateSeekUntilPassed",
    },


    -- Unnamed table at index [14]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 3,
        spawned = false,
    },


    -- Unnamed table at index [15]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 4,
        spawned = false,
    },


    -- Unnamed table at index [16]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 4,
        spawned = false,
    },


    -- Unnamed table at index [17]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 4,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [18]
    {
        spawned = false,
        shields = 15,
        timeToSpawn = 5,
        powerUpType = "missiles",
        y = 320,
        x = 1024,
        imageType = "enemy2",
        speed = 75,
        points = 100,
        updateFunction = "updateBlocking",
    },


    -- Unnamed table at index [19]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 5,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [20]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 5,
        spawned = false,
    },


    -- Unnamed table at index [21]
    {
        spawned = false,
        shields = 15,
        timeToSpawn = 5,
        powerUpType = "missiles",
        y = 128,
        x = 1024,
        imageType = "enemy2",
        speed = 75,
        points = 100,
        updateFunction = "updateBlocking",
    },


    -- Unnamed table at index [22]
    {
        spawned = false,
        shields = 15,
        timeToSpawn = 5,
        powerUpType = "missiles",
        y = 512,
        x = 1024,
        imageType = "enemy2",
        speed = 75,
        points = 100,
        updateFunction = "updateBlocking",
    },


    -- Unnamed table at index [23]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 5,
        spawned = false,
    },


    -- Unnamed table at index [24]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 6,
        spawned = false,
    },


    -- Unnamed table at index [25]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 6,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [26]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 6,
        spawned = false,
    },


    -- Unnamed table at index [27]
    {
        y = 640,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 7,
        spawned = false,
    },


    -- Unnamed table at index [28]
    {
        y = 64,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 7,
        spawned = false,
    },


    -- Unnamed table at index [29]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 7,
        spawned = false,
    },


    -- Unnamed table at index [30]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 7,
        spawned = false,
    },


    -- Unnamed table at index [31]
    {
        y = 128,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 7,
        spawned = false,
    },


    -- Unnamed table at index [32]
    {
        y = 576,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 7,
        spawned = false,
    },


    -- Unnamed table at index [33]
    {
        y = 512,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 7,
        spawned = false,
    },


    -- Unnamed table at index [34]
    {
        y = 192,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 7,
        spawned = false,
    },


    -- Unnamed table at index [35]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 7,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [36]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 8,
        spawned = false,
    },


    -- Unnamed table at index [37]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 8,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [38]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 8,
        spawned = false,
    },


    -- Unnamed table at index [39]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 9,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [40]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 9,
        spawned = false,
    },


    -- Unnamed table at index [41]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 9,
        spawned = false,
    },


    -- Unnamed table at index [42]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 10,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [43]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 10,
        spawned = false,
    },


    -- Unnamed table at index [44]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 10,
        spawned = false,
    },


    -- Unnamed table at index [45]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 11,
        spawned = false,
    },


    -- Unnamed table at index [46]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 11,
        spawned = false,
    },


    -- Unnamed table at index [47]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 11,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [48]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 12,
        spawned = false,
    },


    -- Unnamed table at index [49]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 12,
        spawned = false,
    },


    -- Unnamed table at index [50]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 12,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [51]
    {
        spawned = false,
        shields = 5,
        timeToSpawn = 12,
        y = 128,
        x = 1024,
        imageType = "enemy1",
        speed = 150,
        points = 10,
        updateFunction = "updateSeekUntilPassed",
    },


    -- Unnamed table at index [52]
    {
        spawned = false,
        shields = 5,
        timeToSpawn = 12,
        y = 576,
        x = 1024,
        imageType = "enemy1",
        speed = 150,
        points = 10,
        updateFunction = "updateSeekUntilPassed",
    },


    -- Unnamed table at index [53]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 13,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [54]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 13,
        spawned = false,
    },


    -- Unnamed table at index [55]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 13,
        spawned = false,
    },


    -- Unnamed table at index [56]
    {
        spawned = false,
        shields = 5,
        timeToSpawn = 14,
        y = 256,
        x = 1024,
        imageType = "enemy1",
        speed = 150,
        points = 10,
        updateFunction = "updateSeekUntilPassed",
    },


    -- Unnamed table at index [57]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 14,
        spawned = false,
    },


    -- Unnamed table at index [58]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 14,
        spawned = false,
    },


    -- Unnamed table at index [59]
    {
        spawned = false,
        shields = 5,
        timeToSpawn = 14,
        y = 448,
        x = 1024,
        imageType = "enemy1",
        speed = 150,
        points = 10,
        updateFunction = "updateSeekUntilPassed",
    },


    -- Unnamed table at index [60]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 14,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [61]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 15,
        spawned = false,
    },


    -- Unnamed table at index [62]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 15,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [63]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 15,
        spawned = false,
    },


    -- Unnamed table at index [64]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 16,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [65]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 16,
        spawned = false,
    },


    -- Unnamed table at index [66]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 16,
        spawned = false,
    },


    -- Unnamed table at index [67]
    {
        y = 384,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 17,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [68]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 17,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [69]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 17,
        spawned = false,
    },


    -- Unnamed table at index [70]
    {
        y = 512,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 17,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [71]
    {
        y = 448,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 17,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [72]
    {
        y = 576,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 17,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [73]
    {
        y = 320,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 17,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [74]
    {
        y = 192,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 17,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [75]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 17,
        spawned = false,
    },


    -- Unnamed table at index [76]
    {
        y = 256,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 17,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [77]
    {
        y = 64,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 17,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [78]
    {
        y = 128,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 17,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [79]
    {
        y = 640,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 17,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [80]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 18,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [81]
    {
        y = 640,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 18,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [82]
    {
        y = 576,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 18,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [83]
    {
        y = 448,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 18,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [84]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 18,
        spawned = false,
    },


    -- Unnamed table at index [85]
    {
        y = 512,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 18,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [86]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 18,
        spawned = false,
    },


    -- Unnamed table at index [87]
    {
        y = 256,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 18,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [88]
    {
        y = 320,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 18,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [89]
    {
        y = 192,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 18,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [90]
    {
        y = 64,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 18,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [91]
    {
        y = 128,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 18,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [92]
    {
        y = 384,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 18,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [93]
    {
        y = 192,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 19,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [94]
    {
        y = 64,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 19,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [95]
    {
        y = 256,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 19,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [96]
    {
        y = 320,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 19,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [97]
    {
        y = 576,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 19,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [98]
    {
        y = 512,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 19,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [99]
    {
        y = 640,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 19,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [100]
    {
        y = 128,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 19,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [101]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 19,
        spawned = false,
    },


    -- Unnamed table at index [102]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 19,
        spawned = false,
    },


    -- Unnamed table at index [103]
    {
        y = 448,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 19,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [104]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 19,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [105]
    {
        y = 384,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 19,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [106]
    {
        y = 128,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 20,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [107]
    {
        y = 576,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 20,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [108]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 20,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [109]
    {
        y = 256,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 20,
        spawned = false,
        points = 10,
        shields = 2,
        powerUpType = "missiles",
    },


    -- Unnamed table at index [110]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 20,
        spawned = false,
    },


    -- Unnamed table at index [111]
    {
        y = 320,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 20,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [112]
    {
        y = 64,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 20,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [113]
    {
        y = 512,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 20,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [114]
    {
        y = 192,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 20,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [115]
    {
        y = 384,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 20,
        spawned = false,
        points = 10,
        shields = 2,
        powerUpType = "missiles",
    },


    -- Unnamed table at index [116]
    {
        y = 640,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 20,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [117]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 20,
        spawned = false,
    },


    -- Unnamed table at index [118]
    {
        y = 448,
        x = 1024,
        imageType = "energyBrick",
        timeToSpawn = 20,
        points = 10,
        spawned = false,
        shields = 2,
    },


    -- Unnamed table at index [119]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 21,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [120]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 21,
        spawned = false,
    },


    -- Unnamed table at index [121]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 21,
        spawned = false,
    },


    -- Unnamed table at index [122]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 22,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [123]
    {
        spawned = false,
        shields = 30,
        timeToSpawn = 22,
        rateOfFire = 2,
        powerUpType = "shields",
        updateFunction = "updateBlockingAndFiring",
        x = 1024,
        imageType = "enemy3",
        speed = 25,
        points = 150,
        y = 320,
    },


    -- Unnamed table at index [124]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 22,
        spawned = false,
    },


    -- Unnamed table at index [125]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 22,
        spawned = false,
    },


    -- Unnamed table at index [126]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 23,
        spawned = false,
    },


    -- Unnamed table at index [127]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 23,
        spawned = false,
    },


    -- Unnamed table at index [128]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 23,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [129]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 24,
        spawned = false,
    },


    -- Unnamed table at index [130]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 24,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [131]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 24,
        spawned = false,
    },


    -- Unnamed table at index [132]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 25,
        spawned = false,
    },


    -- Unnamed table at index [133]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 25,
        spawned = false,
    },


    -- Unnamed table at index [134]
    {
        spawned = false,
        shields = 30,
        timeToSpawn = 25,
        rateOfFire = 2,
        powerUpType = "shields",
        updateFunction = "updateBlockingAndFiring",
        x = 1024,
        imageType = "enemy3",
        speed = 25,
        points = 150,
        y = 128,
    },


    -- Unnamed table at index [135]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 25,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [136]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 26,
        spawned = false,
    },


    -- Unnamed table at index [137]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 26,
        spawned = false,
    },


    -- Unnamed table at index [138]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 26,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [139]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 27,
        spawned = false,
    },


    -- Unnamed table at index [140]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 27,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [141]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 27,
        spawned = false,
    },


    -- Unnamed table at index [142]
    {
        spawned = false,
        shields = 30,
        timeToSpawn = 28,
        rateOfFire = 2,
        powerUpType = "shields",
        updateFunction = "updateBlockingAndFiring",
        x = 1024,
        imageType = "enemy3",
        speed = 25,
        points = 150,
        y = 576,
    },


    -- Unnamed table at index [143]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 28,
        spawned = false,
    },


    -- Unnamed table at index [144]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 28,
        spawned = false,
    },


    -- Unnamed table at index [145]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 28,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [146]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 29,
        spawned = false,
    },


    -- Unnamed table at index [147]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 29,
        spawned = false,
    },


    -- Unnamed table at index [148]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 29,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [149]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 30,
        spawned = false,
    },


    -- Unnamed table at index [150]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 30,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [151]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 30,
        spawned = false,
    },


    -- Unnamed table at index [152]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 31,
        spawned = false,
    },


    -- Unnamed table at index [153]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 31,
        spawned = false,
    },


    -- Unnamed table at index [154]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 31,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [155]
    {
        y = 0,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 32,
        spawned = false,
    },


    -- Unnamed table at index [156]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 32,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [157]
    {
        y = 704,
        x = 1024,
        imageType = "levelBrick",
        timeToSpawn = 32,
        spawned = false,
    },


    -- Unnamed table at index [158]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 33,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [159]
    {
        spawned = false,
        shields = 30,
        timeToSpawn = 33,
        rateOfFire = 2,
        powerUpType = "shields",
        updateFunction = "updateBlockingAndFiring",
        x = 1024,
        imageType = "enemy3",
        speed = 25,
        points = 150,
        y = 320,
    },


    -- Unnamed table at index [160]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 34,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [161]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 35,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [162]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 36,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [163]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 37,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [164]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 38,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [165]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 39,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [166]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 40,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [167]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 41,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [168]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 42,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [169]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 43,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [170]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 44,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [171]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 45,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [172]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 46,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [173]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 47,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [174]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 48,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [175]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 49,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [176]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 50,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [177]
    {
        y = 384,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 50,
        shields = 10,
    },


    -- Unnamed table at index [178]
    {
        y = 320,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 50,
        shields = 10,
    },


    -- Unnamed table at index [179]
    {
        y = 256,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 50,
        shields = 10,
    },


    -- Unnamed table at index [180]
    {
        y = 192,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 51,
        shields = 10,
    },


    -- Unnamed table at index [181]
    {
        y = 448,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 51,
        shields = 10,
    },


    -- Unnamed table at index [182]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 51,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [183]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 52,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [184]
    {
        y = 192,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 52,
        shields = 10,
    },


    -- Unnamed table at index [185]
    {
        y = 448,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 52,
        shields = 10,
    },


    -- Unnamed table at index [186]
    {
        y = 384,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 53,
        shields = 10,
    },


    -- Unnamed table at index [187]
    {
        y = 256,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 53,
        shields = 10,
    },


    -- Unnamed table at index [188]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 53,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [189]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 54,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [190]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 55,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [191]
    {
        y = 256,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 56,
        shields = 10,
    },


    -- Unnamed table at index [192]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 56,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [193]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 57,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [194]
    {
        y = 384,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 57,
        shields = 10,
    },


    -- Unnamed table at index [195]
    {
        y = 192,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 57,
        shields = 10,
    },


    -- Unnamed table at index [196]
    {
        y = 256,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 57,
        shields = 10,
    },


    -- Unnamed table at index [197]
    {
        y = 448,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 57,
        shields = 10,
    },


    -- Unnamed table at index [198]
    {
        y = 320,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 57,
        shields = 10,
    },


    -- Unnamed table at index [199]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 58,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [200]
    {
        y = 256,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 59,
        shields = 10,
    },


    -- Unnamed table at index [201]
    {
        y = 192,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 59,
        shields = 10,
    },


    -- Unnamed table at index [202]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 59,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [203]
    {
        y = 320,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 59,
        shields = 10,
    },


    -- Unnamed table at index [204]
    {
        y = 448,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 59,
        shields = 10,
    },


    -- Unnamed table at index [205]
    {
        y = 384,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 59,
        shields = 10,
    },


    -- Unnamed table at index [206]
    {
        y = 448,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 60,
        shields = 10,
    },


    -- Unnamed table at index [207]
    {
        y = 320,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 60,
        shields = 10,
    },


    -- Unnamed table at index [208]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 60,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    },


    -- Unnamed table at index [209]
    {
        y = 192,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 60,
        shields = 10,
    },


    -- Unnamed table at index [210]
    {
        y = 384,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 61,
        shields = 10,
    },


    -- Unnamed table at index [211]
    {
        y = 192,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 61,
        shields = 10,
    },


    -- Unnamed table at index [212]
    {
        y = 320,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 61,
        shields = 10,
    },


    -- Unnamed table at index [213]
    {
        y = 448,
        x = 1024,
        imageType = "goldBrick",
        deleteFunction = "deletePlus500",
        spawned = false,
        timeToSpawn = 61,
        shields = 10,
    },


    -- Unnamed table at index [214]
    {
        maxShields = 0,
        shields = 0,
        timeToSpawn = 61,
        columnMarker = true,
        y = 352,
        x = 1024,
        imageType = "columnMarker",
        speed = 64,
        points = 0,
        spawned = false,
        updateFunction = "updateDefault",
    }

}
