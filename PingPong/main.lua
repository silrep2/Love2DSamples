local bump = require '/3rdModule/bump'
local Block = require '/src/Block'
local Ball = require '/src/Ball'
local Plat = require '/src/Plat'

-- vars
debug = true
pause = false
lose = false
local world = bump.newWorld()
local ball = Ball:create(100,100, 16, world)    
local blocks = {}
local plat = Plat:create(300, 600, world)
local map
screenW, screenH = 1200, 800

-- init
success = love.window.setMode(screenW, screenH, {borderless=true})


function love.load()
    -- load walls 
    -- 0: up 
    -- 1: left
    -- 2: right
    blocks[0] = Block:create(0, -10, screenW, 5, world) 
    blocks[1] = Block:create(-10, 0, 5, screenH, world)
    blocks[2] = Block:create(screenW + 10, 0, 5, screenH, world)
    blocks[3] = Block:create(0, screenH + 10, screenW, 5, world)
    blocks[3].isBottom = true

    -- load 
    map = loadMap(1)
    
    local blockSize = 32
    local startX = (screenW - (blockSize *  #map[1]))/2
    local startY = 100
    for i = 1, #map do
        for j = 1,  #map[1] do 
            if (map[i][j] ~= 0) then
                blocks[#blocks + 1] = Block:create(startX + j * (blockSize), startY + i * blockSize, blockSize, blockSize, world)
                blocks[#blocks].crispy = true
            end
        end
    end
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

function loadMap(num)
    local file = io.open("./maps/" .. num, r)
    io.input(file)
    local lineID = 0
    local map = {}
    for line in file:lines()do
        lineID = lineID + 1
        map[lineID] = {}
        for i = 1, string.len(line) do
            -- print(string.byte(line, i) - 48)
            map[lineID][i] = string.byte(line, i) - 48
        end
    end
    return map
end