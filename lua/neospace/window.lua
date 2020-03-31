local vim  = vim
local nvim = require'nvim'

local M = {}

local floats = {}

local function buf_is_(bufnr)
  for _, term in ipairs(floats) do
    if term.bufnr == bufnr then
      return true
    end
  end
  return false
end

function M.IS_FLOAT()
  return buf_is_(nvim.get_current_buf())
end


function M.float(wopts, bopts)
  wopts = wopts or {}
  local height = nvim.o.lines
  local columns = nvim.o.columns

  local width = columns

  wopts.relative = wopts.relative or 'cursor'
  wopts.style = wopts.style or  'minimal';
  wopts.row = wopts.row or 0
  wopts.col = wopts.col or 0
  wopts.width = wopts.width or width
  wopts.height = wopts.height or height * 2 / 3

  local buf = nvim.create_buf(false, true)
  local win = nvim.open_win(buf, true, wopts)

  bopts = bopts or {}
  bopts.buftype='nofile'
  bopts.buflisted=false
  bopts.bufhidden='hide'

  for k,v in pairs(bopts) do
    nvim.bo[buf][k] = v
  end
  return win, buf
end

return M

