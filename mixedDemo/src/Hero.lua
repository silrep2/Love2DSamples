local anim8 = require '/3rdModule/anim8'
local Character = require '/src/Character'

local Hero ={}
Hero.__index = Hero
setmetatable(Hero, Character)

function Hero:create(name, type, world)
    local hero = Character:create(name, 'asset/characters.png', 32, 32, world)
    hero.speedX =100
    hero.speedY = 0
    hero.x = 400
    hero.gravity  = 1400
    hero.jumpSpeed = -650
    local g = anim8.newGrid(32, 32, hero.image:getWidth(), hero.image:getHeight(), 0, type*32)
    local walk = anim8.newAnimation(g('1-4', 1),  0.1)
    local idle = anim8.newAnimation(g(1, 1, 3, 1),  0.1)
    hero:addAnimation('idle', idle)
    hero:addAnimation('walk', walk)
    
    setmetatable(hero, Hero)
    return hero
end

function Hero:draw()
    Character.draw(self)
end
function Hero:update(dt)
    local dx = 0
    local dy = 0
    if love.keyboard.isDown('a', "left") then
        dx =  -self.speedX * dt
        self.facingLeft = true
    end
    if love.keyboard.isDown('d', "right") then
        dx = self.speedX * dt
        self.facingLeft = false
    end
    
    if (love.keyboard.isDown("space") and self.isGrounded) then
        self.speedY = self.jumpSpeed
    end
   
    self.speedY = self.speedY + self.gravity * dt 
    dy = self.speedY * dt
    
    Character.update(self, dt, dx, dy)
end


return Hero