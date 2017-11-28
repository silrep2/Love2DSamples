package.path = package.path .. ";./bump/bump.lua;../bump/bump.lua;"
local bump       = require 'bump'
local SolidBox = require 'SolidBox'
local hero ={}
local world = bump.newWorld()
local boxes = {}

local function initHero()
    hero.x = 0;
    hero.y = 0;
    hero.speed  = 100;
    hero.gravity = 100;
    hero.animation = newAnimation(love.graphics.newImage("oldHero.png"), 16, 18, 1)
end
local function initBoxes()
    boxes[#boxes + 1] = SolidBox:create(0, 600-32, 800, 32, 255, 0, 0, world)
end
local function drawHero()
    local spriteNum = math.floor(hero.animation.currentTime / hero.animation.duration * #hero.animation.quads) + 1
    -- X, Y, direction, scale
    love.graphics.draw(hero.animation.spriteSheet, hero.animation.quads[spriteNum], hero.x, hero.y, 0, 10)
end
local function drawBoxes( ... )
    for i,v in ipairs(boxes) do
        v:draw()
    end
end
local function updateHero(dt)
    if love.keyboard.isDown('a', "left") then
        hero.x = hero.x - hero.speed * dt
    end
    if love.keyboard.isDown('d', "right") then
        hero.x = hero.x + hero.speed * dt
    end

    hero.animation.currentTime = hero.animation.currentTime + dt
    if hero.animation.currentTime >= hero.animation.duration then
        hero.animation.currentTime = hero.animation.currentTime - hero.animation.duration
    end
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

function love.load()
    initHero()
    initBoxes()
end
function love.update(dt)
    updateHero(dt)
end
function love.draw()
    drawHero()
    drawBoxes()
end
function love.keypressed(k)
    if k=="escape" then love.event.quit() end
end