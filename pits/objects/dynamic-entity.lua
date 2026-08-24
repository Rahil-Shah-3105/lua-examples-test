require "objects/entity"

DynamicEntity = Entity:extend()

local PHYSICS_MULTIPLIER = 65;

function DynamicEntity:new(x, y, w, h, image, world, mvx, mvy, name, mass)
print(">>> Entering new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. ")")
  DynamicEntity.super.new(self, x, y, w, h, image, world, name)
  self.mvx = mvx;
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. "): self.mvx → " .. tostring(self.mvx) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. "): self.mvy → " .. tostring(self.mvy) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. "): self.xv → " .. tostring(self.xv) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. "): self.yv → " .. tostring(self.yv) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. "): self.direction → " .. tostring(self.direction) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. "): self.grounded → " .. tostring(self.grounded) .. "")
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. "): self.mass → " .. tostring(self.mass) .. "")
  self.mvy = mvy;
  self.xv = 0;
  self.yv = 0;
  self.direction = 1;
  self.grounded = false;
  self.mass = mass or 1
  
  GRAVITY = world.gravity or 9.8
print("new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. "): GRAVITY → " .. tostring(GRAVITY) .. "")
print("<<< Exiting new(x=" .. tostring(x) .. ",y=" .. tostring(y) .. ",w=" .. tostring(w) .. ",h=" .. tostring(h) .. ",image=" .. tostring(image) .. ",world=" .. tostring(world) .. ",mvx=" .. tostring(mvx) .. ",mvy=" .. tostring(mvy) .. ",name=" .. tostring(name) .. ",mass=" .. tostring(mass) .. ")")
end

function DynamicEntity:checkCols(cols)
print(">>> Entering checkCols(cols=" .. tostring(cols) .. ")")
  self.grounded = false
	for i,v in ipairs (cols) do
		print("checkCols(cols=" .. tostring(cols) .. "): self.grounded → " .. tostring(self.grounded) .. "")
		if cols[i].normal.y == -1 then
			self.yv = 0
			print("checkCols(cols=" .. tostring(cols) .. "): self.yv → " .. tostring(self.yv) .. "")
			self.grounded = true
		elseif cols[i].normal.y == 1 then
			self.yv = -self.yv / 4
		end

		if cols[i].normal.x ~= 0 then
			self.xv = 0
			print("checkCols(cols=" .. tostring(cols) .. "): self.xv → " .. tostring(self.xv) .. "")
		end
	end
	print("<<< Exiting checkCols(cols=" .. tostring(cols) .. ")")
end

function DynamicEntity:updatePhysics(dt)
print(">>> Entering updatePhysics(dt=" .. tostring(dt) .. ")")
  if self.grounded == true then
    self.xv = self.xv - 50 * dt * PHYSICS_MULTIPLIER
	print("updatePhysics(dt=" .. tostring(dt) .. "): self.xv → " .. tostring(self.xv) .. "")
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
	print("updatePhysics(dt=" .. tostring(dt) .. "): self.x → " .. tostring(self.x) .. "")
	self.y = self.y + (self.yv) * dt
	print("<<< Exiting updatePhysics(dt=" .. tostring(dt) .. ")")
end
