"  < 判断操作系统是否是 Windows 还是 Linux >  {{{
" -----------------------------------------------------------------------------
let g:isWindows = 0
let g:isLinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
	let g:isWindows = 1
else
	let g:isLinux = 1
endif
"}}}
" < Linux 专用设置 >  {{{
" -----------------------------------------------------------------------------
"C，C++ 按分号e编译运行
if(isLinux)
	noremap <Leader>e :call CompileRunGcc()<CR>
	func! CompileRunGcc()
		exec "w"
		if &filetype == 'c'
			exec "!gcc -Wall -g  % -o %:r && ./%:r "  
		elseif &filetype == 'cpp'
			exec "!g++ -Wall -std=c++17  -g  % -o %:r && ./%:r "  
		elseif &filetype == 'sh'
			"在当前bash执行此脚本
			exec "!. %"	
		elseif &filetype == 'python'
			exec "!python %"
		endif
	endfunc
endif
"}}}
" < Windows 专用设置 > {{{
" -----------------------------------------------------------------------------
if(isWindows)
	"弄一弄windows下tag路径
	set tags+=D:/MinGW/mingw64/lib/gcc/x86_64-w64-mingw32/8.1.0/include/tags
	set tags+=D:/MinGW/mingw64/x86_64-w64-mingw32/include/tags
	" windows里刷LeetCode题
	function! LeetCode()
		" 这个c,cpp文件是新建的话，那就要做以下步骤 清空。
		if file_readable(expand("%"))==0
			if file_readable("initial_codes.cpp")&&file_readable("leetcode_script.vim")
				silent source leetcode_script.vim
			else
				execute "normal ggdG"
			endif
		endif
	endfunction
	autocmd FileType c,cpp  call LeetCode()
	"shell 采用 cmd
	set shell=cmd
	"C，C++ 按分号e编译运行 (生成exe)
	noremap <Leader>e :call CompileRunGcc()<CR>
	func! CompileRunGcc() "使用 cmd 作为shell
		exec "w"
		if &filetype == 'c'
			exec "! gcc -Wall -g % -o %:r.exe  && echo ok && %:r.exe "
		elseif &filetype == 'cpp'
			exec "! g++ -Wall -std=c++17 -g % -o %:r.exe && echo ok. && %:r.exe "
		elseif &filetype == 'sh'
			exec "! bash %"
			"在当前bash执行此脚本
		elseif &filetype == 'python'
			exec "!python %"
		elseif &filetype == 'dosbatch'
			exec "! %"
		endif
	endfunc
	"下面是gvim配置的开头默认代码
	" Vim with all enhancements
	source $VIMRUNTIME/vimrc_example.vim
	" Use the internal diff if available.
	" Otherwise use the special 'diffexpr' for Windows.
	if &diffopt !~# 'internal'
		set diffexpr=MyDiff()
	endif
	function MyDiff()
		let opt = '-a --binary '
		if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
		if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
		let arg1 = v:fname_in
		if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
		let arg1 = substitute(arg1, '!', '\!', 'g')
		let arg2 = v:fname_new
		if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
		let arg2 = substitute(arg2, '!', '\!', 'g')
		let arg3 = v:fname_out
		if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
		let arg3 = substitute(arg3, '!', '\!', 'g')
		if $VIMRUNTIME =~ ' '
			if &sh =~ '\<cmd'
				if empty(&shellxquote)
					let l:shxq_sav = ''
					set shellxquote&
				endif
				let cmd = '"' . $VIMRUNTIME . '\diff"'
			else
				let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
			endif
		else
			let cmd = $VIMRUNTIME . '\diff'
		endif
		let cmd = substitute(cmd, '!', '\!', 'g')
		silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
		if exists('l:shxq_sav')
			let &shellxquote=l:shxq_sav
		endif
	endfunction
endif
"}}}
"  < 判断是终端还是 Gvim > {{{
" -----------------------------------------------------------------------------
let g:isGUI = 0
if has("gui_running")
	let g:isGUI = 1
