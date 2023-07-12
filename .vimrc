set tabstop=4
set shiftwidth=4
set showmatch
set number
set matchtime=1
set matchpairs& matchpairs+=<:>

inoremap ( ()<ESC>i
inoremap () ()<ESC>a
inoremap { {}<ESC>i
inoremap {} {}<ESC>a

inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

inoremap [ []<ESC>i
inoremap [] []<ESC>a

inoremap " ""<ESC>i
inoremap "" ""<ESC>a

inoremap ' ''<ESC>i
inoremap '' ''<ESC>a

nnoremap <silent> J :bprev<CR>
nnoremap <silent> K :bnext<CR>

inoremap <silent> jj <ESC>
" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

set completeopt=menuone,noinsert
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR> 

call setcellwidths([[0x2588, 0x258f, 1]])

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'lambdalisue/fern.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'tpope/vim-surround'
Plug 'skanehira/translate.vim'

" color scheme
Plug 'joshdick/onedark.vim'
Plug 'haishanh/night-owl.vim'
Plug 'altercation/vim-colors-solarized'
" Syntax
Plug 'vim-python/python-syntax'

" Initialize plugin system
call plug#end()

if executable('gopls')
		au User lsp_setup call lsp#register_server({
								\ 'name': 'gopls',
								\ 'cmd' : {server_info->['gopls', '-remote=auto']},
								\ 'allowlist' : ['go'],
								\ })
		autocmd BufWritePre *.go LspDocumentFormatSync
endif

"pythonの自動補完の設定
if executable('pyls')
		au User lsp_setup call lsp#register_server({
								\ 'name': 'pyls',
								\ 'cmd' : {server_info->['pyls']},
								\ 'whitelist' : ['python']
								\ })
endif

" night-owlの設定
if (has("termguicolors"))
	set termguicolors
endif

let g:python_highlight_all = 1

syntax enable
colorscheme night-owl

let g:lightline = {'colorscheme': 'nightowl'}
let g:airline#extensions#tabline#enabled = 1

" Syntaxを表示するの関数
function! s:get_syn_id(transparent)
	let synid = synID(line("."), col("."), 1)
	if a:transparent
		return synIDtrans(synid)
	else
		return synid
	endif
endfunction

function! s:get_syn_attr(synid)
	let name = synIDattr(a:synid, "name")
	let ctermfg = synIDattr(a:synid, "fg", "cterm")
	let ctermbg = synIDattr(a:synid, "bg", "cterm")
	let guifg = synIDattr(a:synid, "fg", "gui")
	let guibg = synIDattr(a:synid, "bg", "gui")
	return {
				\ "name": name,
				\ "ctermfg": ctermfg,
				\ "ctermbg": ctermbg,
				\ "guifg": guifg,
				\ "guibg": guibg}
endfunction

function! s:get_syn_info()
	let baseSyn = s:get_syn_attr(s:get_syn_id(0))
	echo "name: " . baseSyn.name .
				\ " ctermfg: " . baseSyn.ctermfg .
				\ " ctermbg: " . baseSyn.ctermbg .
				\ " guifg: " . baseSyn.guifg .
				\ " guibg: " . baseSyn.guibg
	let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
	echo "link to"
	echo "name: " . linkedSyn.name .
				\ " ctermfg: " . linkedSyn.ctermfg .
				\ " ctermbg: " . linkedSyn.ctermbg .
				\ " guifg: " . linkedSyn.guifg .
				\ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()
