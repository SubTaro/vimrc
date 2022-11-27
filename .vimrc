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

inoremap [ []<ESC>i
inoremap [] []<ESC>a

inoremap " ""<ESC>i
inoremap "" ""<ESC>a

inoremap ' ''<ESC>i
inoremap '' ''<ESC>a

inoremap <silent> jj <ESC>
" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

set completeopt=menuone,noinsert
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR> 

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
Plug 'haishanh/night-owl.vim'

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

if (has("termguicolors"))
		set termguicolors
endif

"pythonの自動補完の設定
if executable('pyls')
		au User lsp_setup call lsp#register_server({
								\ 'name': 'pyls',
								\ 'cmd' : {server_info->['pyls']},
								\ 'whitelist' : ['python']
								\ })
endif

" ngiht-owlの設定
syntax enable
colorscheme night-owl

let g:lightline = {'colorscheme': 'nightowl'}

inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
let g:airline#extensions#tabline#enabled = 1
