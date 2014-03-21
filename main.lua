-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local physics = require("physics")
physics.start()
physics.setGravity(0,10.8)
--physics.setDrawMode("hybrid")
--takes away the display bar at the top of the screen

display.setStatusBar(display.HiddenStatusBar)
--adds an image to our game centered at x and y coordinates
local backbackground = display.newImage("images/bg.png")
backbackground.x = 240
backbackground.y = 160
local backgroundfar1 = display.newImage("images/city1.png")
backgroundfar1.x = 240
backgroundfar1.y = 190
local backgroundfar2 = display.newImage("images/city1.png")
backgroundfar2.x = 720
backgroundfar2.y = 190
local backgroundnear1 = display.newImage("images/city2.png")
backgroundnear1.x = 240
backgroundnear1.y = 253
local backgroundnear2 = display.newImage("images/city2.png")
backgroundnear2.x = 720
backgroundnear2.y = 253

local ground1 = display.newImage("images/layer2.png")
ground1.x = 240
ground1.y = 355
squareShape={-240,-52, 240,-52, 240,52, -240,52}
physics.addBody(ground1, "static",{bounce=1,shape=squareShape})
ground1.gravityScale = 0
local ground2 = display.newImage("images/layer2.png")
ground2.x = 720
ground2.y = 355
physics.addBody(ground2, "static", {bounce=1,shape=squareShape})
ground2.gravityScale = 0

local ball = display.newImage("images/ball.png")

--[[local barrel = display.newImage("images/barrel.png")
barrel.x = 360
barrel.y = 277

local barrel1 = display.newImage("images/barrel1.png")
barrel1.x = 260
barrel1.y = 282

local lamp = display.newImage("images/lamp.png")
lamp.x = 300
lamp.y = 254

local wheel = display.newImage("images/wheel.png")
wheel.x = 206
wheel.y = 286

local rivet = display.newImage("images/rivet.png")
rivet.x = 200
rivet.y = 288.5
--]]

flag1=0
function ballGround()
if (ball.y > 150) then
flag1=1
else
flag1=0
end
print (flag1)
print (ball.y)
end

local function update( event )
--updateBackgrounds will call a function made specifically to handle the background movement
updateBackgrounds()
updateBlocks()
ballGround()

end
function updateBackgrounds()
--far background movement
backgroundfar1.x = backgroundfar1.x - (.25)
--near background movement
backgroundnear1.x = backgroundnear1.x - (2)
ground1.x = ground1.x - (5)
ground2.x = ground2.x - (5)
--if the sprite has moved off the screen move it back to the
--other side so it will move back on
if(backgroundnear1.x < -239) then
backgroundnear1.x = 720
end
backgroundnear2.x = backgroundnear2.x - (2)
if(backgroundnear2.x < -239) then
backgroundnear2.x = 720
end
if(backgroundfar1.x < -239) then
backgroundfar1.x = 720
end
backgroundfar2.x = backgroundfar2.x - (.25)
if(backgroundfar2.x < -239) then
backgroundfar2.x = 720
end
if(ground1.x < -239) then
ground1.x = 720
end

if(ground2.x < -239) then
ground2.x = 720
end
end
--this is how we call the update function, make sure that this line comes after the
--actual function or it will not be able to find it
--timer.performWithDelay(how often it will run in milliseconds, function to call,
--how many times to call(-1 means forever))
timer.performWithDelay(1, update, -1)


local blocks = display.newGroup()

local barrelPos = 282


for a = 1, 8, 1 do
b = a
isDone = false
numGen = math.random(3)

--newX = math.random(((a*250) - 50),((a*350) - 50))
local newBlock
local newBlock1
print (numGen)
if(numGen == 1 and isDone == false) then
newBlock = display.newImage("images/barrel.png")
physics.addBody(newBlock, "dynamic", {isSensor = true})
--physics.addBody(newBlock, "dynamic")
newBlock.gravityScale = 0
isDone = true
end
if(numGen == 2 and isDone == false) then
newBlock = display.newImage("images/barrel1.png")
physics.addBody(newBlock, "dynamic", {isSensor = true})
newBlock.gravityScale = 0
isDone = true
end
if(numGen == 3 and isDone == false) then
newBlock = display.newGroup()
local wheel = display.newImage("images/wheel.png")
local rivet = display.newImage("images/rivet.png")
newBlock:insert(wheel)
newBlock:insert(rivet)
assert( (newBlock[1] == wheel) and (newBlock[2] == rivet) )
newBlock[1].y=3
newBlock[1].x=42
newBlock[2].y=6