endif
"}}}
" < Gvim 专用设置 > {{{
" -----------------------------------------------------------------------------
if(isGUI)
	"弄一弄Gvim菜单栏的中文乱码
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim

	"启用GDB包,然后就能[ :Termdebug + 可执行程序名] .termdebug 是从 Vim 8.1 开始内置的调试插件，仅支持 GDB。
	packadd termdebug 
	nnoremap <F11> :call GDB()<CR>
	func! GDB()
		exec "Termdebug %:r"
	endfunc
	"分号sh 进入shell
	noremap <Leader>sh :call IntoShell()<CR>
	func! IntoShell()
		exec "w"
		exec "terminal"
	endfunc
	"Gvim行距 linespace
	set linespace=4
	colorscheme motus "设置配色方案，在~/.vim/colors/目录下提前放置molokai.vim.至于gvim我喜欢motus, ubuntu的vim我喜欢default,molokai，vsvim我喜欢web13234.vssettings
	autocmd BufReadPost *.txt  execute ": colorscheme Autumn2"|setlocal linespace=10|setlocal expandtab
	"set guioptions-=T "去掉工具栏
	"set guioptions-=m "去掉菜单栏
	set guifont=Cr.DejaVuSansMono.YaHei:h12
endif
"}}}

"-------------------以下与gvim和vim无关----------------------------------------

"目前我的vim个人配置文件
"一般的映射，都写nore防止递归, 函数则写感叹号function!

"映射 和 设置
" < Mappings映射(map) > {{{
" -----------------------------------------------------------------------------
"jj映射Esc
inoremap jj <Esc>	
"热键Leader定为'分号'。
let mapleader = ";"
"设置本地热键 为 "-"
let maplocalleader = "-"
"设置;a快捷键选中所有内容
nnoremap <Leader>a ggVG
" "B"uffer "D"elete 删除当前缓冲区（而不是仅仅关闭窗口）
noremap <leader>bd <esc>:bd<cr>
"关闭除此缓冲区以外的所有缓冲区
noremap <leader>bo :execute "%bd\|e#"<CR>
" "C"hange "V"imrc"的首字母,竖直分屏，打开.vimrc进行编辑,记
"noremap <leader>cv <esc>:vsplit $MYVIMRC<cr>
noremap <leader>cv <esc>:tabnew $MYVIMRC<cr>
"分号obj 对源码进行编译，生成目标文件，并且objdump -dS 文件
noremap <Leader>obj :call ObjDump()<CR>
func! ObjDump()
	exec "w"
	exec ":!g++ -g -c % && objdump -dS %:r.o"
endfunc
" 使用;p快捷键开启 paste。;;p关闭paste。默认关闭paste模式
set nopaste
noremap <Leader>p :set paste<CR>i
noremap <Leader><Leader>p :set nopaste<CR>
" 使用;q快捷键退出vim
nnoremap <Leader>q :q<CR>
" 使用;;q强制退出vim
nnoremap <Leader><Leader>q <ESC>:q!<CR>
" 窗口切换  
nnoremap <c-h> <c-w>h  
nnoremap <c-l> <c-w>l  
nnoremap <c-j> <c-w>j  
nnoremap <c-k> <c-w>k  
"空格 一次击键选中当前word,两次击键选中WORD。小心：viwc这句话里，不要有任何多余的空格
nnoremap <space> viw
vnoremap <space> vviW
" "S"ource "V"imrc"的首字母，表示重读vimrc配置文件。
nnoremap <leader>ss <esc>:source *.vim<cr>
nnoremap <leader>sv <esc>:source $MYVIMRC<cr>
"分号sh 进入shell
noremap <Leader>sh :call IntoShell()<CR>
func! IntoShell()
	exec "w"
	exec ":shell"
endfunc
"分号tag 生成 并更新tag文件 "有了ctag以后，ctrl+] 进入函数定义，ctrl+o 回退。 
noremap <Leader>tag :call Ctag()<CR>
func! Ctag()
	if &filetype == 'c'
		exec "silent :!ctags -R --c++-kinds=+p+x+d --fields=+liaS --extras=+q" 
	elseif &filetype == 'cpp'
		exec "silent :!ctags -R --c++-kinds=+p+x+d --fields=+liaS --extras=+q" 
	endif
