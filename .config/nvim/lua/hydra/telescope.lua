local Hydra = require('hydra')

local function cmd(command)
   return table.concat({ '<Cmd>', command, '<CR>' })
end

local hint = [[
                 _f_: files       _m_: marks
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _o_: old files   _g_: live grep
  🭉🭁🭠🭘    🭣🭕🭌🬾   _p_: projects    _/_: search in file
  🭅█ ▁     █🭐
  ██🬿      🭊██   _r_: resume      _u_: undotree
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _h_: vim help    _c_: execute command
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _k_: keymaps     _;_: commands history 
                 _O_: options     _?_: search history
                 _b_: buffers     _x_: colorscheme
 ^
                 _<Enter>_: Telescope           _<Esc>_
]]


-- Telescope
-- u.map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({hidden = true})<CR>")
-- u.map("n", "<leader>fg", ":Telescope live_grep<CR>")
-- u.map("n", "<Leader>fo", ":lua require('telescope.builtin').oldfiles()<CR>")
-- u.map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>")
-- u.map("n", "<leader>fc", ":lua require('telescope.builtin').colorscheme()<CR>")
-- u.map("n", "<leader>fa", ":lua require('utils.core').search_dotfiles()<CR>")
-- -- u.map("n", "<leader>fn", ":lua require('utils.core').search_nvim()<CR>")
-- u.map("n", "<leader>bb", ":lua require('telescope.builtin').buffers()<CR>")
-- u.map("n", "<leader>fp", ":Telescope projects<CR>")

Hydra({
   name = 'Telescope',
   hint = hint,
   config = {
      color = 'teal',
      invoke_on_body = true,
      hint = {
         position = 'middle',
         border = 'rounded',
      },
   },
   mode = 'n',
   body = '<Leader>f',
   heads = {
      { 'f', cmd 'Telescope find_files' },
      { 'g', cmd 'Telescope live_grep' },
      { 'o', cmd 'Telescope oldfiles', { desc = 'recently opened files' } },
      { 'h', cmd 'Telescope help_tags', { desc = 'vim help' } },
      { 'b', cmd 'Telescope buffers' },
      { 'm', cmd 'MarksListBuf', { desc = 'marks' } },
      { 'k', cmd 'Telescope keymaps' },
      { 'O', cmd 'Telescope vim_options' },
      { 'r', cmd 'Telescope resume' },
      { 'p', cmd 'Telescope projects', { desc = 'projects' } },
      { '/', cmd 'Telescope current_buffer_fuzzy_find', { desc = 'search in file' } },
      { '?', cmd 'Telescope search_history',  { desc = 'search history' } },
      { ';', cmd 'Telescope command_history', { desc = 'command-line history' } },
      { 'c', cmd 'Telescope commands', { desc = 'execute command' } },
      { 'x', cmd 'Telescope colorscheme', { desc = 'choose colorscheme' } },
      { 'u', cmd 'silent! %foldopen! | UndotreeToggle', { desc = 'undotree' }},
      { '<Enter>', cmd 'Telescope', { exit = true, desc = 'list all pickers' } },
      { '<Esc>', nil, { exit = true, nowait = true } },
   }
})
