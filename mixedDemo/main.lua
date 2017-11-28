local anim8 = require '/3rdModule/anim8'
local Character = require '/src/Character'
local image, animation

function love.load()
    cc = Character:create(1,1,1,1)
  image = love.graphics.newImage('asset/characters.png')
  local g = anim8.newGrid(32, 32, image:getWidth(), image:getHeight())
  animation = anim8.newAnimation(g('1-4',1), 0.1)
end

function love.update(dt)
  animation:update(dt)
end

function love.draw()
  animation:draw(image, 100, 200)
end

function love.keypressed(k)
    if(k == 'escape') then
        love.event.quit()
    end
end