endfunc
" 使用;w快捷键保存内容
nnoremap <Leader>w :w<CR>
inoremap <Leader>w <ESC>:w<CR>
"H设置为行首，L设置为行尾
nnoremap H ^
nnoremap L $
"两个//搜索选中文本。可 与<space><space>搭配使用。
vnoremap // y/<c-r>"<cr>
" 分割窗口后通过前缀键 "\" 和方向键 调整窗口大小
nnoremap <Leader><Up>    :resize +5<CR>
nnoremap <Leader><Down>  :resize -5<CR>
nnoremap <Leader><Right> :vertical resize +5<CR>
nnoremap <Leader><Left>  :vertical resize -5<CR>
"自动补全花括号
"inoremap { {}<ESC>i
"inoremap {<CR> {<CR>}<ESC>O

nnoremap <F3> <Esc>:tabnew<CR>    "指定 F10 键来新建标签页
" 标签页导航 按键映射。silent 命令（sil[ent][!] {command}）用于安静地执行命令，既不显示正常的消息，也不会把它加进消息历史
nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt
nnoremap <Leader>0 :tablast<CR>	"最后一个标签页
nnoremap <silent><Tab>q :tabclose<CR>	"退出标签
nnoremap <silent><Tab>n :tabnext<CR>	"下一个标签页
inoremap <silent><Tab>n <Esc>:tabnext<CR>	"下一个标签页
nnoremap <silent><Tab>p :tabprevious<CR>	"上一个标签页
nnoremap <silent><s-tab> :tabprevious<CR>	"上一个标签页
inoremap <silent><s-tab> <Esc>:tabprevious<CR>	
" }}}
" < Basic Settings基础设置(set) >  {{{
" -----------------------------------------------------------------------------
set encoding=utf-8
set nocompatible  "去掉讨厌的有关vi兼容模式，避免以前版本的一些bug和局限
set showcmd	"输入的命令显示出来，看的清楚些"
set showmatch "开启高亮显示匹配括号"
set showmode "显示当前处于哪种模式
colorscheme motus "设置配色方案，在~/.vim/colors/目录下提前放置molokai.vim.至于gvim我喜欢motus, ubuntu的vim我喜欢default,molokai，vsvim我喜欢web13234.vssettings
set laststatus=2 "显示状态栏
set number	"显示行号
set cursorline  " 突出显示当前行
set ruler	"在状态栏显示光标的当前位置(位于哪一行哪一列)
set autochdir	" 自动切换当前目录为当前编辑文件所在的目录(打开多个文件时)
filetype plugin on	" 允许载入文件类型插件
filetype indent on	"为特定文件类型载入对应缩进格式
filetype plugin indent on	"打开基于文件类型的插件和缩进
set smartindent	"开启新行时使用智能自动缩进 主要用于 C 语言一族
set hlsearch	"将搜索的关键字高亮处理
set ignorecase	"搜索忽略大小写(不对大小写敏感) 
set incsearch	" 随着键入即时搜索
set smartcase	" 有一个或以上大写字母时仍大小写敏感。如果同时打开了ignorecase，那么对于只有一个大写字母的搜索词，将大小写敏感；其他情况都是大小写不敏感
set confirm     " 在处理未保存或只读文件的时候，弹出确认
set t_Co=256	"设置256色
"去掉输入错误的提示声音和闪屏
set noerrorbells visualbell t_vb=	"其中 t_vb的清空对GUI的vim无效，因为会默认重置。所以开启gvim以后可能仍然闪屏，可以 :set t_vb=
"（’t_vb‘选项，默认是用来让屏幕闪起来的）Starting the GUI (which occurs after vimrc is read) resets ‘t_vb’ to its default value开启GUI是在读入vimrc以后，会把 t_vb设置成闪屏的。
autocmd GUIEnter * set visualbell t_vb=
set wrap	" 自动换行
set history=1000	" 历史记录数
set fileencodings=utf-8,gbk,cp936,gb18030,big5,euc-jp,euc-kr,latin1 "中文编码支持(gbk/cp936/gb18030)---Vim 启动时逐一按顺序使用第一个匹配到的编码方式打开文件
"set encoding=gbk	" Vim 内部 buffer (缓冲区)、菜单文本等使用的编码方式 :告诉Vim 你所用的字符的编码
"禁止生成临时文件
set nobackup	"禁止自动生成 备份文件
set noswapfile	"禁止自动生成 swap文件
set noundofile	"禁止 gvim 在自动生成 undo 文件 *.un~
set tabstop=4	"按下Tab键时,键入的tab字符显示宽度。 统一缩进为4
set shiftwidth=4	"每次>>缩进偏移4个。(自动缩进时，变化的宽度4为单位)
set softtabstop=4 "自动将键入的Tab转化为空格(宽度未达到tabstop)。或者正常输入tab(宽度达到tabstop)。
" 设置softtabstop有一个好处是可以用Backspace键来一次删除4个空格.
" softtabstop的值为负数,会使用shiftwidth的值,两者保持一致,方便统一缩进.

