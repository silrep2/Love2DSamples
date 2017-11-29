local anim8 = require '/3rdModule/anim8'
local Character = require '/src/Character'

local Hero ={}
Hero.__index = Hero

function Hero:create(name, world)
    local hero = Character:create(name, 32, 32, world)
    local image = love.graphics.newImage('asset/characters.png')
    local g = anim8.newGrid(32, 32, image:getWidth(), image:getHeight())
    local walk = anim8.newAnimation(g('1-4', 1),  0.1)
    local idle = anim8.newAnimation(g(1, 1, 3, 1),  0.1)
    hero:addAnimation('idle', idle)
    hero:addAnimation('walk', walk)
    setmetatable(hero, Hero) 
    return hero
end

function Hero:update(dt)
    local dx = 0
    local dy = 0
    if love.keyboard.isDown('a', "left") then
        dx =  -hero.speed * dt
    end
    if love.keyboard.isDown('d', "right") then
        dx = hero.speed * dt
    end
    dy = hero.gravity * dt
    if love.keyboard.isDown("space") then
        dy = - hero.gravity * dt
    end
    
end


return Hero