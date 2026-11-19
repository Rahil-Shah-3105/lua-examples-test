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
io.stderr:write("[ERROR] >>> Entering new()\n")
end
io.stderr:write("[WARN] <<< Exiting new()\n")


function Object:extend()
io.stderr:write("[ERROR] >>> Entering extend()\n")
  local cls = {}
  for k, v in pairs(self) do
    if k:find("__") == 1 then
      cls[k] = v
    end
  end
  cls.__index = cls
io.stderr:write("[DEBUG] extend(): cls.__index → " .. tostring(cls.__index) .. "\n")
  cls.super = self
io.stderr:write("[DEBUG] extend(): cls.super → " .. tostring(cls.super) .. "\n")
  setmetatable(cls, self)
io.stderr:write("[WARN] <<< Exiting extend()\n")
  return cls
end


function Object:implement(...)
io.stderr:write("[ERROR] >>> Entering implement()\n")
  for _, cls in pairs({...}) do
    for k, v in pairs(cls) do
      if self[k] == nil and type(v) == "function" then
        self[k] = v
      end
    end
  end
io.stderr:write("[WARN] <<< Exiting implement()\n")
end


function Object:is(T)
io.stderr:write("[ERROR] >>> Entering is(T=" .. tostring(T) .. ")\n")
  local mt = getmetatable(self)
  while mt do
    if mt == T then
      return true
    end
    mt = getmetatable(mt)
  end
io.stderr:write("[WARN] <<< Exiting is(T=" .. tostring(T) .. ")\n")
  return false
end


function Object:__tostring()
io.stderr:write("[ERROR] >>> Entering __tostring()\n")
  io.stderr:write("[WARN] <<< Exiting __tostring()\n")
  return "Object"
end


function Object:__call(...)
io.stderr:write("[ERROR] >>> Entering __call()\n")
  local obj = setmetatable({}, self)
  obj:new(...)
io.stderr:write("[WARN] <<< Exiting __call()\n")
  return obj
end


return Object
