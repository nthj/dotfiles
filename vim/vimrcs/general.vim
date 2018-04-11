"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Outline:
" 		> Init
"     > Colors and Fonts
"     > Mappings
" 		> Navigation
"			> Searching
"     > User experience
"     > Tabs vs. spaces
"			> Cursor positioning
"     > Backups
" 		> Helpers
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" > Init
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" VIM history to keep
set history=1500

" Setup map leader for mappings later on
" Use by pressing <leader> (","), then the next key
let mapleader = ","
let g:mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" > Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

" Colorscheme
colorscheme iceberg

set background=dark

" Set utf8 as standard encoding
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" > Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Quick reload vimrc
map <leader>r :source ~/.vimrc<cr>:noh<cr>

" "," then "8" forces 80-character wide window
map <leader>8 :vertical resize 80<cr>

" Map <Space> to (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight via <leader><cr> (",", "Enter")
map <silent> <leader><cr> :noh<cr>

" Fast saving
nmap <leader>w :w!<cr>

" Delete trailing whitespace on save:
autocmd BufWrite *.erb :call DeleteTrailingWhitespace()
autocmd BufWrite *.rb :call DeleteTrailingWhitespace()
autocmd BufWrite *.yml :call DeleteTrailingWhitespace()

" Change background on save:
autocmd BufWritePost * execute 'silent ! osascript /Users/nj/Projects/change-el-capitan-wallpaper-on-vim-file-save/ChangeBackgroundOnSave.app'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" > Navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Navigate between windows
map <C-j> <C-W>j
map <C-k> <C-K>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer with "," then "bd"
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers with "," then "ba"
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Manage tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>
map <leader>t<leader> :tabnext<cr>

" Toggle last accessed tabs with "," then "tl"
" let g:lasttab = 1
" nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
" au TabLeave* let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:ph")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Switching buffers behavior
try
	set switchbuf=useopen,usetab,newtab
	set stal=2
catch
endtry

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" > Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Press gv to Ag after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ag and put the cursor in the right position
map <leader>g :Ag

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with Ag, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" > User experience
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Minimize "Hit Enter to Continue"
set shortmess=a

" Backspace tweaks
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" /Tacos only finds Tacos, /tacos finds Tacos or tacos
set smartcase

" Highlight search results
set hlsearch

" Incremental searching ("autocomplete")
set incsearch

" Command bar height
set cmdheight=2

" Turn on the WiLd menu
set wildmenu

" Show the current position along the bottom
set ruler

" Highlight brackets matching cursor position
set showmatch
set mat=1 " Blink for 100ms

" Disable sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add left margin
set foldcolumn=1

" Always show status
set laststatus=2

" Status line format
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" > Tabs vs. spaces
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces, not tabs
set expandtab
set smarttab

" 1 tab is 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 80 characters
set lbr
set tw=80

" Except for git commits
au FileType gitcommit set tw=72 " messages max 72 wide

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" > Backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use git instead
set nobackup
set nowb

" Keep swapfiles, but outside the current directory
set swapfile
set dir=~/.tmp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" > Helpers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

func! DeleteTrailingWhitespace()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
