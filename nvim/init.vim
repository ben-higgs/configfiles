" vim: foldmethod=marker foldlevel=0
"
" .__       .__  __         .__
" |__| ____ |__|/  |_ ___  _|__| _____
" |  |/    \|  \   __\\  \/ /  |/     \
" |  |   |  \  ||  |   \   /|  |  Y Y  \
" |__|___|  /__||__| /\ \_/ |__|__|_|  /
"         \/         \/              \/          Font: Graffiti
"
" This config is set up for neovim and may cause some issues if used with regular vim
" If opening in vim, everything will be folded by default, press <space> on a fold to unfold

"
" Meta
"
" {{{

"let this = expand('%:p')    " Path to this file
"let home = expand('$HOME')  " Path to the current user home dir (potentially slow)

" Python
" Disable python2
let g:loaded_python_provider = 0

" Avoid pyenv weirdness
let g:python3_host_prog = '/usr/bin/python3'

" }}}

"
" Basic options
"
" {{{

syntax on
set autoread
set autowrite
set autowriteall
set fileformat=unix

set backspace=indent,eol,start
set bufhidden=unload
set cmdheight=1
set encoding=UTF-8
set list
set mouse=a
set mousefocus
set number
set showmatch
set joinspaces
set lazyredraw

" Line length
set textwidth=0
set linebreak
set nowrap

" Indentation
"set autoindent
"set smartindent
"set cindent

" Folding
" TODO: only fold at start if file is > ~100 lines long
set foldlevelstart=4
set foldmethod=indent
set foldminlines=0
set foldnestmax=4
"set nofoldenable  " Dont fold on open, toggle with: zi

" Scrolling
set scrolloff=5

" Tab settings
set expandtab
set shiftwidth=4
set tabstop=4
"set smarttab
"set softtabstop=0

" Sync the yank register with system clipboard
set clipboard+=unnamedplus

" Open new split panes to right and bottom, more natural than the default
set splitbelow
set splitright

" Attempting to stop scrolling when windows change size
set wildmode=full 

set tags=.tags,tags

" Stop auto resizing buffers when opening a new one (horizontal only)
"set noequalalways
"set eadirection=hor

" Fix python indentation behaviour (:h ft-python-indent)
let g:pyindent_open_paren = 'shiftwidth()'
let g:pyindent_continue = 'shiftwidth()'

" }}}

"
" Appearance
"
" {{{

set t_Co=256
set termguicolors
set background=dark

" In order for this to work you must have the colorscheme installed at ~/.config/nvim/colors/kuroi.vim
" Download from: https://github.com/aonemd/kuroi.vim
colorscheme kuroi

" Default to a built-in colorscheme and customise a bit
"colorscheme desert
"hi MatchParen ctermfg=208 ctermbg=0
"hi LineNr ctermfg=grey
"hi VertSplit ctermfg=black
"hi Pmenu ctermbg=6 ctermfg=11

set fillchars+=vert:\ 

set guifont=font-sauce-code-pro-nerd-font

" }}}

"
" Keymapping
"
" {{{

let mapleader=","

" Reduce keypresses from 2 to 1 to enter command mode
noremap ; :

" Quick save & exit
nnoremap <leader>w :wa<cr>

" Neotree
nnoremap <TAB> :Neotree toggle<CR>

" Other util windows
nnoremap <C-t> :Tagbar fj<CR>
"nnoremap <C-n> :Nnn  " doesnt work & may clash with vim keys

" Use space to toggle folds
nnoremap <space> za
vnoremap <space> zf

" TODO: Join lines without inseting a space
"nnoremap J :j<CR>

" Easier moving code blocks
vnoremap < <gv
vnoremap > >gv

" Quick way to remove search highlighs
nnoremap <esc><esc> :nohlsearch<return><esc>

