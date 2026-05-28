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
set wrap
set breakindent
let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_liststyle=3

let s:plugin_dir = expand('~/.vim/plugged')
function! s:ensure(repo, ...)
  let branch = get(a:, 1, '')
  let name = split(a:repo, '/')[-1]
  let path = s:plugin_dir . '/' . name
  if !isdirectory(path)
    if !isdirectory(s:plugin_dir)
      call mkdir(s:plugin_dir, 'p')
    endif
    let cmd = '!git clone --depth=1'
    if branch != ''
      let cmd .= ' --branch ' . shellescape(branch)
    endif
    let cmd .= ' https://github.com/' . a:repo . ' ' . shellescape(path)
    execute cmd
  endif
  execute 'set runtimepath+=' . fnameescape(path)
endfunction

call s:ensure('junegunn/fzf')
call s:ensure('junegunn/fzf.vim')
nnoremap <leader>fr :Rg! <CR>
nnoremap <leader>fR :RG! <CR>
nnoremap <leader>ff :Files!<CR>
nnoremap <leader>fg :GFiles!?<CR>
nnoremap <leader>fG :BCommits!<CR>
nnoremap <leader>fl :Lines!<CR>
nnoremap <leader>fc :Commits!<CR>
nnoremap <leader>fC :Changes!<CR>
nnoremap <leader>fm :Marks!<CR>
nnoremap <leader>fj :Jumps!<CR>
nnoremap <leader>fw :Windows!<CR>
nnoremap <leader>fh :History!<CR>
nnoremap <leader>fH :History:!<CR>
nnoremap <leader>fb :Buffers!<CR>
nnoremap <leader>fp :Maps!<CR>
nnoremap <leader>fe :Commands!<CR>
nnoremap <leader>ft :Helptags!<CR>

call s:ensure('vim-airline/vim-airline')
let g:airline#extensions#tabline#enabled = 1

call s:ensure('prabirshrestha/vim-lsp')
call s:ensure('prabirshrestha/asyncomplete.vim')
call s:ensure('prabirshrestha/asyncomplete-lsp.vim')
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
nnoremap <leader>ls :LspHover <CR>
nnoremap <leader>la :LspCodeAction <CR>
nnoremap <leader>lt :LspDefinition<CR>
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
inoremap <F2> :LspRename<CR>

call s:ensure('tpope/vim-fugitive')
call s:ensure('airblade/vim-gitgutter')
let g:gitgutter_map_keys = 0
set updatetime=100
set signcolumn=yes
set cursorline
nnoremap <leader>gn :GitGutterNextHunk<CR>
nnoremap <leader>gp :GitGutterPrevHunk<CR>

call s:ensure('mbbill/undotree')
if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif
nnoremap <leader>u :UndotreeToggle<CR>

call s:ensure('romus204/tree-sitter-manager.nvim')
call s:ensure('folke/tokyonight.nvim')
lua <<EOF
require("tree-sitter-manager").setup()
require("tokyonight").setup()
vim.cmd.colorscheme("tokyonight-night")
EOF

inoremap ww <Esc>:w<CR>
" keep previous register after pasting in v mode
xnoremap <leader>p "_dP
vnoremap <leader>d "_d
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap J mzJ`z
nnoremap <leader>P "+p
nnoremap <leader>d "_d
nnoremap <leader>r <C-r>
nnoremap <leader>q :bd!<CR>
nnoremap <leader>z <c-z>
nnoremap <leader>i <c-i>
nnoremap <leader>o <c-o>
nnoremap <leader>x vip:!sh<CR>
nnoremap <leader>h :let @+ = expand('%')<CR>
nnoremap <leader>b :e %:h<CR>
nnoremap <leader>nw :wincmd k<CR>
nnoremap <leader>nW :wincmd K<CR>
nnoremap <leader>nr :wincmd j<CR>
nnoremap <leader>nR :wincmd J<CR>
nnoremap <leader>ns :wincmd l<CR>
nnoremap <leader>nS :wincmd L<CR>
nnoremap <leader>na :wincmd h<CR>
nnoremap <leader>nA :wincmd H<CR>
nnoremap <leader>nn :wincmd w<CR>
nnoremap <leader>nt :wincmd W<CR>

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

set autoread
if executable('templ')
autocmd BufWritePost *.templ silent! execute "!PATH=\"$PATH:$(go env GOPATH)/bin\" templ fmt <afile> >/dev/null 2>&1" | redraw!
endif

nnoremap <leader>as :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
" Snippets
nnoremap <leader>ai :-1read ~/.vim/snippets/go/iferr<CR>jf"a

function! GitParagraphFzf()
  let file = expand('%:p')
  let start = line("'{")
  let end = line("'}")

  let range = start . ',' . end . ':' . shellescape(file)

  " commits affecting paragraph
  let cmd = 'git log --pretty=format:"%h %s" --no-patch -L ' . range

  let source = systemlist(cmd)

  call fzf#run(fzf#wrap({
        \ 'source': source,
        \ 'options': '--ansi --preview "git show --stat {1}"',
        \ 'sink': function('s:OpenCommitFull')
        \ }))
endfunction

function! s:OpenCommitFull(line)
  let hash = split(a:line)[0]

  let file = expand('%:p')

  " FULL DIFF VIEW (no truncation)
  execute 'tabnew'
  execute 'terminal git difftool ' . hash . '^ ' . hash . ' -- ' . shellescape(file)
endfunction

nnoremap <leader>gl :call GitParagraphFzf()<CR>

call s:ensure("nvim-lua/plenary.nvim")
call s:ensure("ThePrimeagen/harpoon", "harpoon2")
call s:ensure("folke/trouble.nvim")
call s:ensure("ggandor/leap.nvim")
call s:ensure("tpope/vim-commentary")

lua <<EOF
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>tt", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>tl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>tn", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>te", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>ti", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>to", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>tu", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>ty", function() harpoon:list():next() end)

require("trouble").setup({
     auto_close = true,
     focus = true,
})

vim.keymap.set("n", "<leader>e", function()
  vim.cmd("cclose")
  vim.cmd("Trouble quickfix toggle")
end)

vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
vim.keymap.set('n',               'S', '<Plug>(leap-from-window)')

vim.notify = function(msg, level)
  if level == vim.log.levels.ERROR then
    vim.api.nvim_err_writeln(msg)
  end
end

vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })

EOF

call s:ensure("mattn/vim-lsp-settings")
call s:ensure("dart-lang/dart-vim-plugin")

if executable('dart')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'dartls',
        \ 'cmd': {server_info->['dart', 'language-server']},
        \ 'allowlist': ['dart'],
        \ })
endif
autocmd BufWritePre *.dart LspDocumentFormatSync

