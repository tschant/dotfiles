local Hydra = require('hydra')

local function cmd(command)
   return table.concat({ '<Cmd>', command, '<CR>' })
end

local hint = [[
                 _f_: files       _m_: marks
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _o_: old files   _g_: live grep
  🭉🭁🭠🭘    🭣🭕🭌🬾   _p_: projects    _/_: search in file
  🭅█ ▁     █🭐   _s_: sessions    
	██🬿      🭊██
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _r_: resume      _u_: undotree
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _h_: vim help    _c_: spell suggest
                 _k_: keymaps     _;_: commands history 
                 _O_: options     _?_: search history
                 _b_: buffers     _x_: colorscheme
 ^
                 _<Enter>_: Telescope           _<Esc>_
]]

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
      { 'm', cmd 'Telescope marks', { desc = 'marks' } },
      { 'k', cmd 'Telescope keymaps' },
      { 'O', cmd 'Telescope vim_options' },
      { 'r', cmd 'Telescope registers' },
      { 's', cmd 'Telescope session-lens search_session', { desc = 'sessions' } },
      -- { 'p', cmd 'Telescope projections', { desc = 'projects' } },
      { 'p', function ()
				-- require'telescope'.extensions.project.project{ display_type = 'full' }
				local find_projects = require("telescope").extensions.projections.projections
				find_projects({
					action = function(selection)
						-- chdir is required since there might not be a session file
						vim.fn.chdir(selection.value)
						vim.api.nvim_command('RestoreSession')
					end,
				})
			end, { desc = 'projects' } },
      { '/', cmd 'Telescope current_buffer_fuzzy_find', { desc = 'search in file' } },
      { '?', cmd 'Telescope search_history',  { desc = 'search history' } },
      { ';', cmd 'Telescope command_history', { desc = 'command-line history' } },
      { 'c', cmd 'Telescope spell_suggest', { desc = 'spell suggest' } },
      { 'x', cmd 'Telescope colorscheme', { desc = 'choose colorscheme' } },
      { 'u', cmd 'silent! %foldopen! | UndotreeToggle', { desc = 'undotree' }},
      { '<Enter>', cmd 'Telescope', { exit = true, desc = 'list all pickers' } },
      { '<Esc>', nil, { exit = true, nowait = true } },
   }
})
