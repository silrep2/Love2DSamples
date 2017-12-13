Plat = {}
Plat.__index = Plat

local kPlatWidth = 200
local kPlatHeight  = 20

function Plat:create(x, y, world)
        local plat = {}
        plat.x, plat.y, plat.w, plat.h = x, y, kPlatWidth, kPlatHeight
        plat.speed = 200
        plat.r, plat.g, plat.b = 0, 0, 255
        plat.isPlat = true
        plat.world = world
        world:add(plat, x, y, plat.w, plat.h)
        setmetatable(plat, Plat)
        return plat
end

function Plat:setColor( r,g,b )
     self.r, self.g, self.b = r, g, b
end

function Plat:update(dt)
    local dx = 0
    local dy = 0
    if love.keyboard.isDown('a', "left") then
        dx =  -self.speed * dt
    end
    if love.keyboard.isDown('d', "right") then
        dx = self.speed * dt
    end
    local cols, len 
    self.x, self.y, cols, len = self.world:move(self, self.x + dx, self.y + dy)
    for i=1,len do
    end
end

function Plat:draw()
    love.graphics.setColor(self.r, self.g, self.b)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

    if(debug)then
        local x,y,w,h = self.world:getRect(self)
        love.graphics.setColor(255,0 ,0)
        love.graphics.rectangle("line", x, y, w, h)
    end
    love.graphics.setColor(255,255,255)
end


return Plat