score = {
    points=0,
    hiscore=0
}

health = {
    maxH =2000,
    curH= 2000,
    dmg=20,
    x=0,y=30,
    w=400,
    h=30
}

function score:add()
    self.points = self.points + 50
end

function load()
end

function save()
end

function health:damage()
    if (self.curH - self.dmg) < 0 then
        self.curH= self.curH - self.dmg
    end
end

function health:draw()
    percent = (self.curH/self.maxH)*self.w
    love.graphics.setColor(255,0,0,255)
    love.graphics.rectangle("fill",self.x,self.y,percent,self.h)
    love.graphics.setColor(255,255,255,255)
end