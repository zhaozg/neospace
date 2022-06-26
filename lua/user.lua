local vim = vim
local packs = {}

local function use(args)
  local pack = {}

  if type(args) == "string" then
    pack.name = args
  elseif type(args) == "table" then
    if args.disabled then
      return
    end

    pack.name = args[1]

    pack.repo = args.repo
    pack.branch = args.branch

    pack.subdir = args.subdir

    pack.init = args.init
    pack.config = args.config

    pack.install = args.install
    pack.update = args.update

    if type(args.after) == "string" then
      pack.after = { args.after }
    else
      pack.after = args.after
    end
  else
    error("user.use -- invalid args")
  end

  if packs[pack.name] then
    return packs[pack.name]
  end

  packs[#packs + 1] = pack

  return pack
end

local function setup(options)
  options = options or {}
  options.repo_base = "https://github.com/"
  local manager = require("user.plugins").manage(packs, options)

  vim.api.nvim_create_user_command("PluginsUpgrade", manager.upgrade, {})
  vim.api.nvim_create_user_command("PluginsAutoremove", manager.autoremove, {})
  return manager
end

return {
  setup = setup,
  use = use,
}
