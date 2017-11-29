local anim8 = require '/3rdModule/anim8'
local Character = {}
Character.__index = Character

function Character:create(name, path, w, h, world)
    local c ={}
    c.x, c.y, c.w, c.h = 0, 0, w, h
    c.image = love.graphics.newImage(path)
    c.anim={}
    c.state = 'idle'
    c.name = name
    c.world = world
    c.isGrounded = false
    world:add(c, c.x, c.y, c.w, c.h)
    setmetatable(c, Character)
    return c
end

function Character:setPosition(x, y)
    self.world:remove(self)
    self.x, self.y = x, y
    self.world:add(self, self.x, self.y, self.w, self.h)
    -- or you can use cross moving
    -- self.x, self.y, cols, cols_len = self.world:move(self, x, y, function() return "cross" end)
end

function Character:update(dt, dx, dy)
    if dx ~= 0 or dy ~= 0 then
        local cols
        self.x, self.y, cols, cols_len = self.world:move(self, self.x + dx, self.y + dy)
        self.isGrounded =false
        for i=1, cols_len do
            local col = cols[i]
            if(col.other.isGround)then
                self.isGrounded = true
            end
        end
    end
    self.anim[self.state]:update(dt) 
end

function Character:draw()
    self.anim[self.state]:draw(self.image, self.x, self.y )
end

function Character:addAnimation(name, animation)
    self.anim[name] = animation
end


return Character