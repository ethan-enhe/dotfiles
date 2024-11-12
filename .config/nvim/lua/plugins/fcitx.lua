return {
    'h-hg/fcitx.nvim',
    cond = vim.fn.executable('fcitx5-remote') == 1,
    config = function()
        vim.cmd [[
    let g:im_select_get_im_cmd = ['fcitx5-remote']
    let g:ImSelectSetImCmd = {key -> ['fcitx5-remote', key]}
    let g:im_select_default = '1'                      " The default value on Windows
]]
    end
}
