local state = {}

require 'image'
require 'button'

function state:new()
	return lovelyMoon.new(self)
end

function state:load()
	addImage("/gfx/button.png","button")
	addImage("/gfx/menu/Lief.png","lief")
	playB = button:new() playB:load(love.graphics.getWidth()*.6,love.graphics.getHeight()*.6,"Play","button")
	exitB = button:new() exitB:load(love.graphics.getWidth()*.6,love.graphics.getHeight()*.7,"Exit","button")
end

function state:close()
	
end

function state:enable()
	
end

function state:disable()
	
end

function state:update(dt)
	
end

function state:draw()
	love.graphics.draw(getImage("lief"),love.graphics.getWidth()*.75,100)
	playB:draw()
	exitB:draw()
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