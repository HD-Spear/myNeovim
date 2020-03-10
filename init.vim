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
set wrap
set cursorline
set ts=4
set softtabstop=4
set shiftwidth=4
set expandtab
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
		:res -15
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
	nmap <buffer> u <plug>UndotreeNextState
	nmap <buffer> e <plug>UndotreePreviousState
	nmap <buffer> U 5<plug>UndotreeNextState
	nmap <buffer> E 5<plug>UndotreePreviousState
endfunc

" ===
" === coc
" ===
" fix the most annoying bug that coc has
"silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
let g:coc_global_extensions = ['coc-python', 'coc-vimlsp', 'coc-html', 'coc-json', 'coc-css', 'coc-tsserver', 'coc-yank', 'coc-lists', 'coc-gitignore', 'coc-vimlsp', 'coc-tailwindcss', 'coc-stylelint', 'coc-tslint', 'coc-lists', 'coc-git', 'coc-explorer', 'coc-pyright', 'coc-sourcekit', 'coc-translator', 'coc-flutter']
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]	=~ '\s'
endfunction
inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()

" Open up coc-commands
nnoremap <c-c> :CocCommand<CR>
" Text Objects
xmap kf <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap kf <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" Useful commands
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap tt :CocCommand explorer<CR>
" coc-translator
nmap ts <Plug>(coc-translator-p)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
