vim.cmd[[
" Using Lua functions
nnoremap ;ff <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>
nnoremap ;fg <cmd>lua require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown{previewer = false})<cr>
nnoremap ;fb <cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>
]]