set noexpandtab		" 不要将制表符tab展开成空格。expandtab 选项把插入的 tab 字符替换成特定数目的空格。具体空格数目跟 tabstop 选项值有关
"自动补全（字典方式）----使用ctrl+x ctrl+k 进行字典补全
set dictionary+=/usr/share/dict/english.dict
"直接CTRL+n就显示dict其中的列表
set complete-=k complete+=k
set autoread	"打开文件监视。如果在编辑过程中文件发生外部改变（比如被别的编辑器编辑了），就会发出提示。
set timeoutlen=500	"以毫秒计的,等待键码或映射的键序列完成的时间
set tags+=/usr/include/tags
" }}}
" < Status Line > {{{
" -----------------------------------------------------------------------------
"set statusline=%F         " 文件的路径
"set statusline+=\ --\      " 分隔符
"set statusline+=FileType: " 标签
"set statusline+=%y        " 文件的类型
"set statusline+=%=        " 切换到右边
"set statusline+=%l        " 当前行
"set statusline+=/         " 分隔符
"set statusline+=%L        " 总行数
" 设置状态行显示常用信息
" %F 完整文件路径名
" %m 当前缓冲被修改标记
" %r 当前缓冲只读标记
" %h 帮助缓冲标记
" %w 预览缓冲标记
" %Y 文件类型
" %b ASCII值
" %B 十六进制值
" %l 行数
" %v 列数
" %p 当前行数占总行数的的百分比
" %L 总行数
" %{...} 评估表达式的值，并用值代替
" %{"[fenc=".(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?"+":"")."]"} 显示文件编码[中间的双引号、空格都需要转义字符。]
set statusline=%F "完整的文件路径名
set statusline+=%m "当前缓冲被修改标记 
set statusline+=%r "当前缓冲只读标记
set statusline+=%h "帮助缓冲标记
set statusline+=%w "预览缓冲标记
set statusline+=%= "切换到右边
set statusline+=\ [filetype=%y] "文件的类型
set statusline+=\ %{\"[fileenc=\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"]\"}
set statusline+=\ [ff=%{&ff}] "fileformat
set statusline+=\ [asc=%03.3b] "ASCII_decimal
set statusline+=\ [asc_hex=%02.2B] "ASCII_hex
set statusline+=\ [pos=%04l,%04v][%p%%] "position
set statusline+=\ [len=%L] "lenth of lines
" }}}
" < abbreviate缩写替换 > {{{
" -----------------------------------------------------------------------------
"替换内容纠正笔误，如果想取消替换，那么iunabbrev main(即修正后的单词) 
iabbrev mian main 
iabbrev eixt exit 
iabbrev viod void 
iabbrev waht what
iabbrev tehn then
iabbrev tihs this
iabbrev cahr char
iabbrev	pirnt print
iabbrev retuen return
iabbrev retrun return
"个人常用信息
iabbrev @@ icebggg@qq.com
iabbrev @z //@hyf
iabbrev z@ //fyh@
iabbrev ccopy Copyright 2021 Yufeng Huang, all rights reserved.
"选中当前单词，两边添加双引号
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <localleader>"  viW<esc>a"<esc>hBi"<esc>E
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <localleader>' viW<esc>a'<esc>hBi'<esc>E
nnoremap <leader>> viw<esc>a><esc>hbi<<esc>lel
nnoremap <localleader>> viW<esc>a><esc>hBi<<esc>E
nnoremap <leader>] viw<esc>a]<esc>hbi[<esc>lel
nnoremap <localleader>] viW<esc>a]<esc>hBi[<esc>E
nnoremap <leader>) viw<esc>a)<esc>hbi(<esc>lel
nnoremap <localleader>) viW<esc>a)<esc>hBi(<esc>E
nnoremap <leader>} viw<esc>a}<esc>hbi{<esc>lel
nnoremap <localleader>} viW<esc>a}<esc>hBi{<esc>E
" }}}

"自动命令组
" < autocmd 命令组 global设置 > {{{
" -----------------------------------------------------------------------------
augroup global
	autocmd!
	"打开任何类型的文件时，自动缩进。(BufNewFile表示即使这个文件不存在，也创建并保存到硬盘)
	"注释不要写到自动命令后面(尤其是normal关键字后面)。 
	"autocmd BufWritePre,BufRead *.html normal! gg=G 

	"SetTitle()自动插入文件头 
	func! SetTitle()                          "定义函数 SetTitle，自动插入文件头
		"如果文件类型为 .sh 文件
		if &filetype == 'sh'
			call setline(1,          "\#########################################################################")
			call append(line("."),   "\# File Name: ".expand("%"))
			call append(line(".")+1, "\# Author: Yufeng Huang <icebggg@qq.com>")
			call append(line(".")+2, "\# Created Time: ".strftime("%c"))
			call append(line(".")+3, "\#########################################################################")
			call append(line(".")+4, "\#! /bin/bash")
			call append(line(".")+5, "")

		elseif &filetype == 'c'
			call setline(1,"#include<stdio.h>")
			call append(line("."), "#include<stdlib.h>")
			call append(line(".")+1, "int main()")
			call append(line(".")+2, "{")
			call append(line(".")+3, "")
			call append(line(".")+4, "	exit(0);")
			call append(line(".")+5, "}")

		elseif &filetype == 'make'
			call setline(1,"CPPFLAGS+=-Wall -g")
			call append(line("."), "CFLAGS+=-Wall -g")
			call append(line(".")+1, "CXX=g++")
			call append(line(".")+2, "CC=gcc")
			call append(line(".")+3, "%.o: %.c")
			call append(line(".")+4, "	$(CXX) $(CPPFLAGS) $^ -o  $@")
			call append(line(".")+5, "clean:")
			call append(line(".")+6, "	rm  main.exe *.o -rf")

		elseif &filetype == 'python'
			call setline(1,"#!/usr/bin/env python")
			call append(line("."),"# coding=utf-8")
			call append(line(".")+1, "") 

		elseif &filetype == 'java'
			call setline(1,"public class ".expand("%:r"))
			call append(line("."),"")

		elseif &filetype == 'ruby'
			call setline(1,"#!/usr/bin/env ruby")
			call append(line("."),"# encoding: utf-8")
			call append(line(".")+1, "")
		endif
		"如果文件后缀为 .cpp  且 不存在initial_codes（非刷题目录）。
		if expand("%:e") == 'cpp' && file_readable("initial_codes.cpp")==0
			call setline(1, "#include<iostream>")
			call append(line("."), "using namespace std;")
			call append(line(".")+1, "int main()")
			call append(line(".")+2, "{")
			call append(line(".")+3, "")
			call append(line(".")+4, "	return 0;")
			call append(line(".")+5, "}")
		endif
		"如果文件后缀为 .h 文件
		if expand("%:e") == 'h'
			call setline(1, "#ifndef ".toupper(expand("%:r"))."_H")
			call append(line("."), "#define ".toupper(expand("%:r"))."_H")
			call append(line(".")+1, "#endif")
		endif
	endfunc
	autocmd BufNewFile *.sh,*.java,*.h,*.c,*.cpp,makefile,*.py,*.rb exec ":call SetTitle()"
	"normal命令中的可选参数 ! 用于指示vim在当前命令中不使用任何vim映射
	autocmd BufNewFile *.c,*.cpp normal! 5gg
	autocmd BufNewFile *.h normal! ggo

	func! ReadAllFileType()
		normal!	gg=G
		" Vim 重新打开文件时，回到上次历史所编辑文件的位置
		if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 
	endfunc
	autocmd BufReadPost *.html,*.c,*.cpp,*.sh call ReadAllFileType()
	"call之前，函数体得存在。如果是键位map调用函数的话，倒不介意顺序(不过，需要source一下)。

augroup END
" }}}
" < FileType settings 也就是autocmd命令组的文件类型具体化 > {{{
" -----------------------------------------------------------------------------
augroup c_cpp__
	autocmd!
	autocmd FileType c,cpp setlocal tabstop=4|setlocal shiftwidth=4|setlocal softtabstop=4|setlocal noexpandtab
	"makeprg参数设置以后，:make将执行这个语句，且可以用:cw打开错误信息、:cn跳转到下一个错误、:cp跳转到上一个
	if(isWindows)
		autocmd FileType c,cpp setlocal makeprg=g++\ -Wall\ -std=c++17\ -g\ -o\ %:r.exe\ 
	else
		autocmd FileType c,cpp setlocal makeprg=g++\ -Wall\ -std=c++17\ -g\ -o\ %:r\ 
	endif
	autocmd FileType c,cpp setlocal cindent
	"autocmd FileType c,cpp setlocal foldmethod=marker | setlocal foldmarker=@hyf,fyh@ "手动
	autocmd FileType c,cpp setlocal foldmethod=marker
	"打开c,cpp文件时全部折叠
	autocmd BufReadPre *.cpp,*.c setlocal foldlevelstart=-1

	autocmd FileType c iabbrev <buffer>			yfc #include<stdio.h><cr>#include<stdlib.h><cr>int main()<cr>{<cr>exit(0);<cr>}<esc>kO<esc>i   
	autocmd FileType cpp iabbrev <buffer>		yfpp #include<cstdio><cr>#include<cmath><cr>#include<iostream><cr>int main()<cr>{<cr>using std::cout;<cr>return 0;<cr>}<esc>kO<esc>i   

	autocmd FileType c,cpp iabbrev <buffer>		ifndef #ifndef<cr>#define<cr>#endif
	autocmd FileType c,cpp iabbrev <buffer>		fori for(int i=0;i<m;++i)<cr>{<cr>}<esc>O
	autocmd FileType c,cpp iabbrev <buffer>		forj for(int j=0;j<n;++j)<cr>{<cr>}<esc>O
	autocmd FileType c,cpp iabbrev <buffer>		structt struct<cr>{<cr>};<esc>O<esc>i   
	autocmd FileType c,cpp iabbrev <buffer>		printt printf("",);<left><left><left>
	autocmd FileType c,cpp iabbrev <buffer>		scann scanf("",);
	autocmd FileType c,cpp iabbrev <buffer>		switchh switch(VALUE)<cr>{<cr>case 0:<cr>break;<cr>case 1:<cr>case 2:<cr>break;<cr>default:<cr>break;<cr>}
	autocmd FileType c,cpp iabbrev <buffer>		iff if( )<left><left>
	autocmd FileType cpp iabbrev <buffer>		coutt cout<<<cr><cr><<endl;<esc>ki<tab>   

	"c,cpp注释(comment)快捷键：-c
	autocmd FileType c,cpp nnoremap <buffer> <localleader>c I//<esc>
augroup END
augroup python_
	autocmd!
	autocmd FileType python iabbrev <buffer> iff if:<left>
	autocmd FileType python iabbrev <buffer> else else:
	autocmd FileType python iabbrev <buffer> fori for i in range(n):
	autocmd FileType python iabbrev <buffer> printt print("")<left><left>
	"只在编辑python类型的文件时展开 tab为空格
	autocmd FileType python setlocal tabstop=4|setlocal shiftwidth=4|setlocal softtabstop=4|setlocal expandtab
	"python注释(comment)快捷键：-c
	autocmd FileType python,sh nnoremap <buffer> <localleader>c I#<esc>
augroup END
augroup javascript
	autocmd!
	autocmd FileType javascript iabbrev <buffer> iff if ()<left>
	"javasript注释(comment)快捷键：-c
	autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
	autocmd FileType javascript setlocal foldmethod=marker | setlocal foldmarker=@hyf,fyh@ 
	autocmd BufReadPre *.js setlocal foldlevelstart=0
augroup END
augroup shell_
	autocmd!
	autocmd FileType sh iabbrev <buffer> yfsh #! /bin/bash<cr>
	autocmd FileType sh iabbrev <buffer> iff if []; then<cr><cr>fi<esc>2kf]i
