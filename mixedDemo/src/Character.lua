local anim8 = require '/3rdModule/anim8'
local Character = {}
Character.__index = Character

function Character:create(name, w, h, world)
    local c ={}
    c.x, c.y, c.w, c.h = 0, 0, w, h
    c.anim={}
    c.state = 'idle'
    c.name = name
    world:add(c, c.x, c.y, c.w, c.h)
    setmetatable(c, Character)
    return c
end

function Character:setPosition(x, y)
    self.x, self.y = x, y
    world:move(c, c.x, c.y, c.w, c.h)
end
function Character:update(dt, dx, dy)
    if dx ~= 0 or dy ~= 0 then
        local cols
        self.x, self.y, cols, cols_len = world:move(self, self.x + dx, self.y + dy)
        for i=1, cols_len do
            local col = cols[i]
            -- print(col.other)
        end
    end
    self.anim[self.state]:update() 
end
function Character:draw()
    self.anim[self.state]:draw()
end

function Character:addAnimation(name, animation)
    self.anim[name] = animation
end


return Character