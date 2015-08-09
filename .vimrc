set helplang=cn
set encoding=utf-8
set nocompatible " Turn off compatible mode of vi
set selectmode=mouse
set ws
set wrap
set nu
set ruler " Turn on the scaleplate of status bar
set showcmd
set wildmenu
set hls
set noshowmatch
set ic
set wc=<TAB>
set ts=4 "set TAB to 4 spaces in vim
set nosol
set gfn=courier
set cscopequickfix=s-,c-,d-,i-,t-,e-
set cursorline " Highlight current line
set vb
set ai
set et
set shiftwidth=4
set softtabstop=4 " set backspace button to delete 4 spaces
set nobackup
set nowrapscan
set incsearch
set hlsearch
set smartindent
set laststatus=2
set cin
set expandtab
set tags=tags
set guifont=Monaco\ 11
set guifontwide=WenQuanYi\ Micro\ Hei\ Mono\ 11
set mouse=v

au GUIEnter * simalt ~x

filetype plugin indent on
set completeopt=longest,menu


" set foldenable
if exists('+foldmethod')
    set foldmethod=marker " set fold method to marker
    "set foldmethod=syntax " set fold method to marker
endif
" set foldcolumn=0
if exists('+foldlevel')
    set foldlevel=100 " Do not automatically fold code
endif
" set foldclose=all
" nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>


syntax enable
syntax on

colorscheme desert

let Tlist_Show_One_File=1
let Tlist_Exit_Only_Window=1
let Tlist_Use_Right_Window=1
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>
" let Tlist_File_Fold_Auto_Close=1
let Tlist_Auto_Open=0
let Tlist_Auto_Update=1
" let Tlist_Enable_Fold_Column=0
let Tlist_Process_File_Always=1
let Tlist_Display_Prototype=0
let Tlist_Compact_Format=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplMapWindowNavVim=1
let g:miniBufExplMapWindowNavArrows=1 " Change the active sub-window by <C-arrows>
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"

"doxygen comment generator
map fg : Dox<CR>
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:DoxygenToolkit_briefTag_pre="@Brief:   "
let g:DoxygenToolkit_paramTag_pre="@Param:  "
let g:DoxygenToolkit_returnTag="@Returns:  "
let g:DoxygenToolkit_authorName="HanZhang Qin"
let g:DoxygenToolkit_blockHeader="*************************************************************"
let g:DoxygenToolkit_blockFooter="*************************************************************"

" for cscope's hot-key
nmap <C-[>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-[>g :cs find g <C-R>=expand("<cword>")<CR><CR> 
nmap <C-[>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-[>t :cs find t <C-R>=expand("<cword>")<CR><CR> 
nmap <C-[>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-[>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-[>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-[>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" QuickFix, Hot-Key <F6> means Change to the Next result
nmap <F6> :cn<cr>
" QuickFix, Hot-Key <F7> means Change to the Previous result
nmap <F7> :cp<cr>
nnoremap <silent> <F3> :Grep<CR>
nnoremap <silent> <F12> :A<CR>
"NERD_commenter setting the commenter
"map <F9> <leader>cc
map <F10> <leader>cu
map <F9> :Matrix<CR>
map <F12> :call Cs_add()<CR>
map <F11> :call Ctags_add()<CR>
function Cs_add()
    if(executable('cscope'))
        if filereadable("cscope.out")
            silent! execute "!rm -rf cscope.*"
        endif
        silent! execute "!cscope -Rbk"
        echo "Generate cscope.out!"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
            echo "Add cscope!"
        else
            echohl WarningMsg | echo "Fail to add cscope.out!" | echohl None
        endif
    endif
endf
function Ctags_add()
    if(executable('ctags'))
        if filereadable("tags")
            silent! execute "!rm -rf tags"
        endif
        silent! execute "!ctags -R"
        echo "Generate tags!"
        if filereadable("tags")
            execute "set tags=tags"
            echo "Add tags!"
        else
            echohl WarningMsg | echo "Fail to add tags!" | echohl None
        endif
    endif
endf

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.c,*.h,*.sh,*.java exec ":call SetTitle()"
"定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
       call setline(1,"\#########################################################################")
       call append(line("."), "\# File Name: ".expand("%"))
       call append(line(".")+1, "\# Function: ")
       call append(line(".")+2, "\# Author: qinhanzhang")
       call append(line(".")+3, "\# mail: qinhanzhang@hotmail.com")
       call append(line(".")+4, "\# Created Time: ".strftime("%c"))
       call append(line(".")+5, "\#########################################################################")
       call append(line(".")+6, "\#!/bin/bash")
       call append(line(".")+7, "")
    else
       call setline(1, "\/*************************************************************************")
       call append(line("."), "  > File Name: ".expand("%"))
       call append(line(".")+1, "  > Function: ")
       call append(line(".")+2, "  > Author: qinhanzhang")
       call append(line(".")+3, "  > Mail: qinhanzhang@hotmail.com ")
       call append(line(".")+4, "  > Created Time: ".strftime("%c"))
       call append(line(".")+5, "  > Version: v1.0")
       call append(line(".")+6, " ************************************************************************/")
       call append(line(".")+7, "")
   endif
   if &filetype == 'py'
       call setline(1,"\#########################################################################")
       call append(line("."), "\# File Name: ".expand("%"))
       call append(line(".")+1, "\# Function: ")
       call append(line(".")+2, "\# Author: qinhanzhang")
       call append(line(".")+3, "\# mail: qinhanzhang@hotmail.com")
       call append(line(".")+4, "\# Created Time: ".strftime("%c"))
       call append(line(".")+5, "\#########################################################################")
       call append(line(".")+6, "\#!/usr/bin/python")
       call append(line(".")+7, "")
   endif
   if expand("%:e") == 'cpp'
       call append(line(".")+8, "#include <iostream>")
       call append(line(".")+9, "using namespace std;")
       call append(line(".")+10, "    ")
       call append(line(".")+11, "int main(int argc, char *argv[])")
       call append(line(".")+12, "{")
       call append(line(".")+13, "    return 0;")
       call append(line(".")+14, "}")
   endif
   if &filetype == 'c'
       call append(line(".")+8, "#include <stdio.h>")
       call append(line(".")+9, "")
       call append(line(".")+10, "int main( void )")
       call append(line(".")+11,"{")
       call append(line(".")+12,"    return 0;")
       call append(line(".")+13,"}")
   endif
   if expand("%:e") == 'h'
       let Macro = toupper(expand("%:t:r"))."_".toupper(expand("%:e"))
       call append(line(".")+8, "#ifndef ".Macro) 
       call append(line(".")+9, "   #define ".Macro)
       call append(line(".")+10,"   //  Add your content start at next line")
       call append(line(".")+11,"")
       call append(line(".")+12,"#endif")
    endif
   "   if &filetype == 'java'
   "       call append(line(".")+6,"public class ".expand("%"))
   "       call append(line(".")+7,"")
   "   endif
   "新建文件后，自动定位到文件末尾
   autocmd BufNewFile * normal G
endfunc

 

