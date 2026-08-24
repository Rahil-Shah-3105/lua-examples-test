Entity = Object:extend();

function Entity:new(x, y, width, height, image, world, ent_name)
print(">>> Entering new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",ent_name=" .. tostring(ent_name) .. ")")
  self.x = x or 0;
  self.y = y or 0;
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",ent_name=" .. tostring(ent_name) .. "): self.y → " .. tostring(self.y) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",ent_name=" .. tostring(ent_name) .. "): self.w → " .. tostring(self.w) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",ent_name=" .. tostring(ent_name) .. "): self.h → " .. tostring(self.h) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",ent_name=" .. tostring(ent_name) .. "): self.image → " .. tostring(self.image) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",ent_name=" .. tostring(ent_name) .. "): self.name → " .. tostring(self.name) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",ent_name=" .. tostring(ent_name) .. "): self.x → " .. tostring(self.x) .. "")
  self.w = width or 32;
  self.h = height or 32;
  self.image = image;
  self.name = ent_name or "base_entity";
  
  if world ~= nil then
    world:add(self, self.x, self.y, self.w, self.h)
  end
print("<<< Exiting new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",ent_name=" .. tostring(ent_name) .. ")")
end

function Entity:draw()
print(">>> Entering draw()")
  if self.image ~= nil then
    love.graphics.draw(self.image, self.x, self.y)
  end
print("<<< Exiting draw()")
end