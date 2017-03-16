
sounds = {}

function addSound(src,id)
    local sound = love.audio.newSource(src,"static")
    local newSound = {sfx = sound, id=id}
    table.insert(sounds,newSound)
end

function addMusic(src,id)
    local sound = love.audio.newSource(src)
    local newSound = {sfx = sound, id=id}
    table.insert(sounds,newSound)
end

function getSound(id)
    for i, s in ipairs(sounds) do
        if s.id == id then
            return s.sfx
        end
    end
end

function deleteSound(id)
    for i, s in ipairs(sounds) do
        if s.id == id or s.id == nil then
            table.remove(sounds,i)
        end
    end
end