augroup END
" }}}
" < Vimscript file settings > {{{
" -----------------------------------------------------------------------------
augroup filetype_vim
	autocmd!
	"设置折叠
	autocmd FileType vim setlocal foldmethod=marker
	"打开文件时全部折叠
	autocmd BufReadPre *vimrc* setlocal foldlevelstart=0
	"保存的时候，让 vimrc 配置变更立即生效
	autocmd BufWritePost $MYVIMRC source $MYVIMRC    
	"vimrc 注释一行快捷键
	autocmd FileType vim nnoremap <buffer> <localleader>c I"<esc>
augroup END
"}}}

" < 插件vim-cpp-enhanced-highlight > 
"{{{
" -----------------------------------------------------------------------------
let g:cpp_class_scope_highlight = 1 "类作用域的突出显示
let g:cpp_member_variable_highlight = 1 "成员变量的突出显示
let g:cpp_concepts_highlight = 1  "标准库的关键字 高亮
"}}}

" < 插件plug-vim > 
"{{{
" -----------------------------------------------------------------------------
" Download plug.vim and put it in ~/.vim/autoload
"在windows平台下这个名称是vimfiles，在unix类平台下是~/.vim
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/vimfiles/plugged') "这里规定安装目录,中间各行代表获取的插件
"vim-cpp-enhanced-highlight高亮 类，成员函数，标准库和模板
Plug 'octol/vim-cpp-enhanced-highlight'
"echofunc查看函数原型, 则可以通过按键"Alt+ -"和"Alt+ =“向前和向后翻页查看重载版本
Plug 'mbbill/echofunc'
call plug#end()
"----------------------------------------
"状态 :PlugStatus 检查现在 plug 负责的插件状态
"安装 :PlugInstall 将写入vimrc配置的插件进行安装
"更新 :PlugUpdate 更新已安装的插件
"清理 :PlugClean 清理插件，需要现在 .vimrc 里面删除或注释掉
"升级 :PlugUpgrade 升级自身
nnoremap <F1> :call PlugInstall()<CR>
func! PlugInstall()
	exec "PlugInstall"
