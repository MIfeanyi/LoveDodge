local state = {}
require 'animation'
require 'player'
require 'bullet'
require 'bases'

local bump = require "lib.bump"

local word = bump.newWorld()

physics = {velocity = 45, gravity = 100, floor = {x,y,h,w}, decay = 5}

function state:new()
	return lovelyMoon.new(self)
end

function state:load()
    addImage("/gfx/icon.png","ui-mouse")
    addImage("/gfx/gun.png","ui-gun")
    addImage("/gfx/love.png","love")
    addImage("/gfx/bullet1.png","bullet")
    addImage("/gfx/background.png","bgd")
    addImage("/gfx/plat-dead.png","dead")
    addImage("/gfx/plat-idle.png","stand")
    addImage("/gfx/plat-jump.png","jump")
    addImage("/gfx/plat-walk.png","walk")
    player:addAnimation(addAnimation(32,32,'1-1',"dead",1))
    player:addAnimation(addAnimation(32,32,'1-2',"stand",1.5))
    player:addAnimation(addAnimation(32,32,'1-2',"jump",.3))
    player:addAnimation(addAnimation(32,32,'1-6',"walk",.3))
    addBase(0,542)
end

function state:close()
	
end

function state:enable()
	
end

function state:disable()
	
end

function state:update(dt)
	player:updateAnim8(dt)
    updateBullet(dt)
    if love.keyboard.isDown('w') then
        player.y = player.y - (physics.velocity*4*dt)
        player.current = "jump"
    end
    if love.keyboard.isDown('a') then
        player.current = "walk"
        player.vx = player.vx - (physics.velocity/physics.decay)*dt
    if player.direction == "right" then
        player.direction = "left"
        player:flipH()
    end
    end
    if love.keyboard.isDown('s') then
        player.current = "dead"
    end
    if love.keyboard.isDown('d') then
        player.current = "walk"
        player.vx = player.vx + (physics.velocity/physics.decay)*dt
    if player.direction == "left" then
        player.direction = "right"
        player:flipH()
    end
    end
    if love.keyboard.isDown('space') then
        player.current = "stand"
    end

    if player.vx > physics.velocity then
        player.vx = physics.velocity
    elseif player.vx < (physics.velocity*-1) then
        player.vx = (physics.velocity*-1)
    end
    if player.vx > 0 then
        player.vx = player.vx - (physics.decay)*dt
    end
    if player.vx < 0 then
        player.vx = player.vx + (physics.decay)*dt
    end
    --if player.vx < 0 and player.vx < 0.5 then end

    player.x = player.x + player.vx
    player.y = player.y + (physics.velocity-physics.decay)*dt

    if player.y > love.graphics.getHeight() + 32 then 
        player.y = love.graphics.getHeight()
    end 
end

function state:draw()
    --love.graphics.setColor(20,20,20)
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),40)
    love.graphics.draw(getImage("bgd"))
    love.graphics.draw(getImage("ui-gun"),love.graphics.getWidth()-32,0)
    drawBases()
	player:draw()
    drawBullet()
    love.graphics.draw(getImage("ui-mouse"),love.mouse.getX()-32,love.mouse.getY()-32)
end

function state:keypressed(key, unicode)
end

function state:keyreleased(key, unicode)
end

function state:mousepressed(x, y, button)

end

function state:mousereleased(x, y, button)
    if button == 1 then
    end
end

return state