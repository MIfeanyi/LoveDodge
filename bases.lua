--bases

local bases ={}

function addBase(x,y)
    newBase = {x=x,y=y,h,w,alive=true}
    table.insert(bases,newBase)
end

function updateBase(dt)
    for i, b in ipairs(bases) do
        --check collisions
        if b.alive == false then
            table.remove(bases,i)
        end
    end
end

function drawBases()
    for i, b in ipairs(bases) do
        love.graphics.draw(getImage("love"),b.x,b.y)
    end
end