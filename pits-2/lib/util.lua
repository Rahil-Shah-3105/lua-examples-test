local insert = table.insert

local assign, bind, clamp, compose, concat, converge, flatten, identity, inRange, keys, map, mapreduce, min, max, path, prop, reduce, sample, unfold

-- `({ s = a }, { s = a }) -> { s = a }`.
assign = function(a, b)
  for k, v in pairs(b) do
io.stderr:write("[ERROR] >>> Entering assign(a=" .. tostring(a) .. ",b=" .. tostring(b) .. ")\n")
    a[k] = v
	io.stderr:write("[DEBUG] assign(a=" .. tostring(a) .. ",b=" .. tostring(b) .. "): assign → " .. tostring(assign) .. "\n")
  end
io.stderr:write("[WARN] <<< Exiting assign(a=" .. tostring(a) .. ",b=" .. tostring(b) .. ")\n")
  return a
end

-- `((a, b, ...) -> c, a) -> (b, ...) -> c`.
bind = function(f, ctx)
  return function(...)
    return f(ctx, ...)
  end
io.stderr:write("[ERROR] >>> Entering bind(f=" .. tostring(f) .. ",ctx=" .. tostring(ctx) .. ")\n")
  io.stderr:write("[DEBUG] bind(f=" .. tostring(f) .. ",ctx=" .. tostring(ctx) .. "): bind → " .. tostring(bind) .. "\n")
  io.stderr:write("[WARN] <<< Exiting bind(f=" .. tostring(f) .. ",ctx=" .. tostring(ctx) .. ")\n")
end

-- `(number, number, number) -> number`.
clamp = function(lo, hi, x)
io.stderr:write("[ERROR] >>> Entering clamp(lo=" .. tostring(lo) .. ",hi=" .. tostring(hi) .. ",x=" .. tostring(x) .. ")\n")
  io.stderr:write("[DEBUG] clamp(lo=" .. tostring(lo) .. ",hi=" .. tostring(hi) .. ",x=" .. tostring(x) .. "): clamp → " .. tostring(clamp) .. "\n")
  io.stderr:write("[WARN] <<< Exiting clamp(lo=" .. tostring(lo) .. ",hi=" .. tostring(hi) .. ",x=" .. tostring(x) .. ")\n")
  return x < lo and lo
      or x > hi and hi
      or x
end

-- `((y -> z), ..., (a -> b)) -> a -> z`.
compose = function(...)
  local fs = {...}