physics.addBody(newBlock, "dynamic", {isSensor = true})
newBlock.gravityScale = 0

isDone = true
local function spinImage (event)
  transition.to( newBlock[1], { rotation = newBlock[1].rotation-360, time=200, onComplete=spinImage } )
end
spinImage()
end


distance = {700,1000,1500,1700,2100,2700,3000,3400}
blade={city1,city2}
objs = {newBlock,ground1,blade}

newBlock.name = ("block" .. a)
newBlock.id = a

newBlock.x=distance[a]

print(newBlock.x)
newBlock.y = barrelPos
blocks:insert(newBlock)

end

local score=0
local textobj=display.newText(score,400,0,"Helvetica",20)
local function updateScore()
score=score+1
textobj.text=score
end
timer.performWithDelay(200,updateScore,-1)


local speed =5


local function increaseSpeed()
speed=speed+0.05
end
timer.performWithDelay(1000,increaseSpeed,600)


function updateBlocks()
for a = 1, blocks.numChildren, 1 do
b=a+8
if(a > 1) then
--distance = {150+(a-1)*1100,400+(a-1)*500}
newX = (blocks[a-1]).x + (600+(a-1)*100)
--print(newX)
--math.random(50,60,90,80)
else
newX = (blocks[4]).x + (600+(a-1)*100)-speed
--print(newX)
end
if((blocks[a]).x < -40) then
(blocks[a]).x, (blocks[a]).y = newX, (blocks[a]).y
else
(blocks[a]):translate(speed * -1, 0)
end
end
end

ball.x=100
ball.y=284.3
physics.addBody(ball, "dynamic", {bounce=1,radius=15})
ball.linearDamping = 1


ball.gravityScale = 2
local function spinImage (event)
  transition.to( ball, { rotation = ball.rotation+360, time=440, onComplete=spinImage } )
end
spinImage()

--[[local sprite = require("sprite")

local runSpriteSheet = sprite.newSpriteSheet("images/hero111.png", 70 , 130)
local runCharacterSet = sprite.newSpriteSet(runSpriteSheet, 1, 27)

--local jumpSpriteSheet = sprite.newSpriteSheet("images/run.png", 70 , 65)
--local jumpCharacterSet = sprite.newSpriteSet(jumpSpriteSheet, 1, 6)

sprite.add(runCharacterSet, "running", 1, 6, 520, 0)
sprite.add(runCharacterSet, "jumping", 19, 27, 2000, 1)
sprite.add(runCharacterSet, "rolling", 10, 13, 1000, 1)
--sprite.add(runCharacterSet, "test", 14, 18, 1000, 1)

local runHero = sprite.newSprite(runCharacterSet)
physics.addBody(runHero, "dynamic", {isSensor = true})

--local jumpHero = sprite.newSprite(jumpCharacterSet)
--physics.addBody(jumpHero, "dynamic", {isSensor = true})
onGround = true
wasOnGround = false

x = 100
y = 235
right = true
runHero.x = x
runHero.y = y
--jumpHero.x = x
--jumpHero.y = y

runHero:prepare("running")
--hero:prepare("jumping")
--hero:prepare("rolling")

runHero:play()
--]]


local function onTouch( event )
    if "began" == event.phase then
       -- onGround = false
        if(event.x < 240) then
         --   runHero:prepare("rolling")
           -- runHero:play()
		   ball:applyLinearImpulse( 0, -0.10, ball.x, ball.y )
        else    
            --runHero:prepare("jumping")
            --runHero:play()
        end
    end
    if "ended" == event.phase or "cancelled" == event.phase then
        --print "before"
    --    onGround = true
      --  wasOnGround = false
        --runHero:prepare("running")
        --runHero:play()
    end
          
    --[[if(onGround) then
            if(wasOnGround) then

            else    
                runHero:prepare("running")
                runHero:play()
            end
          else
               runHero:prepare("jumping")
               runHero:play()
          end       
       --]]

    -- Return true if the touch event has been handled.
    return true
end


function onCollision(event)
    if event.phase == "began" then
        print "collide!"
        isAlive = false
   
      end
   end

Runtime:addEventListener("collision", onCollision)
backbackground:addEventListener("touch", onTouch)