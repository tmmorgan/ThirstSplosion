--==============================================================================
-- File:     main.lua
-- Author:   Kevin Harris
-- Modified: December 17, 2014
-- Descript: 
--==============================================================================

display.setStatusBar( display.HiddenStatusBar )

local composer = require( "composer" )

audio.setVolume( 0.1 )

-- Load menu scene!
composer.gotoScene( "menu" )