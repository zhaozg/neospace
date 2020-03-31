local nvim = require 'neospace.nvim'
local fun = require 'neospace.fun'

local window = require 'neospace.window'

local M = {}

M._VERSION = "0.0.1"

M.float = window.float

M.keymap = function(mode, filter)
  mode = mode or nvim.get_mode().mode
  local maps = nvim.get_keymap(mode)

  local results = {}
  if filter then

    fun.each(function(map)
      if map.lhs:find(filter, 1, true) == 1 then
        local k = map.lhs:sub(#filter + 1)
        results[#results + 1] = string.format('%s %s', k, map.rhs)
      end
    end, maps)

  end
  return results
end

M.leader_map = function(mode, filter)
  local maps = nvim.g['neospace_map']
  local results = {}
  fun.each(function(k, v)
    if k~='?' then
      results[#results + 1] = string.format('%s %s', k, v.name and v.name or v[2])
    end
  end, maps)
  return results
end

M.items = function(width, mode, filter)
  --local lines = M.keymap(mode, filter)
  local lines = M.leader_map(mode, filter)
  local maxl = 0

  fun.each(function(line)
    if #line>maxl then
      maxl = #line
    end
  end, lines)
  maxl = maxl + 2

  table.sort(lines, function(s1, s2)
    s1, s2 = string.sub(s1, 1, 1):lower(), string.sub(s2, 1, 1):lower()
    if s1=='?' then return true end
    return s1:byte(1) < s2:byte(1)
  end)

  local fixed = {}
  fun.each(function(line)
    line = line .. string.rep(' ', maxl - #line)
    fixed[#fixed + 1] = line
  end, lines)

  local nums = math.floor( width / maxl)
  local pad = math.floor( (width - maxl * nums) / 2 + 0.5)
  pad = string.rep(' ', pad)

  local i = 1
  lines = {}
  fun.some(function(line)
    if (i % nums == 1) then
      lines[#lines + 1] = pad .. line
    else
      lines[#lines] = lines[#lines] .. line
    end
    i = i + 1
  end, fixed)

  return lines
end

M.leader = function(key)
  key = key or ' '
  local wopts = {}
  wopts.width = nvim.o.columns
  wopts.height = 5
  wopts.col = 0
  wopts.row = nvim.o.lines - wopts.height
  wopts.relative = 'editor'

  local win, buf = window.float(wopts)

  local lines = M.items(wopts.width, 'n', key)

  nvim.bl[buf][0] = {-1, true, lines}
end

return M

