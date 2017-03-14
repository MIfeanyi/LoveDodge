local padding = 5
button = class("button",{
    pressed = false,x,y,h,w,img,id,text="button", maxTime = 0.20, waitTime})
function button:init(x,y,h,w)
  self.x,self.y,self.h,self.w = x,y,h,w
  --self.img = love.graphics.newImage(id)
end

function button:load(x,y,text,id)
  print("x: ",x)
  print("y: ", y)
  print("id: ", id)
  print("Clicked: ", self.pressed)
  self.x = x
  self.y = y
  self.text=text
  self.id = id
  self.h = getImage(id):getHeight()
  self.w = getImage(id):getWidth()
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
  love.graphics.draw(getImage(self.id), self.x, self.y)  
  love.graphics.print(self.text,self.x+padding,self.y+self.h*.3)
end
