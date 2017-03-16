
player= {
    state = {walk=true, idle=false,stand=false,jump=false},
    animations = {},
    current = "jump", direction = "right",
    x=0,y=0,h=32,w=32,vx=0,vy=0,
    bulletSpd=20,
    id ="player",
    pu = false,
    alive = true
}

local bullets = {}
local bTimer = {max=.05,current=0,canShoot=true,maxLife=5}

function player:addAnimation(animation)
    a = animation
    table.insert(self.animations,a)
end

function player:update(dt)
    bTimer.current = bTimer.current + dt
    if bTimer.current > bTimer.max then
        bTimer.current = 0
        bTimer.canShoot = true
    end
    for i, a in ipairs(self.animations) do
        a:update(dt)
    end
    for i, b in ipairs(bullets) do
        b.life = b.life + dt
        b.x = b.x + (b.sx+self.bulletSpd)*dt
        b.y = b.y + (b.sy+self.bulletSpd)*dt
        b.x,b.y = playerCollisions(move(b))
        if b.life > bTimer.maxLife then
            table.remove(bullets,i)
        end
    end
end

function player:draw()
    for i, a in ipairs(self.animations) do
        if self.current == a.id then
        a:draw(getImage(self.current),self.x,self.y)
        end
    end
    for i, b in ipairs(bullets) do
        love.graphics.draw(getImage("blast"),b.x,b.y)
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

function player:reset()
    self.alive = true
    for i, b in ipairs(bullets) do
        removeObject(b)
        table.remove(bullets,i)
    end
    self.x = 0
    self.y = 0
end

function player:addBullet(x,y)
    if bTimer.canShoot then
        newB = {x=self.x,
        y=self.y,
        h=16,w=16,
        sx= (x-self.x),
        sy= (y-self.y),
        id="blaster",
        life=0}
        addObject(newB)
        table.insert(bullets,newB)
        bTimer.canShoot = false
        bTimer.current = 0
    end
end

function playerCollisions(actualX, actualY, cols, len)
  if len > 0 then
  else
  end
  for i=1,len do
    local col = cols[i]
    if col.item.id=="blaster" then
        if col.other.id=="bullet" then
            col.other.alive = false
            score:add()
        end
    end
    if col.other.id == "bullet" then
        if col.item.id =="player" then
            player.alive = false
        end
        col.other.alive = false
    end
    if col.other.id == "powerup" then
        col.other.alive = false
        player.pu = true
        --turn on powerup
    end
    if col.other.id =="floor" then
        if player.current == "jump" then
            player.current = "stand"
        end
    end
  end

  return actualX, actualY
end