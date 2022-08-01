local P = {}
local ffi = require("ffi")

if ffi.os == "OSX" then
  P[#P + 1] = {
    "zhaozg/vim-xcode",
    opt = true,
    on = { "Xbuild", "Xrun", "Xtest" },
    init = function()
      vim.g.xcode_xcpretty_flags = ""
      vim.g.xcode_default_simulator = "iPhone 11 Pro Max"
    end,
  }
end

return P
