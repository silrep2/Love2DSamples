local anim8 = require '/3rdModule/anim8'
local Character = {}
Character.__index = Character

function Character:create(path, w, h)
    local c ={}
    c.x, c.y, c.w, c.h = 0, 0, w, h
    setmetatable(c, Character)
    local image = love.graphics.newImage('asset/characters.png')
    local g = anim8.newGrid(w, h, image:getWidth(), image:getHeight())
    c.walk = anim8.newAnimation(g('1-4',1), 0.1)
    return c
end

function Character:setPosition(x, y)
    self.x, self.y = x, y
end

function Character:draw()
    
end

return Character