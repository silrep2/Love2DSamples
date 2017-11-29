local bump = require '/3rdModule/bump'
local anim8 = require '/3rdModule/anim8'
local Character = require '/src/Character'
local Hero = require '/src/Hero'
local image, animation
local world = bump.newWorld()
function love.load()

    hero = Hero:create('myHero', 0, world)
    hero:setPosition(100, 100) 
    hero2 = Hero:create('myHero2', 1, world)
    hero2.speed = 50
    hero2:setPosition(100, 200) 
end

function love.update(dt)
    hero:update(dt)
    hero2:update(dt)
end

function love.draw()
  hero:draw()
  hero2:draw()
  drawDebug()
end


function drawDebug()
    local statistics = ("x: %d, y: %d"):format(hero.x, hero.y)
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf(statistics, 0, 530, 790, 'right')
    statistics = ("x2: %d, y2: %d"):format(hero2.x, hero2.y)
    love.graphics.printf(statistics, 0, 580, 790, 'right')
end
function love.keypressed(k)
    if(k == 'escape') then
        love.event.quit()
    end
end