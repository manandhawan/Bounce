--this line is required so that director knows that
--this is a scene that can be loaded into its view
module(..., package.seeall)
--we need to be able to access the director class of
--course so be sure to include this here
local director = require("director")
local sprite = require("sprite")
--everything that you want this scene to do should be
--included in the new function. Everytime the director
--loads a new scene it will look here to figure out what
--to load up.
new = function( params )
     --this function will be returned to the director
     local menuDisplay = display.newGroup()
     local title = "Prisoner on Run"
     local playButton = "button"
     menuDisplay:insert(title)
     menuDisplay:insert(playButton)
     --this is what gets called when playButton gets touched
     --the only thing that is does is call the transition
     --from this scene to the game scene, "downFlip" is the
     --name of the transition that the director uses
     local function buttonListener( event )
          director:changeScene( "game", "downFlip" )
          return true
     end
     playButton:addEventListener("touch", buttonListener )
     --return the display group at the end
     return menuDisplay
end