" Terminal mappings
tnoremap <Esc> <C-\><C-n>
autocmd TermOpen * set nonumber
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" Navigate windows from any mode using alt-hjkl
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Navigate windows from any mode using opt-hjkl (macos)
"tnoremap ˙ <C-\><C-N><C-w>h
"tnoremap ∆ <C-\><C-N><C-w>j
"tnoremap ˚ <C-\><C-N><C-w>k
"tnoremap ¬ <C-\><C-N><C-w>l
"inoremap ˙ <C-\><C-N><C-w>h
"inoremap ∆ <C-\><C-N><C-w>j
"inoremap ˚ <C-\><C-N><C-w>k
"inoremap ¬ <C-\><C-N><C-w>l
"nnoremap ˙ <C-w>h
"nnoremap ∆ <C-w>j
"nnoremap ˚ <C-w>k
"nnoremap ¬ <C-w>l

" Move a line of text using ctrl+jk
" NOTE: there is a plugin interfering with this atm
nmap <C-j> mz:m+<cr>`z
nmap <C-k> mz:m-2<cr>`z
vmap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Add newlines without leaving normal mode
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" Make scrolling more sensitive
"map <ScrollWheelUp> <C-Y>
"map <ScrollWheelDown> <C-E>

"
" Function keys
"

" Use fzf as a file picker on open buffers
nnoremap <F1> :Buffers<CR>
" List open buffers and start command to select one
"nnoremap <F1> :buffers<CR>:buffer<space>
" Toggle the line numbers between normal and relative
nnoremap <F2> :set relativenumber!<CR>
" Toggle scrolling bind of all open buffers together
nnoremap <F3> :windo set scrollbind!<CR>
" Create a new vertical split and open a terminal in it
nnoremap <F4> :vsplit<CR>:term<CR>a
" Execute the current file
nnoremap <F5> :!"%:p"<Enter>

" }}}

"
" Autocmds
"
" {{{

" --- autocmds ---

augroup vimrc
    " remove all autocmds (prevent autocmds from being sourced multiple times)
    autocmd!

    " Auto reload this file when writing changes
    autocmd! BufWritePost % source %

    " Open help windows vertically
    autocmd FileType help wincmd L

    autocmd FileType markdown set wrap
    autocmd FileType text set wrap

    " Fix autoindent weirdness
    "autocmd FileType python setlocal indentkeys-=<:>
    "autocmd FileType python setlocal indentkeys-=:
    "autocmd FileType yaml setlocal indentkeys-=#

    " Update file changes on focus
    autocmd FocusGained * checktime

    " Format files pre-write
    autocmd BufWritePre *.py :Black
    autocmd BufWritePre *.tf call terraform#fmt()
    autocmd BufWritePre *.tfvars call terraform#fmt()
    "autocmd BufWritePre *.hcl call terraform#fmt()

    " Restore-cursor to last position on open file
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

    " --- Session ---
    " Save session on quitting Vim
    "autocmd VimLeave * mksession!
    " Restore session on starting Vim
    "autocmd VimEnter * call MySessionRestoreFunction()
augroup END

" }}}

"
" Plugins
"
" {{{

" https://github.com/junegunn/vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" - Neovim

" https://github.com/nvim-treesitter/nvim-treesitter
Plug 'nvim-treesitter/nvim-treesitter' , {'do': ':TSUpdate'}

" TODO
" https://github.com/ray-x/navigator.lua
"Plug 'neovim/nvim-lspconfig'
"Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }
"Plug 'ray-x/navigator.lua'

" - Visual

" Dependencies for a few different plugins
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'ryanoasis/vim-devicons'

" Neotree dependencies
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 's1n7ax/nvim-window-picker'
" https://github.com/nvim-neo-tree/neo-tree.nvim
Plug 'nvim-neo-tree/neo-tree.nvim'

" https://github.com/nvim-lualine/lualine.nvim
Plug 'nvim-lualine/lualine.nvim'

" https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'

" https://github.com/preservim/tagbar - ctags quickview
Plug 'preservim/tagbar'

" https://github.com/mcchrish/nnn.vim  - FilePicker
Plug 'mcchrish/nnn.vim'

