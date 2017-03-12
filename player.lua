
player= {
    state = {walk=true, idle=false,stand=false,jump=false},
    animations = {},
    current = "jump", direction = "right",
    x=0,y=0,h=16,w=16,vx=0,vy=0
}

local bullets = {}
local bTimer = {max=1,current=0,canShoot=true}

function player:addAnimation(animation)
    a = animation
    table.insert(self.animations,a)
end

function player:updateAnim8(dt)
  for i, a in ipairs(self.animations) do
    a:update(dt)
  end
end

function player:draw()
    for i, a in ipairs(self.animations) do
        if self.current == a.id then
        a:draw(getImage(self.current),self.x,self.y)
        end
    end
end

function player:flipH()
        for i, a in ipairs(self.animations) do
            a:flipH()
        end
end

function player:flipV()
        for i, a in ipairs(self.animations) do
            a:flipV()
        end
end