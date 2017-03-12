powerups ={}
local var = {
    sx = 200,
    sy = 100,
    current =0,
    max = 05
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

function updatePU(dt)
    var.current = var.current+dt
    if var.current > var.max then
        var.current = 0
        addPU()
    end
    for i, p in ipairs(powerups) do
        p.x = p.x + var.sx*dt
        p.y = p.y + var.sy*dt
        if p.y > love.graphics.getHeight() or not p.alive then
            removeObject(p)
            table.remove(powerups,i)
        end
        p.x,p.y = move(p)
    end
end

function drawPU()
    for i, p in ipairs(powerups) do
        love.graphics.draw(getImage(p.id),p.x,p.y)
    end
end