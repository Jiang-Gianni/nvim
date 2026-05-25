if (has("termguicolors"))
 set termguicolors
endif

let mapleader = " "
syntax on
colorscheme night-owl
filetype plugin indent on
set number relativenumber
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set incsearch
set nohlsearch
set autoindent
set scrolloff=8
set sidescrolloff=5
set completeopt=menu,menuone,noselect,preview
set clipboard=unnamedplus
set omnifunc=lsp#complete
set iskeyword+=-
set path+=**
set showcmd
set ruler
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3

highlight PmenuSel guibg=#d97706 guifg=#ffffff

let s:plugin_dir = expand('~/.vim/plugged')
function! s:ensure(repo)
  let name = split(a:repo, '/')[-1]
  let path = s:plugin_dir . '/' . name
  if !isdirectory(path)
    if !isdirectory(s:plugin_dir)
      call mkdir(s:plugin_dir, 'p')
    endif
    execute '!git clone --depth=1 https://github.com/' . a:repo . ' ' . shellescape(path)
  endif
  execute 'set runtimepath+=' . fnameescape(path)
endfunction

call s:ensure('junegunn/fzf')
call s:ensure('junegunn/fzf.vim')
call s:ensure('vim-airline/vim-airline')
let g:airline#extensions#tabline#enabled = 1

call s:ensure('prabirshrestha/vim-lsp')
call s:ensure('prabirshrestha/asyncomplete.vim')
call s:ensure('prabirshrestha/asyncomplete-lsp.vim')
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1

call s:ensure('tpope/vim-fugitive')
call s:ensure('airblade/vim-gitgutter')
set updatetime=100
set signcolumn=yes
set cursorline

" Keybindings insert mode
inoremap <C-c> <Esc>
inoremap <c-s> <Esc>:w<CR>
" suggestions/autocomplete trigger
inoremap <C-n> <C-x><C-o>

" Keybindings normal mode
nnoremap <C-q> :bd!<CR>
nnoremap <C-f> :Rg <CR>
nnoremap <C-p> :Files<CR>

nnoremap <c-s> :w<CR>
nnoremap <C-t> :LspHover <CR>

nnoremap <C-l> :cnext<CR>
nnoremap <C-u> :cprev<CR>
nnoremap <C-y> :LspReferences<CR>
nnoremap <C-g> :LspDefinition<CR>

nnoremap <C-n> :History<CR>
nnoremap <C-e> <c-z>
" <C-i> and <C-o> to navigate back and forward

nnoremap <leader>gn :GitGutterNextHunk<CR>
nnoremap <leader>gp :GitGutterPrevHunk<CR>

nnoremap <C-m> :bnext<CR>
nnoremap <C-d> :bprevious<CR>
nnoremap <C-h> :let @+ = expand('%')<CR>
nnoremap <C-b> :Buffers<CR>

nnoremap <F2> :LspRename<CR>


" Go LSP
if executable('gopls')
  augroup lsp_go
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'gopls',
          \ 'cmd': {server_info->['gopls']},
          \ 'allowlist': ['go'],
          \ })
  augroup END
endif

let g:go_highlight_comma = 1
let g:go_highlight_semicolon = 1
let g:go_highlight_struct_type_fields = 1
let g:go_highlight_struct_fields = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_string_errors = 1
autocmd BufWritePre *.go silent LspDocumentFormatSync
autocmd BufWritePre *.go silen call execute('LspCodeAction source.organizeImports')

" Diagnostic
let g:lsp_diagnostics_virtual_text_prefix = "● "
let g:lsp_diagnostics_virtual_text_align = "after"
highlight LspErrorText   ctermfg=red guifg=#ff6b6b
highlight LspWarningText ctermfg=yellow guifg=#f7d794

set autoread
if executable('templ')
autocmd BufWritePost *.templ silent! execute "!PATH=\"$PATH:$(go env GOPATH)/bin\" templ fmt <afile> >/dev/null 2>&1" | redraw!
endif

" Snippets
nnoremap <leader>sife :-1read ~/.vim/snippets/go/iferr<CR>jf"a
