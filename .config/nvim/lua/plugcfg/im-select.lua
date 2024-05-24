-- -- 设置 im-select 的路径
-- vim.g.im_select_command = "im-select.exe"
-- -- normal 模型下采用英文输入法
-- vim.g.im_select_default = "1033"
-- -- 如果您的桌面已经开启“在不同的窗口/应用程序之间切换输入法”的功能，可能需要将此选项设置为 0
--a
-- vim.g.im_select_enable_focus_events = 0
vim.cmd [[
let g:im_select_get_im_cmd = ['fcitx5-remote']
let g:ImSelectSetImCmd = {key -> ['fcitx5-remote', key]}
let g:im_select_default = '1'                      " The default value on Windows
]]
