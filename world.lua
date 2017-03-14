local bump = require "lib.bump"
--[[ Map - Load Tiled maps and provide collisions for enemies players etc.
]]
local world = bump.newWorld()

function filter(item,other)
  if item.id == "bullet" and other.id =="bullet"  then
    return 'cross'
  end
  if item.id=="bullet" and other.id=="powerup" or item.id=="powerup" and other.id=="bullet" then
    return 'cross'
  end
  if item.id=="bullet" and other.id=="blaster" or item.id=="blaster" and other.id=="bullet" then
    return 'cross'
  end
  if item.id == "bullet" and other.id=="player" or item.id == "player" and other.id=="bullet" then
    return 'cross'
  end
  return 'slide'
end

function addObject(obj)
  world:add(obj,obj.x,obj.y,obj.w,obj.h)
end

function removeObject(obj)
  if world:hasItem(obj) then
    world:remove(obj)
  else
    print("Already removed")
  end
end
function move(obj)
  return world:move(obj,obj.x,obj.y,filter)
end
--[[
function updateWorld(dt)
  world:update(dt)
end
]]