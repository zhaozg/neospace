return {
  {
    'dense-analysis/ale',
    opt = true,
    init = function()
      vim.g.ale_hover_to_preview = 1
    end,
    config = function()
      vim.cmd("nmap <silent> [e <Plug>(ale_previous_wrap)")
      vim.cmd("nmap <silent> ]e <Plug>(ale_next_wrap)")
    end
  }
}

