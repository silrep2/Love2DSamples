Ball = {}
Ball.__index = Ball

local ballFilter = function(ball, other)
    if other.isBlock   then 
        return 'bounce'
    else
        return nil
    end
  -- else return nil
end

function Ball:create(x, y, r, world)
        local ball = {}
        ball.x, ball.y = x, y
        ball.rad = r
        ball.speed = 400
        ball.directionX = 0
        ball.directionY = 0
        ball.r, ball.g, ball.b = 255, 255, 0
        ball.isBall = true
        ball.world = world
        ball.escaped = false
        world:add(ball, x, y, ball.rad *2 , ball.rad * 2)
        setmetatable(ball, Ball)
        return ball
end

function Ball:setColor( r,g,b )
     self.r, self.g, self.b = r, g, b
end

function Ball:putOnPlat(plat)
    self.world:remove(self)
    self.escaped = false
    self.x = plat.x + plat.w / 2 - self.rad
    self.y = plat.y  - self.rad*2
    self.onWhichPlat = plat
    self.world:add(self, self.x, self.y, self.rad *2 , self.rad * 2)
end

function Ball:update(dt)
    if(self.escaped)then
        local goalX, goalY = self.x + self.speed * self.directionX * dt , self.y + self.speed * self.directionY * dt
        local cols, len
        self.x, self.y, cols, len = self.world:move(self, goalX, goalY)
        for i=1, len do
            local other = cols[i].other
            if other.isBlock then
                if other.isBottom then 
                    lose = true
                else
                    if other.crispy then
                        other:crash()
                        print(1)
                    end
                    if(cols[i].normal.x ~= 0) then
                        self.directionX = self.directionX  * -1
                    end
                    if(cols[i].normal.y ~= 0) then
                        self.directionY = self.directionY  * -1
                    end
                end
            elseif other.isPlat then
                self.directionX = self.directionX  * -1
                self.directionY = self.directionY  * -1
                local dx = (self.x  + self.rad) - (other.x + other.w / 2)
                self:setDirection(dx/120, self.directionY)
            end
        end
    else
        if love.keyboard.isDown('space') then
            print('eject')
            self.escaped = true
            self.directionX = 0
            self.directionY = -1
        else
            self:putOnPlat(self.onWhichPlat)
        end
    end
end
function Ball:setDirection(x, y)
    self.directionX = x / math.sqrt(x*x+y*y)
    self.directionY = y / math.sqrt(x*x+y*y)
end
function Ball:draw()
    love.graphics.setColor(self.r, self.g, self.b)
    love.graphics.circle("fill", self.x + self.rad, self.y + self.rad, self.rad, 128)

    if(debug)then
        local x,y,w,h = self.world:getRect(self)
        love.graphics.setColor(255,0 ,0 )
        love.graphics.rectangle("line", x, y, w, h)
    end
    love.graphics.setColor(255,255,255)
end


return Ball