" - Tools
" CoC
" https://github.com/neoclide/coc.nvim
" https://github.com/fannheyward/coc-pyright
" https://github.com/neoclide/coc-snippets
" To update extensions: :CocUpdate
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" https://github.com/windwp/nvim-autopairs
Plug 'windwp/nvim-autopairs'

" Vim surround
" https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'
" https://github.com/blackCauldron7/surround.nvim
"Plug 'blackcauldron7/surround.nvim'

" https://github.com/jremmen/vim-ripgrep
Plug 'jremmen/vim-ripgrep'

" https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


" - Python
Plug 'psf/black'

" - Syntax
Plug 'hashivim/vim-terraform'          " https://github.com/hashivim/vim-terraform
Plug 'cespare/vim-toml'                " https://github.com/cespare/vim-toml
"Plug 'jparise/vim-graphql'             " https://github.com/jparise/vim-graphql

call plug#end()

" }}}

"
" Plugins Config
"
" {{{

lua << EOF

-- --- Treesitter ---
require 'nvim-treesitter.configs'.setup {
    -- TODO: add terraform (when supported)
    ensure_installed = {
        "bash",
        "dockerfile",
        "json",
        "lua",
        "python",
        "vim",
        "yaml",
    },
    highlight = {
        enable = true,
    }
--    indent = {
--        enable = true,
--    },
}


-- --- Navigator ---
--lua require'navigator'.setup()

require 'window-picker'.setup()

-- --- Neotree ---
require 'neo-tree'.setup({
    close_if_last_window = true,
    close_floats_on_escape_key = true,
    enable_diagnostics = false,
    -- FIXME: Doesnt do anything :(
    --container = {
    --    width = "fit_content",
    --    max_width = "10%",
    --},
    window = {
        mappings = {
            ["o"] = "open_with_window_picker",
        }
    },
    filesystem = {
        filtered_items = {
            visible = false,
            always_show = {
                '.env',
                '.env-sqlite',
                '.env-psql',
                '.flake8',
                '.github',
            },
            never_show = {
                '.pyc',
                '.pytest_cache',
                '.tags',
                '.venv',
                '.vscode',
                '__pycache__',
                'node_modules',
            },
        }
    },
    -- TODO: ignore tagbar when selecting window to open file into
    --event_handlers = {
    --    {
    --        event = "file_open_requested",
    --        handler = function(arg)
    --          exclude = { '[No Name]', '__Tagbar__', 'nofile', 'terminal' }
    --        end,
    --    }
    --}
})

require('lualine').setup({
    options = {
        theme = 'OceanicNext'
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    }
})

EOF

" --- nnn ---
" Floating window (neovim latest and vim with patch 8.2.191)
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }


" --- Coc ---
" CocInstall coc-pyright
" CocInstall coc-snippets
" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')

" - Coc Snippets - https://github.com/neoclide/coc-snippets
" Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" --- nvim-autopairs ---
lua << EOF
require("nvim-autopairs").setup {}
EOF


" --- GitGutter ---
highlight GitGutterAdd    ctermfg=2 ctermbg=0
highlight GitGutterChange ctermfg=3 ctermbg=0
highlight GitGutterDelete ctermfg=1 ctermbg=0


" --- Black ---
let g:black_skip_string_normalization = 1
let g:black_linelength = 88

" --- DevIcons ---
"let g:webdevicons_enable = 1
"let g:webdevicons_enable_nerdtree = 1
"let g:webdevicons_conceal_nerdtree_brackets = 1


" --- TagBar ---
let g:tagbar_map_togglefold = "za"
let g:tagbar_map_jump = ["<ENTER>", "o"]

let g:tagbar_sort = 0
"let g:tagbar_compact = 1
"let g:tagbar_singleclick = 1
"let g:tagbar_show_tag_linenumbers = 2
"let g:tagbar_show_data_type = 1
"let g:tagbar_updatetime=500  " this isnt right
"let g:tagbar_wrap = 1

nnoremap t] :call tagbar#jumpToNearbyTag(1)
nnoremap t[ :call tagbar#jumpToNearbyTag(-1)


"" }}}

