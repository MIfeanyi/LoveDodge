--Source code under GPL 3.0 License
--Copyright 2017 Michael Redford
local game ={
	version = 1.0.1
}
class = require 'lib.30log'
-- DOCs: https://love2d.org/forums/viewtopic.php?f=5&t=38702
lovelyMoon = require("lib.lovelyMoon")
states = {}

function love.load()
	states.menu = lovelyMoon.addState("states.menu", "menu")
	states.game = lovelyMoon.addState("states.game", "game")
	lovelyMoon.enableState("menu")
end

function love.update(dt)
	lovelyMoon.events.update(dt)
end

function love.draw()
	lovelyMoon.events.draw()
end

function love.keypressed(key, unicode)
	lovelyMoon.events.keypressed(key, unicode)
end

function love.keyreleased(key, unicode)
	lovelyMoon.events.keyreleased(key, unicode)
end

function love.mousepressed(x, y, button)
	lovelyMoon.events.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	lovelyMoon.events.mousereleased(x, y, button)
end