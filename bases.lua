--bases

local bases ={}
baseC = 0

function addBase(x,y)
    newBase = {x=x,y=y,h,w,alive=true}
    table.insert(bases,newBase)
    baseC = baseC+1
end

function updateBase(dt)
    for i, b in ipairs(bases) do
        --check collisions
        if b.alive == false then
            table.remove(bases,i)
            baseC = baseC-1
        end
    end
end

function drawBases()
    for i, b in ipairs(bases) do
        love.graphics.draw(getImage("love"),b.x,b.y)
    end
end