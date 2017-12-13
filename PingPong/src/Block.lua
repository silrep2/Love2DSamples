Block = {}
Block.__index = Block

function Block:create(x, y, w, h, world)
        local block = {}
        block.x, block.y, block.w, block.h = x, y, w, h
        block.r, block.g, block.b = 0, 255, 0
        block.isBlock = true
        world:add(block, x, y, w, h)
        setmetatable(block, Block)
        return block
end

function Block:setColor( r,g,b )
     self.r, self.g, self.b = r, g, b
end


function Block:draw()
    love.graphics.setColor(self.r, self.g, self.b)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    love.graphics.setColor(255,255,255)
end


return Block