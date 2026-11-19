Entity = Object:extend();

function Entity:new(x, y, width, height, image, world, ent_name)
io.stderr:write("[ERROR] >>> Entering new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",ent_name=" .. tostring(ent_name) .. ")\n")
  self.x = x or 0;
  self.y = y or 0;
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",ent_name=" .. tostring(ent_name) .. "): self.y → " .. tostring(self.y) .. "\n")
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",ent_name=" .. tostring(ent_name) .. "): self.x → " .. tostring(self.x) .. "\n")
  self.w = width or 32;
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",ent_name=" .. tostring(ent_name) .. "): self.w → " .. tostring(self.w) .. "\n")
  self.h = height or 32;
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",ent_name=" .. tostring(ent_name) .. "): self.h → " .. tostring(self.h) .. "\n")
  self.image = image;
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",ent_name=" .. tostring(ent_name) .. "): self.image → " .. tostring(self.image) .. "\n")
  self.name = ent_name or "base_entity";
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",ent_name=" .. tostring(ent_name) .. "): self.name → " .. tostring(self.name) .. "\n")
  
  if world ~= nil then
    world:add(self, self.x, self.y, self.w, self.h)
  end
io.stderr:write("[WARN] <<< Exiting new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",width=" .. tostring(width) .. ",height=" .. tostring(height) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",ent_name=" .. tostring(ent_name) .. ")\n")
end

function Entity:draw()
io.stderr:write("[ERROR] >>> Entering draw()\n")
  if self.image ~= nil then
    love.graphics.draw(self.image, self.x, self.y)
  end
io.stderr:write("[WARN] <<< Exiting draw()\n")
end