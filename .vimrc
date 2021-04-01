set nocompatible
set modelines=5

syntax on
filetype off

" setlocal spell spelllang=en_us
set spell
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#rc()

set t_Co=256
set background=dark
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nowrap
set autoindent

let mapleader = ','

nnoremap ; :
set encoding=utf-8

Bundle 'VundleVim/Vundle.vim'
Bundle 'scrooloose/nerdtree'
Bundle "jnurmine/Zenburn"
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'flazz/vim-colorschemes'
Bundle 'corntrace/bufexplorer'
Plugin 'ntk148v/vim-horizon'
Plugin 'tpope/vim-surround'
Plugin 'mg979/vim-visual-multi'
Plugin 'kien/ctrlp.vim'

"Bundle 'Lokaltog/vim-powerline'
Bundle 'bling/vim-airline'
Bundle 'benmills/vimux'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'

" Pick one of the checksyntax, jslint, or syntastic
Bundle 'scrooloose/syntastic'
Plugin 'mtscout6/syntastic-local-eslint.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'godlygeek/tabular'
Bundle 'terryma/vim-multiple-cursors'

if executable('ctags')
  Bundle 'majutsushi/tagbar'
  Bundle 'xolox/vim-misc'
  Bundle 'xolox/vim-easytags'
  Bundle 'vim-scripts/taglist.vim'
endif

Bundle 'Shougo/neocomplcache'
Bundle 'honza/dockerfile.vim'
Bundle 'rodjek/vim-puppet'
Bundle 'groenewege/vim-less'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'elzr/vim-json'
Bundle "pangloss/vim-javascript"
Bundle 'othree/html5.vim'
Bundle 'shinokada/dragvisuals.vim'
Bundle 'tpope/vim-markdown'
Bundle 'sjl/gundo.vim'
Bundle 'mhinz/vim-signify'
Bundle 'vim-ruby/vim-ruby'
Bundle 'ConradIrwin/vim-bracketed-paste'

map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1

set backspace=indent,eol,start  " backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " show matching brackets/parenthesis
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set winminheight=0              " windows can be 0 line high
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present
set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set foldenable                  " auto fold code
set list
set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace

colorscheme horizon
set background=dark

let g:Tex_ViewRule_pdf='Preview'
let g:Tex_CompileRule_pdf = 'xelatex --interaction=nonstopmode --shell-escape $*'
set laststatus=2

set timeoutlen=1000 ttimeoutlen=0
nnoremap <silent> <leader>tt :TagbarToggle<CR>
nnoremap <leader>i :set invpaste paste?<CR>
set pastetoggle=<leader>i
set showmode
let g:Tlist_Use_Right_Window   = 1
let Tlist_WinWidth = 50
" let g:neocomplcache_enable_at_startup = 1
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
let g:easytags_suppress_ctags_warning = 1
set tags=~/.vimtags
map <leader>fi :setlocal foldmethod=indent<cr>
map <leader>fs :setlocal foldmethod=syntax<cr>
let g:syntastic_always_populate_loc_list=1
filetype plugin indent on
let g:is_bash = 1
let g:sh_fold_enabled = 3
let g:vim_json_syntax_conceal = 1
set foldmethod=syntax

" http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

autocmd BufWritePre * :%s/\s\+$//e

" do not regard "-" as word seperator (css Files!)
set iskeyword+=-

let g:xml_syntax_folding=1

" For dragvisuals
runtime plugin/dragvisuals.vim
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" For Gundo
nnoremap <leader>u :GundoToggle<CR>

" ctrlp settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*.class,*.encrypted

"vim-arline"
"let g:airline_branch_prefix     = '⭠'
"let g:airline_readonly_symbol   = '⭤'
"let g:airline_linecolumn_prefix = '⭡'
"let g:airline_enable_branch     = 1
"let g:airline_enable_syntastic  = 1
"

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#tagbar#enabled = 1

"" vim-powerline symbols
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_left_sep          = ''
let g:airline_left_alt_sep      = ''
let g:airline_right_sep         = ''
let g:airline_right_alt_sep     = ''

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.readonly  = ''
let g:airline_symbols.linenr    = ''
let g:airline_symbols.branch    = ''

" vim-signify
let g:signify_vcs_list = [ 'git', 'svn' ]

" Sudo write
cmap w!! w !sudo tee > /dev/null %

" Custom Command
let g:silent_custom_command = 0
function! RunCustomCommand()
  up
  if g:silent_custom_command
    execute 'silent !' . s:customcommand
  else
    execute '!' . s:customcommand
  end
endfunction

function! SetCustomCommand()
  let s:customcommand = input('Enter Custom Command$ ')
endfunction
map <leader>r :call RunCustomCommand()<cr>
map <leader>s :call SetCustomCommand()<cr>

"Autoformat JSON
nmap =j :%!python -c 'import json, sys; print json.dumps(json.load(sys.stdin), indent=2)'<CR>
vmap <leader>y "+y
nmap <leader>yy "+y
