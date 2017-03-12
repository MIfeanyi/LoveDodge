local bump = require "lib.bump"

--[[ Map - Load Tiled maps and provide collisions for enemies players etc.

]]
local world = bump.newWorld()

function filter(item,other)
return 'cross'
end

function addObject(obj)
  world:add(obj,obj.x,obj.y,obj.w,obj.h)
end

function move(obj)
  return world:move(obj,obj.x,obj.y,filter)
end

function updateWorld(dt)
  world:update(dt)
end
