require "objects/entity"

DynamicEntity = Entity:extend()

local PHYSICS_MULTIPLIER = 65;

function DynamicEntity:new(x, y, w, h, image, world, mvx, mvy, name, mass)
io.stderr:write("[ERROR] >>> Entering new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. ")\n")
  DynamicEntity.super.new(self, x, y, w, h, image, world, name)
  self.mvx = mvx;
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. "): self.mvx → " .. tostring(self.mvx) .. "\n")
  self.mvy = mvy;
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. "): self.mvy → " .. tostring(self.mvy) .. "\n")
  self.xv = 0;
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. "): self.xv → " .. tostring(self.xv) .. "\n")
  self.yv = 0;
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. "): self.yv → " .. tostring(self.yv) .. "\n")
  self.direction = 1;
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. "): self.direction → " .. tostring(self.direction) .. "\n")
  self.grounded = false;
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. "): self.grounded → " .. tostring(self.grounded) .. "\n")
  self.mass = mass or 1
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. "): self.mass → " .. tostring(self.mass) .. "\n")
  
  GRAVITY = world.gravity or 9.8
io.stderr:write("[DEBUG] new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. "): GRAVITY → " .. tostring(GRAVITY) .. "\n")
io.stderr:write("[WARN] <<< Exiting new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. ")\n")
end

function DynamicEntity:checkCols(cols)
io.stderr:write("[ERROR] >>> Entering checkCols(cols=" .. tostring(cols) .. ")\n")
  self.grounded = false
	for i,v in ipairs (cols) do
		io.stderr:write("[DEBUG] checkCols(cols=" .. tostring(cols) .. "): self.grounded → " .. tostring(self.grounded) .. "\n")
		if cols[i].normal.y == -1 then
			self.yv = 0
			io.stderr:write("[DEBUG] checkCols(cols=" .. tostring(cols) .. "): self.yv → " .. tostring(self.yv) .. "\n")
			self.grounded = true
		elseif cols[i].normal.y == 1 then
			self.yv = -self.yv / 4
		end

		if cols[i].normal.x ~= 0 then
			self.xv = 0
			io.stderr:write("[DEBUG] checkCols(cols=" .. tostring(cols) .. "): self.xv → " .. tostring(self.xv) .. "\n")
		end
	end
	io.stderr:write("[WARN] <<< Exiting checkCols(cols=" .. tostring(cols) .. ")\n")
end

function DynamicEntity:updatePhysics(dt)
io.stderr:write("[ERROR] >>> Entering updatePhysics(dt=" .. tostring(dt) .. ")\n")
  if self.grounded == true then
    self.xv = self.xv - 50 * dt * PHYSICS_MULTIPLIER
	io.stderr:write("[DEBUG] updatePhysics(dt=" .. tostring(dt) .. "): self.xv → " .. tostring(self.xv) .. "\n")
  else
    self.xv = self.xv - (8 * self.mass) * dt * PHYSICS_MULTIPLIER
  end
	
	self.yv = self.yv + (GRAVITY) * dt * PHYSICS_MULTIPLIER

	if self.xv > self.mvx then 
    self.xv = self.mvy
  end

	if self.xv < 0 then 
    self.xv = 0 
  end

	self.x = self.x + self.direction * self.xv * dt
	io.stderr:write("[DEBUG] updatePhysics(dt=" .. tostring(dt) .. "): self.x → " .. tostring(self.x) .. "\n")
	self.y = self.y + (self.yv) * dt
	io.stderr:write("[WARN] <<< Exiting updatePhysics(dt=" .. tostring(dt) .. ")\n")
end
