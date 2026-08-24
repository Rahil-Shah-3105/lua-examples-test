--
-- classic
--
-- Copyright (c) 2014, rxi
--
-- This module is free software; you can redistribute it and/or modify it under
-- the terms of the MIT license. See LICENSE for details.
--


local Object = {}
Object.__index = Object


function Object:new()
print(">>> Entering new()")
end


function Object:extend()
  local cls = {}
print(">>> Entering extend()")
  for k, v in pairs(self) do
    if k:find("__") == 1 then
      cls[k] = v
    end
  end
  cls.__index = cls
print("extend(): cls.__index → " .. tostring(cls.__index) .. "")
print("extend(): cls.super → " .. tostring(cls.super) .. "")
  cls.super = self
  setmetatable(cls, self)
print("<<< Exiting extend()")
  return cls
end


function Object:implement(...)
  for _, cls in pairs({...}) do
	print(">>> Entering implement()")
    for k, v in pairs(cls) do
      if self[k] == nil and type(v) == "function" then
        self[k] = v
      end
    end
  end
end


function Object:is(T)
print(">>> Entering is(T=" .. tostring(T) .. ")")
  local mt = getmetatable(self)
  while mt do
    if mt == T then
      return true
    end
    mt = getmetatable(mt)
  end
print("<<< Exiting is(T=" .. tostring(T) .. ")")
  return false
end


function Object:__tostring()
print(">>> Entering __tostring()")
  print("<<< Exiting __tostring()")
  return "Object"
end


function Object:__call(...)
  local obj = setmetatable({}, self)
  obj:new(...)
  return obj
print(">>> Entering __call()")
print("<<< Exiting __call()")
end


return Object
