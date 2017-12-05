local bump = require '/3rdModule/bump'
local anim8 = require '/3rdModule/anim8'
local SolidBox = require '/src/SolidBox'
local Character = require '/src/Character'
local Hero = require '/src/Hero'
local image, animation
local world = bump.newWorld()
local toDrawList = {}
debug = true

function pointAt( ... )
  -- body
end
function love.load()

    hero = Hero:create('myHero', 0, world)
    hero:setPosition(100, 100) 
    -- hero2 = Hero:create('myHero2', 1, world)
    -- hero2.speedX = 50
    -- hero2:setPosition(100, 200) 

    toDrawList[#toDrawList + 1] = SolidBox:create(0, 580, 800, 20, world)
    toDrawList[#toDrawList + 1] = SolidBox:create(0, 380, 200, 10, world)
    toDrawList[#toDrawList + 1] = SolidBox:create(200, 380, 200, 10, world)
    toDrawList[#toDrawList + 1] = SolidBox:create(150, 480, 300, 10, world)
end

function love.update(dt)
    hero:update(dt)
    -- hero2:update(dt)
end

function love.draw()
  hero:draw()
  -- hero2:draw()
  for i=1,#toDrawList do
      toDrawList[i]:draw()
  end
  if(debug) then
      drawDebug()
  end

end


function drawDebug()
    local statistics = ("x: %d, y: %d, onGround: %s, \n speedX: %d, speedY: %d"):format(hero.x, hero.y, 
        hero.isGrounded, hero.speedX,  hero.speedY)
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf(statistics, 0, 530, 790, 'right')
    -- statistics = ("x2: %d, y2: %d"):format(hero2.x, hero2.y)
    -- love.graphics.printf(statistics, 0, 550, 790, 'right')
end
function love.keypressed(k)
    if(k == 'escape') then
      love.event.quit()
    end
    if(k == 'tab') then
      debug = not debug
    end
end