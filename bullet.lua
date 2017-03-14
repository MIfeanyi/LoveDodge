--bullet

local bullets = {}
local bTimer = {max=2,current=0,started=true,wave=1,maxWave=4, life=5}
function addBullet()
    newB = {
    id="bullet",
    x=math.random(0,love.graphics.getWidth()),
    y=-32,
    h=16,w=16,
    sx=math.random(0,100),
    sy=math.random(100,300),
    life=0,alive=true}
    addObject(newB)
    table.insert(bullets,newB)
end

function bulletCollision(actualX, actualY, cols, len)
    for i=1,len do -- If more than one simultaneous collision, they are sorted out by proximity
        local col = cols[i]
        if col.other.id =="player" or col.other.id =="blaster" then
            col.item.alive = false
            score:add()
        end
    end
end

function updateBullet(dt)
    if bTimer.started then
        bTimer.current = bTimer.current + dt
        if bTimer.current > bTimer.max then
            bTimer.current = 0
            bTimer.wave = bTimer.wave + 1
            if bTimer.wave > bTimer.maxWave then
                bTimer.wave = 1
            end
            for i=1, 5*bTimer.wave,1 do
                addBullet()
            end
        end
    end
    for i, b in ipairs(bullets) do
        b.life = b.life + dt
        b.x = b.x + b.sx*dt
        b.y = b.y + b.sy*dt
        b.x,b.y=move(b)
        if b.y > love.graphics.getHeight()+32 or not b.alive or b.life > bTimer.life then
            removeObject(b) --review bump.lua
            table.remove(bullets, i)
        end
    end
end

function drawBullet()
    for i, b in ipairs(bullets) do
        love.graphics.draw(getImage("bullet"),b.x,b.y)
    end
end