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
    c.facingLeft = false
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

            -- if touch ground and between ground's edges 
            if(col.other.isGround and (col.other.x < self.x + self.w) and (self.x  < col.other.x + col.other.w) )then
                self.isGrounded = true
                self.speedY = 0
                -- if touch wall  and between wall's edges
            elseif(col.other.isWall and (col.other.y < self.y) and (col.other.x < self.x + self.w) and (self.x < col.other.x + col.other.w))then
                self.speedY = 0
            end
        end
    end
    self.anim[self.state]:update(dt) 
end

function Character:draw()
    if(self.facingLeft)then
        self.anim[self.state]:draw(self.image, self.x, self.y, 0 ,  -1, 1, self.w)
    else
        self.anim[self.state]:draw(self.image, self.x, self.y, 0 ,  1, 1, 0)
    end
    if(debug)then
        love.graphics.setColor(0,0,255)
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
        love.graphics.setColor(255,255,255)
    end
end

function Character:addAnimation(name, animation)
    self.anim[name] = animation
end


return Character