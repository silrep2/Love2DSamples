package.path = package.path .. ";./bump/bump.lua;../bump/bump.lua;"
local bump       = require 'bump'

SolidBox = {}
SolidBox.__index = SolidBox

function SolidBox:create(x, y, w, h, r, g, b, world)
        local solidBox = {}
        solidBox.x, solidBox.y, solidBox.w, solidBox.h = x, y, w, h
        solidBox.r, solidBox.g, solidBox.b = r, g, b
        world:add(solidBox, x, y, w, h)
        setmetatable(solidBox, SolidBox)
        return solidBox
end

function SolidBox:draw()
    love.graphics.setColor(self.r, self.g, self.b, 70)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    love.graphics.setColor(self.r, self.g, self.b)
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    love.graphics.setColor(255,255,255)
end


return SolidBox