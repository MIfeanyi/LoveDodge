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
    for i=1,len do
        local col = cols[i]
        if col.other.id =="player" or col.other.id =="blaster" then
            col.item.alive = false
            score:add()
            if col.other.id=="player" then
                player.alive =false
            end
        end
        if col.other.id =="floor" or col.item.id=="floor" then
            col.item.alive = false
            health:damage()
        end
    end
    return actualX, actualY
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
        b.x,b.y=bulletCollision(move(b))
        if b ~= nil then
            if b.y > love.graphics.getHeight()+32 or not b.alive or b.life > bTimer.life then
                removeObject(b) 
                table.remove(bullets, i)
            end
        end
    end
end

function resetBullet()
    for i, b in ipairs(bullets) do
        removeObject(b)
        table.remove(bullets,i)
    end
    bTimer.wave = 1
    bTimer.current = 0
end

function drawBullet()
    for i, b in ipairs(bullets) do
        love.graphics.draw(getImage("bullet"),b.x,b.y)
    end
end