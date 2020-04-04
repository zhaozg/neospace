local nvim = require 'neospace.nvim'
local fun = require 'neospace.fun'
local vim = nvim.vim

local window = require 'neospace.window'

local M = {}

M._VERSION = "0.0.1"

M.buf = nil
M.win = nil

M.keymap = function(filter, mode)
  mode = mode or nvim.get_mode().mode
  local maps = nvim.get_keymap(mode)

  local results = {}
  if filter then

    fun.each(function(map)
      if map.lhs:find(filter, 1, true) == 1 then
        local k = map.lhs:sub(#filter + 1)
        if #k==0 then
          results = map.rhs
        elseif #k==1 then
          results[k] = map.rhs
        end
      end
    end, maps)

  end
  return results
end

M.execute = function(cmd)
  M.hide()
  local cmds = nvim.vim.split(cmd, ' \t')
  if cmd:find('<Plug>', 1, true)==1 then
    cmd = ':execute "normal \\'..cmd..'"'
    nvim.command(cmd)
    return true
  elseif nvim.fn.exists(':'..cmds[1])==1 then
    nvim.command(cmd)
    return true
  else
    cmd = table.remove(cmds, 1)
    cmd = cmd:gsub('%(%)','')
    if #cmds >0 then
      nvim.fn[cmd](cmds)
    else
      nvim.fn[cmd]()
    end
    return true
  end
  return false
end

M.select = function(filter)
  local maps = nvim.g.neospace_leader_map
  local cmd

  for i=1, #filter do
    maps = maps[filter:sub(i, i)]
  end

  if type(maps)=='string' then
    cmd = maps
  elseif maps and #maps > 0 then
    cmd = maps[1]
  else
    local keys = M.keymap(filter)
    if type(keys)=='string' then
      cmd = keys
    else
      maps = vim.tbl_extend('keep', maps or {}, keys)
    end
  end

  if cmd and
    (filter~=nvim.g.mapleader and filter~=nvim.g.maplocalleader) then
    return M.execute(cmd)
  end

  if vim.tbl_isempty(maps) then
    return
  end

  maps.name = nil

  local results = {}
  fun.each(function(k, v)
    if type(v)=='string' then
      results[#results + 1] = string.format('%s %s', k, v)
    else
      results[#results + 1] = string.format('%s %s', k, v.name and v.name or v[2])
    end
  end, maps)
  return results
end

M.menu = function(width, filter)
  local maxl = 0
  local lines = M.select(filter)
  if type(lines)~='table' then
    return lines
  end

  fun.each(function(line)
    if #line>maxl then
      maxl = #line
    end
  end, lines)
  maxl = maxl + 2

  table.sort(lines, function(s1, s2)
    s1, s2 = string.sub(s1, 1, 1):lower(), string.sub(s2, 1, 1):lower()
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

M.hide = function()
  if M.timer then
    M.timer:stop()
    M.timer:close()
    M.timer = nil
  end
  if M.win and nvim.win_is_valid(M.win) then
    nvim.win_close(M.win, true)
  end
  M.buf, M.win = nil, nil
end

M.show = function(lines, wopts)
  if M.win==nil and M.buf==nil then
    M.win, M.buf = window.float(wopts)

    nvim.bo[M.buf].filetype = 'nofile'
    nvim.buf_set_keymap(M.buf, 'n', '\\<ESC>', 'q\\<CR>', {silent=true})
  end
  nvim.bl[M.buf][0] = {-1, true, lines}
end

M.active = function(key, wopts)
  local lines = M.menu(wopts.width, key)
  if type(lines) == 'boolean' or lines==nil or #lines==0 then
    return
  end

  if M.win then
    M.show(lines, wopts)
  else
    if M.timer then
      M.timer:stop()
    else
      M.timer = vim.loop.new_timer()
    end

    M.timer:start(100, 0, vim.schedule_wrap(function ()
      M.timer:stop()
      M.timer:close()
      M.timer = nil
      M.show(lines, wopts)
    end))
  end

  nvim.command('redraw')
  local userAction = nvim.fn.getchar()
  userAction = nvim.fn.nr2char(userAction)

  M.active(key..userAction, wopts)
end

M.leader = function(key, wopts)
  key = key or ' '
  wopts = wopts or {}
  wopts.width = wopts.width or nvim.o.columns
  wopts.height = wopts.height or 5
  wopts.col = wopts.col or  0
  wopts.row = wopts.row or nvim.o.lines - wopts.height
  wopts.relative = wopts.relative or 'editor'
  wopts.focusable = false

  M.active(key, wopts)
end

return M

