behave mswin
set diffexpr=MyDiff()

function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
       if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
                if &sh =~ '\<cmd'
                        let cmd = '""' . $VIMRUNTIME . '\diff"'
                        let eq = '"'
                else
                        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
                endif
        else
                let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"plug config
if filereadable(expand("$VIM/vimrc.bundles"))
        source $VIM/vimrc.bundles
endif

" Startup {{{
filetype indent plugin on


" vim �ļ��۵���ʽΪ marker
augroup ft_vim
        au!

        au FileType vim setlocal foldmethod=marker
augroup END
" }}}

" General {{{

set noundofile
set nocompatible
set nobackup
set noswapfile
set history=1024
set autochdir
set whichwrap=b,s,<,>,[,]
set nobomb
set backspace=indent,eol,start whichwrap+=<,>,[,]
" Vim ��Ĭ�ϼĴ�����ϵͳ�����干��
set clipboard+=unnamed
" ���� alt ����ӳ�䵽�˵���
set winaltkeys=no
autocmd GUIEnter * simalt ~x
" }}}
"pairs{{{

"inoremap ( ()<LEFT>
"inoremap [ []<LEFT>
"inoremap { {}<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
"inoremap < <><LEFT>

"function! RemovePairs()
    "let s:line = getline(".")
    "let s:previous_char = s:line[col(".")-1]

    "if index(["(","[","{"],s:previous_char) != -1
        "let l:original_pos = getpos(".")
        "execute "normal %"
        "let l:new_pos = getpos(".")
        "" only right (
        "if l:original_pos == l:new_pos
            "execute "normal! a\<BS>"
            "return
        "end

        "let l:line2 = getline(".")
        "if len(l:line2) == col(".")
            "execute "normal! v%xa"
        "else
            "execute "normal! v%xi"
        "end
    "else
        "execute "normal! a\<BS>"
    "end
"endfunction

"function! RemoveNextDoubleChar(char)
    "let l:line = getline(".")
    "let l:next_char = l:line[col(".")]

    "if a:char == l:next_char
        "execute "normal! l"
    "else
        "execute "normal! i" . a:char . ""
    "end
"endfunction

"inoremap <BS> <ESC>:call RemovePairs()<CR>a
"inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
"inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
"inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a
"inoremap > <ESC>:call RemoveNextDoubleChar('>')<CR>a

"}}}

" Lang & Encoding {{{
set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936
set encoding=utf-8
set langmenu=en
let $LANG = 'en_US.UTF-8'
"language messages zh_CN.UTF-8
" }}}

" GUI {{{
set background=dark
set t_Co=256
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set cursorline
set hlsearch
set number
" ���ڴ�С
set lines=35 columns=140
" �ָ�����Ĵ���λ�ڵ�ǰ�����±�/�ұ�
set splitbelow
set splitright
"����ʾ����/�˵���
set guioptions-=T
"set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions-=b
" ʹ������ tab ��ʽ������ gui
set guioptions-=e
set nolist

set laststatus=2

set guifont=DejaVu_Sans_Mono_for_Powerline:h11:cANSI:qDRAFT
" }}}

" Format {{{
set autoindent
set smartindent
set tabstop=4
set expandtab
set softtabstop=4
set foldmethod=indent
syntax on
" }}}
"define function{{{
func FormartSrc()
    if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    else
        exec "normal gg=G"
        return
    endif
 exec "e! %"
endfunc

"}}}
" Keymap {{{
let mapleader=","
let g:mapleader = ','

nmap <leader>s :source $VIM/_vimrc<cr>
nmap <leader>e :e $VIM/_vimrc<cr>

map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>th :tabp<cr>
map <leader>tl :tabn<cr>

" �ƶ��ָ��
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" ����ģʽ�� alt+j,k,h,l �����ָ�ڴ�С
nnoremap <M-j> :resize +5<cr>
nnoremap <M-k> :resize -5<cr>
nnoremap <M-h> :vertical resize -5<cr>
nnoremap <M-l> :vertical resize +5<cr>

" ����ģʽ�ƶ���� alt + �����
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <left>
inoremap <M-l> <Right>

" IDE like delete
inoremap <C-BS> <Esc>bdei

nnoremap vv ^vg_
" ת����ǰ��Ϊ��д
inoremap <C-u> <esc>mzgUiw`za
" ����ģʽ�µ�����β
cnoremap <C-a> <home>
cnoremap <C-e> <end>

nnoremap <F2> :setlocal number!<cr>
nnoremap <leader>w :set wrap!<cr>

imap <C-v> "+gP
vmap <C-c> "+y
vnoremap <BS> d
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y
imap <C-V>      "+gP
map <S-Insert>      "+gP
cmap <C-V>      <C-R>+
cmap <S-Insert>     <C-R>+

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

" �򿪵�ǰĿ¼ windows
map <leader>ex :!start explorer %:p:h<CR>

" �򿪵�ǰĿ¼CMD
map <leader>cmd :!start<cr>
" ��ӡ��ǰʱ��
map <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>

" ���Ƶ�ǰ�ļ�/·����������
nmap ,fn :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
nmap ,fp :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

" �����л�Buffer��ݼ�"
nnoremap <C-left> :bn<CR>
nnoremap <C-right> :bp<CR>
"��ʽ������
map <F6> :call FormartSrc()<CR><CR>

" }}}
