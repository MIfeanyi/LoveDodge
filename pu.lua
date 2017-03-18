powerups ={}
local var = {
    sx = 200,
    sy = 100,
    current =0,
    max = 30,
    points =100
}

function addPU()
    newPU = {
        x=-64,
        y=math.random(0,love.graphics.getHeight()-var.sy),
        h=64,w=64,
        alive = true,
        id="powerup"
    }
    addObject(newPU)
    table.insert(powerups,newPU)
end
function puCollisions(actualX, actualY, cols, len)
    for i=1,len do -- If more than one simultaneous collision, they are sorted out by proximity
        local col = cols[i]
        if col.other.id =="player" or col.other.id=="blaster" then
            col.item.alive = false
            player.pu = true
            score.points = score.points+var.points
        end
    end
    return actualX,actualY
end

function updatePU(dt)
    var.current = var.current+dt
    if var.current > var.max then
        var.current = 0
        addPU()
    end
    for i, p in ipairs(powerups) do
        p.x = p.x + var.sx*dt
        p.y = p.y + var.sy*dt
        p.x,p.y = puCollisions(move(p))
        if p.y > love.graphics.getHeight() or not p.alive then
            removeObject(p)
            table.remove(powerups,i)
        end
    end
end

function drawPU()
    for i, p in ipairs(powerups) do
        love.graphics.draw(getImage(p.id),p.x,p.y)
    end
end