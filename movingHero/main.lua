local heroX = 0
local heroY = 0
local faceRight = true
local bump = require 'bump'

function love.load()
    animation = newAnimation(love.graphics.newImage("oldHero.png"), 16, 18, 1)
end
 
function love.update(dt)
    animation.currentTime = animation.currentTime + dt
    if animation.currentTime >= animation.duration then
        animation.currentTime = animation.currentTime - animation.duration
    end

    if love.keyboard.isDown('a', "left") then
    	heroX = heroX - 1
    end
    if love.keyboard.isDown('d', "right") then
    	heroX = heroX + 1
    end
    if love.keyboard.isDown('w', "up") then
    	heroY = heroY - 1
    end
    if love.keyboard.isDown('s', "down") then
    	heroY = heroY + 1
    end
end
 
function love.draw()
    local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
    -- X, Y, direction, scale
    love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], heroX, heroY, 0, 10)
end
 
function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};
 
    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end
 
    animation.duration = duration or 1
    animation.currentTime = 0
 
    return animation
end
