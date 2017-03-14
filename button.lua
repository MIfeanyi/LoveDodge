button = class("button",{
    pressed = false,x,y,h,w,img, maxTime = 0.20, waitTime})
function button:init(x,y,h,w)
  self.x,self.y,self.h,self.w = x,y,h,w
  --self.img = love.graphics.newImage(filename)
end

function button:load(x,y,filename)
  print("x: ",x)
  print("y: ", y)
  print("filename: ", filename)
  print("Clicked: ", self.pressed)
  self.x = x
  self.y = y
  self.img = love.graphics.newImage(filename)
  self.h = self.img:getHeight()
  self.w = self.img:getWidth()
  self.pressed = false
end

function button:clicked()
  if love.mouse.isDown(1) then
    --print("clicked")
    if love.mouse.getX() > self.x and love.mouse.getX() < (self.x + self.w) 
    and love.mouse.getY() > self.y and love.mouse.getY() < (self.y + self.h) then
      self.pressed = true
      return true
    else  self.pressed = false end
  end
  return false
end

function button:hover()
  if love.mouse.getX() > self.x and love.mouse.getX() < (self.x + self.w) and love.mouse.getY() > self.y and love.mouse.getY() < (self.y + self.h) then
    return true
  end
  return false
end

function button:draw()
  love.graphics.draw(self.img, self.x, self.y)  
end
