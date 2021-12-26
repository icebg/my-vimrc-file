colorscheme molokai	"设置配色方案，在~/.vim/colors/目录下提前放置molokai.vim.至于gvim我喜欢motus, ubuntu的vim我喜欢default，vsvim我喜欢web13234.vssettings
"----------------------------------------
"利用C:\Windows\ctags.exe在当前目录下生成详细tag文件的命令：ctags -R --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+liaS --extras=+q
"有了ctag以后，ctrl+] 进入函数定义，ctrl+o 回退
"生成 并更新tag文件
noremap <Leader>tag :call Ctag()<CR>
func! Ctag()
	if &filetype == 'c'
		exec "silent :!ctags -R --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+liaS --extras=+q" 
	elseif &filetype == 'cpp'
		exec "silent :!ctags -R --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+liaS --extras=+q" 
	endif
endif
endfunc


"C，C++ 按分号e编译运行
noremap <Leader>e :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!gcc -Wall % -o %:r && ./%:r && rm ./%:r"  
	elseif &filetype == 'cpp'
		exec "!g++ -Wall % -o %:r && ./%:r && rm ./%:r"  
	elseif &filetype == 'sh'
		exec "!. %"	
		"在当前bash执行此脚本
	elseif &filetype == 'python'
		exec "!python %"
	endif
endfunc
"分号d 编译
noremap <Leader>d :call CompileDebug()<CR>
func! CompileDebug()
	exec "w"
	exec "!g++ -Wall -g % -o %:r && gdb %:r"
endfunc
"分号m 执行makefile
noremap <Leader>m :call Make()<CR>
func! Make()
	exec "!make;"
endfunc
"分号sh 进入shell
noremap <Leader>sh :call ToShell()<CR>
func! ToShell()
	exec "w"
	exec ":shell"
endfunc
"-------------------以下与gvim和vim无关----------------------
"yes!the former partion still here in _vimrc successfully![[[[former]]]]
"yes!the latter partion trans successfully![[[[latter]]]]
"目前我的vim个人配置文件
"一般的映射，都写nore防止递归
" Mappings映射(map)----------{{{
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
" "C"hange "V"imrc"的首字母,竖直分屏，打开.vimrc进行编辑,记
"noremap <leader>cv <esc>:vsplit $MYVIMRC<cr>
noremap <leader>cv <esc>:tabnew $MYVIMRC<cr>
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
nnoremap <leader>sv <esc>:source $MYVIMRC<cr>
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
nnoremap <silent><s-tab> :tabprevious<CR>	"上一个标签页
inoremap <silent><s-tab> <Esc>:tabprevious<CR>	
nnoremap <silent><Tab>q :tabclose<CR>	"退出标签
nnoremap <silent><Tab>n :tabnext<CR>	"下一个标签页
nnoremap <silent><Tab>p :tabprevious<CR>	"上一个标签页


" }}}
" <Leader>映射已经使用的快捷键说明----------{{{
"+ 1 2 3 4 5 6 7 8 9 0                              访问第几个tab标签页
"+ a												"A"ll selected
"+ bd												"B"uffer "D"elete
"+ cv												"C"hange "V"imrc
"+ d												"D"ebug 函数
"+ e												"E"xecute (编译执行) 函数
"+
"+
"+
"+
"+
"+
"+
"+ m												"M"ake 函数
"+
"+
"+ 
"+
"+
"+
"+
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
" Basic Settings基础设置(set)----------{{{
set encoding=utf-8
set termencoding=utf-8
set nocompatible  "去掉讨厌的有关vi兼容模式，避免以前版本的一些bug和局限
set showcmd	"输入的命令显示出来，看的清楚些"
set showmatch "开启高亮显示匹配括号"
set showmode "显示当前处于哪种模式
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
"abbreviate缩写替换----------{{{
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
" Vimscript file settings ----------{{{
augroup filetype_vim
	autocmd!
	"设置折叠
	autocmd FileType vim setlocal foldmethod=marker
	"打开文件时全部折叠
	autocmd BufReadPre *vimrc* setlocal foldlevelstart=0
	autocmd BufWritePost $MYVIMRC source $MYVIMRC    "保存的时候，让 vimrc 配置变更立即生效
augroup END
" }}}
" autocmd命令们----------{{{
augroup global
	autocmd!
	"打开任何类型的文件时，自动缩进。(BufNewFile表示即使这个文件不存在，也创建并保存到硬盘)
	"注释不要写到自动命令后面(尤其是normal关键字后面)。 
	"autocmd BufWritePre,BufRead *.html normal gg=G 

	"SetTitle()自动插入文件头 
	func! SetTitle()                          "定义函数 SetTitle，自动插入文件头
		"如果文件类型为 .sh 文件
		if &filetype == 'sh'
			call setline(1,          "\#########################################################################")
			call append(line("."),   "\# File Name: ".expand("%"))
			call append(line(".")+1, "\# Author: Yufeng Huang <icebggg@qq.com>")
			call append(line(".")+2, "\# Created Time: ".strftime("%c"))
			call append(line(".")+3, "\#########################################################################")
			call append(line(".")+4, "\#!/bin/bash")
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
		"如果文件后缀为 .cpp 
		if expand("%:e") == 'cpp'
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
	autocmd BufNewFile *.c,*.cpp normal 5gg
	autocmd BufNewFile *.h normal ggo

	func! ReadAllFileType()
		normal	gg=G
		" Vim 重新打开文件时，回到上次历史所编辑文件的位置
		if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 
	endfunc
	autocmd BufReadPost *.html,*.c,*.cpp,*.sh call ReadAllFileType()
	"call之前，函数体得存在。如果是键位map调用函数的话，倒不介意顺序(不过，需要source一下)。

