"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  __  ____   __  _   _ _____ _____     _____ __  __  "
" |  \/  \ \ / / | \ | | ____/ _ \ \   / /_ _|  \/  | "
" | |\/| |\ V /  |  \| |  _|| | | \ \ / / | || |\/| | "
" | |  | | | |   | |\  | |__| |_| |\ V /  | || |  | | "
" |_|  |_| |_|   |_| \_|_____\___/  \_/  |___|_|  |_| "
"                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""


" ===
" === Basic
" ===

syntax on
set number
set relativenumber
set wrap
set cursorline
set ts=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set autoindent
set mouse-=a
set autoindent
set list
set listchars=tab:\|\ ,trail:▫
set showcmd
set wildmenu
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
"silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ===
" === Keys
" ===

" Command Mode Cursor Movement
cnoremap <C-k> <Left>
cnoremap <C-l> <Right>

" Set Leader
let mapleader=" "

" Search
noremap <LEADER><CR> :nohlsearch<CR>
" Adjacent duplicate words
noremap <LEADER>dw /\(\<\w\+\>\)\_s*\1
" Space to Tab
nnoremap <LEADER>tt :%s/    /\t/g
vnoremap <LEADER>tt :s/    /\t/g
" Folding
noremap <silent> <LEADER>o za

noremap j h
noremap h p
noremap H P
noremap p o
noremap P O
noremap o l
noremap l i
noremap L I
noremap i k
noremap k j

noremap I 5k
noremap K 5j
noremap J 7h
noremap O 7l

noremap z zz
noremap = nz

map <C-o> $
map <C-j> 0

map s :w<CR>
map q :q<CR>
map fq :q!<CR>
map ; :

map <LEADER>rc :set splitright<CR>:vsplit<CR>:e ~/.config/nvim/init.vim<CR>
map R :source ~/.config/nvim/init.vim<CR>

noremap <LEADER>w <C-w>w
noremap <LEADER>i <C-w>k
noremap <LEADER>k <C-w>j
noremap <LEADER>j <C-w>h
noremap <LEADER>o <C-w>l

noremap fi :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap fk :set splitbelow<CR>:split<CR>
noremap fj :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap fo :set splitright<CR>:vsplit<CR>

noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" ===
" === <F5> to compiler and run
" ===
" Compile function
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!gcc % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -5
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		CocCommand flutter.run
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run %
	endif
endfunc


" ===
" === Vim-Plug
" ===
call plug#begin('~/.config/nvim/plugged')

" Beutiful bar
Plug 'vim-airline/vim-airline'

" Colors themes
Plug 'arzg/vim-colors-xcode'
"Plug 'connorholyday/vim-snazzy'

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Snippets
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

" Undo Tree
Plug 'mbbill/undotree'

" Other Plug
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'


call plug#end()

" ===
" === Nerd-Commenter
" ===
" Space comments automatically (To 0 is no Space)
let g:NERDSpaceDelims=0

" ===
" === Colors themes
" ===
colorscheme xcodedark
let g:SnazzyTransparent = 1
"colorscheme snazzy

" ===
" === Undotree
" ===
noremap tt :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
	nmap <buffer> i <plug>UndotreeNextState
	nmap <buffer> k <plug>UndotreePreviousState
	nmap <buffer> I 5<plug>UndotreeNextState
	nmap <buffer> K 5<plug>UndotreePreviousState
endfunc

