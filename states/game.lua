local state = {}
require 'score'
require 'sound'
require 'world'
require 'button'
require 'animation'
require 'player'
require 'bullet'
require 'bases'
require 'pu'

physics = {
    velocity = 45, gravity = 100,jump =300,
    floor = {
        x=0,y=love.graphics.getHeight()-50,h=32,w=love.graphics.getWidth(),id="floor"
    },
    decay = 5}

function state:new()
    return lovelyMoon.new(self)
end

function state:load()
    addImage("/gfx/button.png","button")
    restartB =  button:new() restartB:load(200,love.graphics.getHeight()*.75,"restart","button")
    exitB = button:new() exitB:load(0,love.graphics.getHeight()*.75,"exit","button")

    addSound("/sfx/shoot.wav","shoot")
    addSound("/sfx/lose.wav","lose")
    addSound("/sfx/powerup.wav","powerup") 
    addMusic("/sfx/music/Dark Sanctum.mp3","game")
    getSound("shoot"):setVolume(3)

    addImage("/gfx/uibackground.png","uiback")
    addImage("/gfx/powerup.png","powerup")
    addImage("/gfx/blast.png","blast")
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

    addObject(physics.floor)
    addObject(player)
end

function state:close()
    player:reset()
    resetBullet()
    health:reset()
end

function state:enable()

end

function state:disable()

end

function state:update(dt)
    if player.alive==true and health.curH > 0 then
        love.audio.play(getSound("game"))
        player:update(dt)
        updateBullet(dt)
        updatePU(dt)
        if love.mouse.isDown(1) then
            player:addBullet(love.mouse.getX(),love.mouse.getY())
            love.audio.play(getSound("shoot"))
        end
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
            player:usePU()
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

        player.x = player.x + player.vx
        player.y = player.y + (physics.gravity-physics.decay)*dt

        if player.x > love.graphics.getWidth() - player.w then 
            player.x = love.graphics.getWidth() - player.w
        end
        if player.x < 1 then 
            player.x = 1
        end

        if player.y > love.graphics.getHeight() - player.h then
            if player.y > love.graphics.getHeight() then
            end
            player.y = love.graphics.getHeight()
        end
        player.x, player.y=playerCollisions(move(player))
    else
        love.audio.stop(getSound("game"))
        if restartB:clicked() then
            love.audio.play(getSound("lose"))
            player:reset()
            resetBullet()
            health:reset()
            love.audio.stop(getSound("game"))
            lovelyMoon.switchState("game", "menu") 
        end
        if exitB:clicked() then
            love.event.quit()
        end
    end
end

function state:draw()
    love.graphics.setColor(20,20,20)
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),40)
    love.graphics.setColor(255,255,255,255)
    love.graphics.draw(getImage("bgd"))
    drawBases()
    player:draw()
    drawBullet()
    drawPU()
    love.graphics.draw(getImage("uiback"),0,0)
    love.graphics.draw(getImage("ui-gun"),love.graphics.getWidth()-64,0)
    love.graphics.print("Score:",0,0)
    love.graphics.print(score.points,80,0)
    if player.pu == true then
        love.graphics.draw(getImage("powerup"),love.graphics.getWidth()-64*2,16)
    end
    health:draw()
    if  player.alive ==false or health.curH <= 0 then
        love.graphics.setColor(20,20,20)
        love.graphics.rectangle("fill",0,love.graphics.getHeight()/2,love.graphics.getWidth(),200)
        love.graphics.setColor(255,255,255,255)    
        love.graphics.print("DEAD",0,love.graphics.getHeight()*.60)
        restartB:draw()
        exitB:draw()
    end
    love.graphics.draw(getImage("ui-mouse"),love.mouse.getX()-32,love.mouse.getY()-32)
end

function state:keypressed(key, unicode)
end

function state:keyreleased(key, unicode)
end

function state:mousepressed(x, y, button)
end

function state:mousereleased(x, y, button)
end

return state