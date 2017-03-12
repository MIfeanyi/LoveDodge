--bullet

local bullets = {}
local bTimer = {max=2,current=0,started=true,wave=1,maxWave=4}
function addBullet()
    newB = {x=math.random(0,love.graphics.getWidth()),
    y=-32,
    h=16,w=16,
    sx=math.random(0,100),
    sy=math.random(100,300),alive=true}
    table.insert(bullets,newB)
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
        b.x = b.x + b.sx*dt
        b.y = b.y + b.sy*dt
        if b.y > love.graphics.getHeight()+32 then
            table.remove(bullets, i)
        end
    end
end

function drawBullet()
    for i, b in ipairs(bullets) do
        love.graphics.draw(getImage("bullet"),b.x,b.y)
    end
end