require 'image'
local animate = require 'lib.anim8'

animations = {}
function addAnimation(h,w,frames,id,speed)
  local g = animate.newGrid(h,w,getImage(id):getWidth(),h)
  local newAnimation = animate.newAnimation(g(frames,1),speed)
  newAnimation.id = id
  if id == "jump" then newAnimation:pauseAtEnd() end
  return newAnimation
end

function updateAnimations(dt)
  --loop
  for i, a in ipairs(animations) do
    a:update(dt)
  end
end

function drawAnimations()
  end