augroup END
" }}}
" Status Line ----------{{{
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
" FileType settings ----------{{{
augroup c_cpp_
	autocmd!
	autocmd FileType c,cpp setlocal tabstop=4|setlocal shiftwidth=4|setlocal softtabstop=4|setlocal noexpandtab
	autocmd FileType c,cpp setlocal cindent 

	autocmd FileType c,cpp setlocal foldmethod=marker
	autocmd FileType c,cpp setlocal foldmarker=@hyf,fyh@
	"打开c,cpp文件时全部折叠
	autocmd BufReadPre *.cpp,*.c setlocal foldlevelstart=0

	autocmd FileType c iabbrev <buffer>			yfc #include<stdio.h><cr>#include<stdlib.h><cr>int main()<cr>{<cr>exit(0);<cr>}<esc>kO<esc>i   
	autocmd FileType cpp iabbrev <buffer>		yfpp #include<cstdio><cr>#include<cmath><cr>#include<iostream><cr>int main()<cr>{<cr>using std::cout;<cr>return 0;<cr>}<esc>kO<esc>i   

	autocmd FileType c,cpp iabbrev <buffer>		ifndef #ifndef<cr>#define<cr>#endif
	autocmd FileType c,cpp iabbrev <buffer>		fori for(int i=0;i<;++i)<cr>{<cr>}<esc>O
	autocmd FileType c,cpp iabbrev <buffer>		structt struct<cr>{<cr>};<esc>O<esc>i   
	autocmd FileType c,cpp iabbrev <buffer>		printt printf("",);<left><left><left>
	autocmd FileType c,cpp iabbrev <buffer>		scann scanf("",);
	autocmd FileType c,cpp iabbrev <buffer>		switchh switch(VALUE)<cr>{<cr>case 0:<cr>break;<cr>case 1:<cr>case 2:<cr>break;<cr>default:<cr>break;<cr>}
	autocmd FileType c,cpp iabbrev <buffer>		iff if( )<left><left>
	autocmd FileType cpp iabbrev <buffer>		coutt cout<<<cr><cr><<endl;<esc>ki<tab>   

	"PoinT_To
	autocmd FileType c,cpp iabbrev <buffer>		ptt ->next
	"PointNeXt
	autocmd FileType c,cpp iabbrev <buffer>		pnx ->next
	"加 Plus 
	autocmd FileType c,cpp iabbrev <buffer>		jo +
	"减 minus 
	autocmd FileType c,cpp iabbrev <buffer>		gn -
	"乘
	autocmd FileType c,cpp iabbrev <buffer>		xn *
	"除
	autocmd FileType c,cpp iabbrev <buffer>		fv /
	"等 Equal
	autocmd FileType c,cpp iabbrev <buffer>		dn =
	"小于
	autocmd FileType c,cpp iabbrev <buffer>		dv >
	"大于
	autocmd FileType c,cpp iabbrev <buffer>		xv <

	"括-号
	autocmd FileType c,cpp inoremap <buffer>	;k ()<esc>i
	"中括-号
	autocmd FileType c,cpp inoremap <buffer>	;zk []<esc>i
	"花括-号
	autocmd FileType c,cpp inoremap <buffer>	;hk {}<esc>i
	"百-分号
	autocmd FileType c,cpp inoremap <buffer>	;b %
	"取-址符号
	autocmd FileType c,cpp inoremap <buffer>	;q &

	"c,cpp注释(comment)快捷键：-c
	autocmd FileType c,cpp nnoremap <buffer> <localleader>c I//<esc>
augroup END
augroup python_
	autocmd!
	autocmd FileType python iabbrev <buffer> iff if:<left>
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
	autocmd FileType javasript nnoremap <buffer> <localleader>c I//<esc>
augroup END
augroup shell_
	autocmd!
	autocmd FileType sh iabbrev <buffer> yfsh #!/bin/bash<cr>
augroup END
" }}}

" <localleader>映射已经使用的快捷键说明----------{{{
"+ c												"C"omment 注释
" }}}

" gui_running----------{{{
if(has("gui_running"))
	packadd termdebug "启用GDB包,然后就能[ :Termdebug + 可执行程序名] .termdebug 是从 Vim 8.1 开始内置的调试插件，仅支持 GDB。
	" termdebug 是从 Vim 8.1 开始内置的调试插件，仅支持 GDB。
	nnoremap <F11> :call GDB()<CR>
	func! GDB()
		exec "Termdebug %:r"
	endfunc
	"行距 linespace
	set linespace=4
	set shell=powershell
	colorscheme motus "设置配色方案，在~/.vim/colors/目录下提前放置molokai.vim.至于gvim我喜欢motus, ubuntu的vim我喜欢default,molokai，vsvim我喜欢web13234.vssettings
	autocmd BufReadPost *.txt exe ": colorscheme Autumn2"|setlocal linespace=10
	set guioptions-=T "去掉工具栏
	set guioptions-=m "去掉菜单栏
	"set guifont=Bitstream\ Vera\ Sans\ Mono:h12
	set guifont=Cr.DejaVuSansMono.YaHei:h12
endif
"}}}

let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '->'
