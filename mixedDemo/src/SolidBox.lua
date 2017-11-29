
SolidBox = {}
SolidBox.__index = SolidBox
local groundHeight = 2
function SolidBox:create(x, y, w, h, world)
        local solidBox = {}
        solidBox.x, solidBox.y, solidBox.w, solidBox.h = x, y, w, h
        solidBox.r, solidBox.g, solidBox.b = 0, 255, 0
        solidBox.groudTrigger  = {isGround = true}
        -- print(solidBox.groudTrigger)
        world:add(solidBox.groudTrigger, x, y, w, groundHeight)
        world:add(solidBox, x + groundHeight, y, w, h - groundHeight)
        setmetatable(solidBox, SolidBox)
        return solidBox
end

function SolidBox:setColor( r,g,b )
     self.r, self.g, self.b = r, g, b
end


function SolidBox:draw()
    love.graphics.setColor(self.r, self.g, self.b)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    love.graphics.setColor(255,255,255)
end


return SolidBox