endfunc
"}}}

"这下面是笔记，或者是教程
" # < vim ctags cheatsheet > {{{
" -----------------------------------------------------------------------------
"利用C:\Windows\ctags.exe在当前目录下生成详细tag文件的命令：ctags -R --languages=c++ --langmap=c++:+.inl -h +.inl --c++-kinds=+p+x-d --fields=+liaS --extras=+q
"各个参数的解析，请看这个中文网站：https://www.cnblogs.com/coolworld/p/5602589.html
" 以及这里 有中文帮助: https://blog.easwy.com/archives/exuberant-ctags-chinese-manual/
"
"			Command					Function
"-----------------------------------------------------------------------------
"			Ctrl + ]				Go to definition 跳转到定义
"			Ctrl + T				Jump back from the definition 直接从定义中走出来。(Ctrl + O 只是回到上次缓冲区位置)
"			Ctrl + W Ctrl + ]		Open the definition in a horizontal split 水平分屏打开定义
"			:ts <tag_name>			List the tags that match <tag_name> 罗列所有匹配这个名字的tag
"			:tn						Jump to the next matching tag  下一个匹配
"			:tp						Jump to the previous matching tag 上一个匹配
"}}}
" # <localleader>映射已经使用的快捷键说明----------{{{
"+ c												"C"omment 注释
" }}}
" # <Leader>映射已经使用的快捷键说明(a-z)----------{{{
"+ 1 2 3 4 5 6 7 8 9 0                              访问第几个tab标签页
"+ a												"A"ll selected
"+ bd												"B"uffer "D"elete
"+ bo 												"B"uffer "O"nly 
"+ cv												"C"hange "V"imrc
"+ 
"+ e												"E"xecute (编译执行) 函数
"+
"+
"+
"+
"+
"+
"+
"+ 
"+
"+
"+ 
"+
"+
"+
"+ obj												"Obj"Dump
"+ p                                                "P"aste mode
"+ <leader>p                                        no "P"aste mode
"+ q												"Q"uit vim
"+ <leader>q										force "Q"uit
"+
"+
"+ sh												"Sh"ell 函数
"+ sv												"S"oure "V"imrc
"+ tag 												"Ctag" 函数
"+
"+
"+ w												"W"rite
"+ <up>												竖直方向增大窗口
"+ <down>											
"+ <left>										
"+ <right>											水平方向增大窗口
" }}}