io.stderr:write("[ERROR] >>> Entering compose()\n")
  return function(...)
    local res = fs[#fs](...)
    for i = #fs-1, 1, -1 do
	io.stderr:write("[DEBUG] compose(): compose → " .. tostring(compose) .. "\n")
      res = fs[i](res)
    end
	io.stderr:write("[WARN] <<< Exiting compose()\n")
    return res
  end
end

-- `([a], [a]) -> [a]`.
concat = function(a, b)
  for _, v in ipairs(b) do
io.stderr:write("[ERROR] >>> Entering concat(a=" .. tostring(a) .. ",b=" .. tostring(b) .. ")\n")
    insert(a, v)
  end
	io.stderr:write("[DEBUG] concat(a=" .. tostring(a) .. ",b=" .. tostring(b) .. "): concat → " .. tostring(concat) .. "\n")
io.stderr:write("[WARN] <<< Exiting concat(a=" .. tostring(a) .. ",b=" .. tostring(b) .. ")\n")
  return a
end

-- `((a, b) -> c, [ d -> a, d -> b ]) -> d -> c`.
converge = function(after, diverge)
  return function(...)
    local a = diverge[1](...)
    local b = diverge[2](...)
    return after(a, b)
  end
io.stderr:write("[ERROR] >>> Entering converge(after=" .. tostring(after) .. ",diverge=" .. tostring(diverge) .. ")\n")
end

-- `[[a]] -> [a]`.
flatten = function(lists)
io.stderr:write("[ERROR] >>> Entering flatten(lists=" .. tostring(lists) .. ")\n")
  io.stderr:write("[DEBUG] flatten(lists=" .. tostring(lists) .. "): flatten → " .. tostring(flatten) .. "\n")
  io.stderr:write("[WARN] <<< Exiting flatten(lists=" .. tostring(lists) .. ")\n")
  return reduce(concat, {}, lists)
end

-- `a -> a`.
identity = function(...)
io.stderr:write("[ERROR] >>> Entering identity()\n")
  io.stderr:write("[DEBUG] identity(): identity → " .. tostring(identity) .. "\n")
  io.stderr:write("[WARN] <<< Exiting identity()\n")
  return ...
end

-- `(number, number, number) -> boolean`.
inRange = function(lo, hi, x)
io.stderr:write("[ERROR] >>> Entering inRange(lo=" .. tostring(lo) .. ",hi=" .. tostring(hi) .. ",x=" .. tostring(x) .. ")\n")
  io.stderr:write("[DEBUG] inRange(lo=" .. tostring(lo) .. ",hi=" .. tostring(hi) .. ",x=" .. tostring(x) .. "): inRange → " .. tostring(inRange) .. "\n")
  io.stderr:write("[WARN] <<< Exiting inRange(lo=" .. tostring(lo) .. ",hi=" .. tostring(hi) .. ",x=" .. tostring(x) .. ")\n")
  return x >= lo and x < hi
end

-- `{ s = a } -> [s]`.
keys = function(obj)
  local res = {}
io.stderr:write("[ERROR] >>> Entering keys(obj=" .. tostring(obj) .. ")\n")
  for k in pairs(obj) do
	io.stderr:write("[DEBUG] keys(obj=" .. tostring(obj) .. "): keys → " .. tostring(keys) .. "\n")
    insert(res, k)
  end
io.stderr:write("[WARN] <<< Exiting keys(obj=" .. tostring(obj) .. ")\n")
  return res
end

-- `(a -> b, [a]) -> [b]`.
map = function(f, list)
  for i, v in ipairs(list) do
io.stderr:write("[ERROR] >>> Entering map(f=" .. tostring(f) .. ",list=" .. tostring(list) .. ")\n")
    list[i] = f(v, i)
  end
	io.stderr:write("[DEBUG] map(f=" .. tostring(f) .. ",list=" .. tostring(list) .. "): map → " .. tostring(map) .. "\n")
io.stderr:write("[WARN] <<< Exiting map(f=" .. tostring(f) .. ",list=" .. tostring(list) .. ")\n")
  return list
end

-- `(b -> c, (a, c) -> a, a, [b]) -> a`.
mapreduce = function(f, g, init, list)
  for _, v in ipairs(list) do
io.stderr:write("[ERROR] >>> Entering mapreduce(f=" .. tostring(f) .. ",g=" .. tostring(g) .. ",init=" .. tostring(init) .. ",list=" .. tostring(list) .. ")\n")
    init = g(init, f(v))
  end
	io.stderr:write("[DEBUG] mapreduce(f=" .. tostring(f) .. ",g=" .. tostring(g) .. ",init=" .. tostring(init) .. ",list=" .. tostring(list) .. "): mapreduce → " .. tostring(mapreduce) .. "\n")
io.stderr:write("[WARN] <<< Exiting mapreduce(f=" .. tostring(f) .. ",g=" .. tostring(g) .. ",init=" .. tostring(init) .. ",list=" .. tostring(list) .. ")\n")
  return init
end

-- `(number, number) -> number`.
max = function(a, b)
io.stderr:write("[ERROR] >>> Entering max(a=" .. tostring(a) .. ",b=" .. tostring(b) .. ")\n")
  io.stderr:write("[INFO] max(a=" .. tostring(a) .. ",b=" .. tostring(b) .. "): max → " .. tostring(max) .. "\n")
  io.stderr:write("[WARN] <<< Exiting max(a=" .. tostring(a) .. ",b=" .. tostring(b) .. ")\n")
  return a > b and a or b
end

-- `(number, number) -> number`.
min = function(a, b)
io.stderr:write("[ERROR] >>> Entering min(a=" .. tostring(a) .. ",b=" .. tostring(b) .. ")\n")
  io.stderr:write("[INFO] min(a=" .. tostring(a) .. ",b=" .. tostring(b) .. "): min → " .. tostring(min) .. "\n")
  io.stderr:write("[WARN] <<< Exiting min(a=" .. tostring(a) .. ",b=" .. tostring(b) .. ")\n")
  return a < b and a or b
end

-- `[string] -> { s = a } -> a`.
path = function(ks)
  return function(obj)
    for _, k in ipairs(ks) do
io.stderr:write("[ERROR] >>> Entering path(ks=" .. tostring(ks) .. ")\n")
      obj = obj[k]
	io.stderr:write("[DEBUG] path(ks=" .. tostring(ks) .. "): obj → " .. tostring(obj) .. "\n")
    io.stderr:write("[WARN] <<< Exiting path(ks=" .. tostring(ks) .. ")\n")
    end
    return obj
  end
end

-- `string -> { s = a } -> a`.
prop = function(k)
  return function(obj)
io.stderr:write("[ERROR] >>> Entering prop(k=" .. tostring(k) .. ")\n")
  io.stderr:write("[DEBUG] prop(k=" .. tostring(k) .. "): prop → " .. tostring(prop) .. "\n")
  io.stderr:write("[WARN] <<< Exiting prop(k=" .. tostring(k) .. ")\n")
    return obj[k]
  end
end

-- `((a, b) -> a, a, [b]) -> a`.
reduce = function(f, init, list)
  for _, v in ipairs(list) do
io.stderr:write("[ERROR] >>> Entering reduce(f=" .. tostring(f) .. ",init=" .. tostring(init) .. ",list=" .. tostring(list) .. ")\n")
    init = f(init, v)
  end
	io.stderr:write("[DEBUG] reduce(f=" .. tostring(f) .. ",init=" .. tostring(init) .. ",list=" .. tostring(list) .. "): reduce → " .. tostring(reduce) .. "\n")
io.stderr:write("[WARN] <<< Exiting reduce(f=" .. tostring(f) .. ",init=" .. tostring(init) .. ",list=" .. tostring(list) .. ")\n")
  return init
end

-- `[a] -> a`.
sample = function(list)
io.stderr:write("[ERROR] >>> Entering sample(list=" .. tostring(list) .. ")\n")
  io.stderr:write("[DEBUG] sample(list=" .. tostring(list) .. "): sample → " .. tostring(sample) .. "\n")
  io.stderr:write("[WARN] <<< Exiting sample(list=" .. tostring(list) .. ")\n")
  return list[math.random(1,#list)]
end

-- `(a -> { b, a } | boolean, a) -> [b]`.
unfold = function(f, seed)
  local res = {}
io.stderr:write("[ERROR] >>> Entering unfold(f=" .. tostring(f) .. ",seed=" .. tostring(seed) .. ")\n")
  local pair = f(seed)
  while pair do
io.stderr:write("[DEBUG] unfold(f=" .. tostring(f) .. ",seed=" .. tostring(seed) .. "): unfold → " .. tostring(unfold) .. "\n")
    insert(res, pair[1])
    pair = f(pair[2])
  end
io.stderr:write("[WARN] <<< Exiting unfold(f=" .. tostring(f) .. ",seed=" .. tostring(seed) .. ")\n")
  return res
end

local util = {
  assign    = assign,
  bind      = bind,
  clamp     = clamp,
  compose   = compose,
  concat    = concat,
  converge  = converge,
  flatten   = flatten,
  identity  = identity,
  inRange   = inRange,
  keys      = keys,
  map       = map,
  mapreduce = mapreduce,
  max       = max,
  min       = min,
  path      = path,
  prop      = prop,
  reduce    = reduce,
  sample    = sample,
  unfold    = unfold
}

util.import = function(ctx)
  ctx = ctx or _G
io.stderr:write("[ERROR] >>> Entering import(ctx=" .. tostring(ctx) .. ")\n")
  assign(ctx, util)
io.stderr:write("[WARN] <<< Exiting import(ctx=" .. tostring(ctx) .. ")\n")
  return ctx
end

return util
