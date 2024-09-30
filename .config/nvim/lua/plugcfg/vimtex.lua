

vim.opt.conceallevel=1
vim.g.tex_conceal='abdmg'
vim.g.vimtex_view_method = "zathura"
vim.cmd[[
  " Compile on initialization, cleanup on quit
  augroup vimtex_event_1
    au!
    au User VimtexEventQuit     VimtexClean
    au User VimtexEventInitPost VimtexCompile
  augroup END

  " Close viewers when VimTeX buffers are closed
  function! CloseViewers()
    if executable('xdotool')
          \ && exists('b:vimtex.viewer.xwin_id')
          \ && b:vimtex.viewer.xwin_id > 0
      call system('xdotool windowclose '. b:vimtex.viewer.xwin_id)
    endif
  endfunction

  augroup vimtex_event_2
    au!
    au User VimtexEventQuit call CloseViewers()
  augroup END

  " Add custom mappings in ToC buffer
  function! TocMappings()
    " You probably don't want to do this, though...
    nnoremap <silent><buffer><nowait> q :quitall!
  endfunction

  augroup vimtex_event_3
    au!
    au User VimtexEventTocCreated call TocMappings()
  augroup END

  " Specify window position when opening ToC entries
  augroup vimtex_event_4
    au!
    au User VimtexEventTocActivated normal! zt
  augroup END

  " Specify extra behaviour after reverse goto
  augroup vimtex_event_4
    au!
    au User VimtexEventViewReverse normal! zMzvzz
  augroup END
]]

-- vim.g.tex_flavor='latex'
-- vim.g.vimtex_view_method='zathura'
-- vim.g.vimtex_quickfix_mode=0
-- vim.cmd([[
-- let g:vimtex_compiler_latexmk = {
--     \ 'options' : [
--     \   '-pdf',
--     \   '-shell-escape',
--     \   '-verbose',
--     \   '-file-line-error',
--     \   '-synctex=1',
--     \   '-interaction=nonstopmode',
--     \ ],
--     \}
-- ]])
