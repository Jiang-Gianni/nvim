let mapleader = " "
filetype plugin indent on
set termguicolors
syntax on
set number relativenumber
set nocp
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set incsearch
set nohlsearch
set hidden
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
let g:netrw_altv=1
let g:netrw_liststyle=3

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
nnoremap <leader>fr :Rg <CR>
nnoremap <leader>fR :RG <CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles?<CR>
nnoremap <leader>fc :Colors<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fc :Changes<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fj :Jumps<CR>
nnoremap <leader>fw :Windows<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fG :BCommits<CR>
nnoremap <leader>fp :Maps<CR>
nnoremap <leader>fe :Commands<CR>
nnoremap <leader>ft :Helptags<CR>

call s:ensure('vim-airline/vim-airline')
let g:airline#extensions#tabline#enabled = 1

call s:ensure('prabirshrestha/vim-lsp')
call s:ensure('prabirshrestha/asyncomplete.vim')
call s:ensure('prabirshrestha/asyncomplete-lsp.vim')
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
nnoremap <leader>lh :LspHover <CR>
nnoremap <leader>la :LspCodeAction <CR>
nnoremap <leader>lf :LspDefinition<CR>
nnoremap <leader>lpf :LspPeekDefinition<CR>
nnoremap <leader>ldd :LspDocumentDiagnostics <CR>
nnoremap <leader>lnd :LspNextDiagnostic<CR>
nnoremap <leader>lpd :LspPreviousDiagnostic<CR>
nnoremap <leader>lne :LspNextError<CR>
nnoremap <leader>lpe :LspPreviousError<CR>
nnoremap <leader>lr :LspReferences<CR>
nnoremap <leader>lnr :LspNextReference<CR>
nnoremap <leader>lpr :LspPreviousReference<CR>
nnoremap <leader>lnw :LspNextWarning<CR>
nnoremap <leader>lpw :LspPreviousWarning<CR>
nnoremap <F2> :LspRename<CR>

call s:ensure('tpope/vim-fugitive')
call s:ensure('airblade/vim-gitgutter')
set updatetime=100
set signcolumn=yes
set cursorline
nnoremap <leader>gn :GitGutterNextHunk<CR>
nnoremap <leader>gp :GitGutterPrevHunk<CR>

call s:ensure('mbbill/undotree')
nnoremap <leader>u :UndotreeToggle<CR>

call s:ensure('romus204/tree-sitter-manager.nvim')
call s:ensure('folke/tokyonight.nvim')
lua <<EOF
require("tree-sitter-manager").setup()
require("tokyonight").setup()
vim.cmd.colorscheme("tokyonight-night")
EOF

" Keybindings insert mode
inoremap qq <Esc>
inoremap ww <Esc>:w<CR>

" Keybindings normal mode
nnoremap <leader>q :bd!<CR>
nnoremap <leader>ee <c-z>
nnoremap <leader>ei <c-i>
nnoremap <leader>eo <c-o>
nnoremap <leader>ex vip:!sh<CR>
nnoremap <leader>eh :let @+ = expand('%')<CR>

nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bb :bprevious<CR>
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cc :cprevious<CR>

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

set autoread
if executable('templ')
autocmd BufWritePost *.templ silent! execute "!PATH=\"$PATH:$(go env GOPATH)/bin\" templ fmt <afile> >/dev/null 2>&1" | redraw!
endif

" Snippets
nnoremap <leader>sife :-1read ~/.vim/snippets/go/iferr<CR>jf"a


