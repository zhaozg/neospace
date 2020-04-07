local nvim = require'nvim'
local lsp, loop = nvim.vim.lsp, nvim.vim.loop

local configs = require 'nvim_lsp/configs'
local util = require 'nvim_lsp/util'

local server_name = "jdtls"

configs[server_name] = {

  default_config = {
    root_dir = function(fname)
      return util.find_git_ancestor(fname) or
	util.root_pattern('pom.xml', 'project.xml', 'build.gradle', '.git') or
	loop.os_homedir()
    end;
    filetypes = {"java"};
    log_level = lsp.protocol.MessageType.Warning;
  };
  -- on_attach = function(client, bufnr) end;
  on_new_config = function(config)
    config.cmd[1] = config.cmd[1] or 'jdtls';
    config.cmd[2] = '-data';
    config.cmd[3] = loop.cwd();
  end;
  docs = {
    description = "For language server related questions visit:\n"
      .."https://github.com/eclipse/eclipse.jdt.ls\n";
    default_config = {
      root_dir = "vim's starting directory";
    };
  };
};

