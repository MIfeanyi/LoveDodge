require 'lib.sick'

score = {
    points=0,
    hiscore=0,
    max=5
}

health = {
    maxH =2000,
    curH= 2000,
    dmg=20,
    x=0,y=30,
    w=400,
    h=30,
    alive = true
}

local sTimer = {max=.5,current=0,score=0,done=false}

function score:add()
    self.points = self.points + 50
end

function score:load()
    highscore.set("highscores.txt", self.max, "player", 0)
end

function score:save()
    highscore.add("player", self.points)
    highscore.save()
end

function score:update(dt)
    sTimer.current = sTimer.current + dt
    if sTimer.current > sTimer.max then
        sTimer.current = 0
        if sTimer.score < self.max then
            sTimer.score = sTimer.score+1
            love.audio.play(getSound("powerup"))
        end
    end
end

function score:draw(x,y)
    for i,score, name in highscore() do 
        if i <= sTimer.score then
            love.graphics.print(score, x, y+ i * 20)
        end
    end
end

function health:damage()
    if (self.curH - self.dmg) > 0 then
        self.curH = self.curH - self.dmg
    else
        self.curH = 0
        self.alive = false
    end
end

function health:draw()
    percent = (self.curH/self.maxH)*self.w
    love.graphics.setColor(255,0,0,255)
    if percent > 0 then
        love.graphics.rectangle("fill",self.x,self.y,percent,self.h)
    end
    love.graphics.setColor(255,255,255,255)
end

function health:reset()
    score:save()
    self.curH = self.maxH
    score.points = 0
    sTimer.score = 0
    sTimer.current = 0
end