--Image manager
--Goal reuse images without using too much memory
images ={}

function addImage(src,id)
  image = love.graphics.newImage(src)
  newImage = {img = image, id=id}
  if newImage.id == "" then
    newImage.id = "default"
  end
  table.insert(images,newImage)
end

function getImage(id)
  --loop and return img
  for i, img in ipairs(images) do
    if img.id == id then
      return img.img
    end
  end
  if id == nil then return images[1] end
  return nil
end
function deleteImage(id)
    for i, img in ipairs(images) do
    if img.id == id then
      return img.img
    end
  end
  return nil
end
