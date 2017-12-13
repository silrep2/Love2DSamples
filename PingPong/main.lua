local bump = require '/3rdModule/bump'
local Block = require '/src/Block'
local Ball = require '/src/Ball'
local Plat = require '/src/Plat'

-- vars
debug = true
pause = false
lose = false
local world = bump.newWorld()
local ball = Ball:create(100,100, 40, world)    
local blocks = {}
local plat = Plat:create(300, 600, world)
screenW, screenH = 1200, 800

-- init
success = love.window.setMode(screenW, screenH, {borderless=true})


function love.load()
    -- load walls
    blocks[0] = Block:create(0, -5, screenW, 5, world)
    blocks[1] = Block:create(-5, 0, 5, screenH, world)
    blocks[2] = Block:create(screenW, 0, 5, screenH, world)
    blocks[3] = Block:create(0, screenH, screenW, 5, world)
    blocks[3].isBottom = true
    blocks[#blocks + 1] = Block:create(400, 0, 50, 200, world)
    ball:putOnPlat(plat)
end

function love.draw()
    ball:draw()
    plat:draw()
    for i=1,#blocks do
        blocks[i]:draw()
    end
    if(lose)then
        love.graphics.print( 'GAME OVER', screenW / 2 - 100,  screenH / 2, 0, 5, 5)
    end
end

function love.update(dt)
    if(not lose) then
        if(not pause)then
            ball:update(dt)
            plat:update(dt)
        end
    end
end

function love.keypressed(k)
    if(k == 'escape') then
      love.event.quit()
    end
    if(k == 'tab') then
      debug = not debug
    end
    if(k == 'p') then
        pause = not pause
    end
end