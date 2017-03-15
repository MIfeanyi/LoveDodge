local state = {}

require 'image'
require 'button'

function state:new()
	return lovelyMoon.new(self)
end

function state:load()
	addImage("/gfx/button.png","button")
	addImage("/gfx/menu/Lief.png","lief")
	playB = button:new() 
	playB:load(love.graphics.getWidth()*.2,love.graphics.getHeight()*.45,"Play","button")
	quitB = button:new() quitB:load(love.graphics.getWidth()*.2,love.graphics.getHeight()*.60,"Exit","button")
end

function state:close()
	
end

function state:enable()
	
end

function state:disable()
	
end

function state:update(dt)
	if playB:clicked() then
		lovelyMoon.switchState("menu","game")
	end
	if love.keyboard.isDown('escape') or quitB:clicked() then
		love.event.quit()
	end
end

function state:draw()
	love.graphics.setBackgroundColor(20,20,20)
	love.graphics.draw(getImage("lief"),love.graphics.getWidth()*.75,100)
	playB:draw()
	quitB:draw()
	love.graphics.print("Credits: Michael Redford 2017",20,500)
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