" Start a new autocommand group
:augroup vimrc
  " Erase all autocommands so far in this group
  :autocmd!

  "{{{ Early setup

  " Vim settings instead of vi settings. make sure this is near the top of vimrc
  set nocompatible

  " Something about security and scripts running automatically
  set modelines=0

  " Identify OS {{{
  silent function! OSX()
      return has('macunix')
  endfunction
  silent function! LINUX()
      return has('unix') && !has('macunix') && !has('win32unix')
  endfunction
  silent function! WINDOWS()
      return  (has('win32') || has('win64'))
  endfunction
  " }}}
  if !WINDOWS()
      set shell=/bin/sh
  endif

  " Windows Compatible {{{
  " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization across (heterogeneous) systems easier.
  if WINDOWS()
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
  endif
  " }}}

  " Arrow Key Fix (is this even applicable?) {{{
  " https://github.com/spf13/spf13-vim/issues/780
  if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
    inoremap <silent> <C-[>OC <RIGHT>
  endif
  " }}}

  scriptencoding utf-8

  " Use before config if available {
  if filereadable(expand("~/.vimrc.before"))
    source ~/.vimrc.before
  endif
  if filereadable(expand("~/.vimrc.before.local"))
    source ~/.vimrc.before.local
  endif
  " }

  if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
      set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
      set clipboard=unnamed
    endif
  endif

  " Most prefer to automatically switch to the current file directory when
  " a new buffer is opened; to prevent this behavior, add the following to
  " your .vimrc.before.local file:
  "   let g:spf13_no_autochdir = 1
  if !exists('g:spf13_no_autochdir')
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    " Always switch to the current file directory
  endif

  set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
  "set autowrite                       " Automatically write a file when leaving a modified buffer

  "}}}

  "{{{ Load Vundle Plugins

  if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
  endif

  " }}} // Load Vundle Plugins

  "{{{ Vim default behavior

  " Set history and undo levels to more
  set undolevels=300
  set history=1000

  " Spell checking on
  "set spell

  " Allow backspace to erase more in insert mode
  set backspace=indent,eol,start

  " Set ignore case in search
  set ic
  " Don't ignore case in search when caps specified
  set smartcase
  " Incremental search (move tmp cursor as you type)
  set incsearch
  " Highlight search
  set hls

  " Settings for taboo tab renaming, save tabs and globals in sessions on save
  set sessionoptions+=tabpages,globals
  " Fix colors when restoring a session
  set sessionoptions-=options

  " make tab autocompletion work like bash, with highlighting
  set wildmode=longest,list,full
  set wildmenu

  " ignore case in command completion
  try
    set wildignorecase
  catch
  endtry

  " Save current view when leaving, load when entering buffer
  autocmd BufWinLeave *.* if bufname("%")!=""|mkview|endif
  autocmd BufWinEnter *.* silent loadview

  " Hack to allow "crontab -e" on mac
  au BufEnter /private/tmp/crontab.* setl backupcopy=yes

  " Source this and vimrc on write/save
  autocmd! bufwritepost .vimrc source %

  " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
  " Restore cursor to file position in previous editing session
  " To disable this, add the following to your .vimrc.before.local file:
  "   let g:spf13_no_restore_cursor = 1
  if !exists('g:spf13_no_restore_cursor')
    function! ResCur()
      if line("'\"") <= line("$")
        silent! normal! g`"
        return 1
      endif
    endfunction

    augroup resCur
      autocmd!
      autocmd BufWinEnter * call ResCur()
    augroup END
  endif

  set backup                  " Backups are nice ...
  if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
  endif

  "}}}

  "{{{ Formatting/wrapping/spacing

  " Turn on auto-indenting
  set autoindent
  set smartindent

  " Autowrap text and comments at textwidth if set
  set formatoptions+=tc
  " Don't break a line if it was greater than textwidth when insert mode entered
  set formatoptions+=l
  " Trailing white space indicates a paragraph continues in the next line.
  " A line that ends in a non-white character ends a paragraph.
  set formatoptions+=w
  " Allow formatting of comments with "gq".
  " Note that formatting will not change blank lines or lines containing
  " only the comment leader.  A new paragraph starts after such a line,
  " or when the comment leader changes.
  set formatoptions+=q
  " v: Vi-compatible auto-wrapping in insert mode: Only break a line at a
  " blank that you have entered during the current insert command.  (Note:
  " this is not 100% Vi compatible.  Vi has some "unexpected features" or
  " bugs in this area.  It uses the screen column instead of the line
  " column.)
  " b: Like 'v', but only auto-wrap if you enter a blank at or before
  " the wrap margin.  If the line was longer than 'textwidth' when you
  " started the insert, or you do not enter a blank in the insert before
  " reaching 'textwidth', Vim does not perform auto-wrapping.
  set formatoptions+=b
  " Continue comments after hitting enter (r) and 'o' (o)
  set formatoptions+=ro

  " Set tab width
  set tabstop=2
  set shiftwidth=2

  " Use tabs instead of spaces
  set expandtab

  " Mark end of change-to text with a '$'
  set cpoptions+=$

  " Better Unix / Windows compatibility (not sure what this does exactly)
  set viewoptions=folds,options,cursor,unix,slash

  " '.' is an end of word designator
  set iskeyword-=.
  " '#' is an end of word designator
  set iskeyword-=#
  " '-' is an end of word designator
  set iskeyword-=-
  "}}}

  "{{{ Misc Mappings

  " Custom leader, comma
  let mapleader = ","

  " Remap comma's old functionality to ctrl-backslash
  nmap \ ,
  vmap \ ,

  " Map jk to escape
  :inoremap jk <Esc>

  " Shortcut to auto indent entire file, then go back to location
  nmap <leader>i gg=G``
  "imap <leader>i <ESC>gg=Ga'' " I don't want this in insert mode anymore

  " Open current buffer in new tab
  nmap <leader>o :tabedit %<CR>
  " Open current buffer in new tab and closes in previous
  nmap <leader>O :tabedit %<CR> \| :tabp <CR>\| :q <CR>\| :tabn <CR>
  " Close current tab
  nmap <leader>q :tabclose<CR>
  " Alt-q, close tab
  nmap <M-q> :tabclose<CR>
  " Alt-j, navigate to last tab
  map <M-j> :tabl<CR>
  " Alt-k, navigate to first tab
  map <M-k> :tabfir<CR>
  " Alt-h, navigate to previous tab
  map <M-h> :tabp<CR>
  " Alt-l, navigate to next tab
  map <M-l> :tabn<CR>
  " Alt-c, create new tab
  map <M-c> :tabnew<CR>
  " Alt-r, rename tab
  map <M-r> :TabooRename 

  " Alias :W as :w, so write command works with caps or not
  " Don't use cnoreabbrev because it breaks case sensitive search (e.g. for capital Q)
  "cnoreabbrev W w
  "cnoreabbrev Q q
  "cnoreabbrev Qa qa
  if has("user_commands")
    command! -bang -nargs=? -complete=file E e<bang> <args>
    command! -bang -nargs=? -complete=file W w<bang> <args>
    command! -bang -nargs=? -complete=file Wq wq<bang> <args>
    command! -bang -nargs=? -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
  endif

  " Allow saving as sudo with `:w!!` even if vim wasn't started with sudo
  cmap w!! w !sudo tee > /dev/null %

  " Alias leader-s as :w
  nmap <leader>s :w<CR>

  " Alias alt-w as :w
  nmap <M-w> :w<CR>

  " Allow jumping between quickfix errors
  nmap ]l :lnext<CR>
  nmap [l :lprevious<CR>

  " make j and k act normally for wrapped lines. ctrl-j/k for expected jump behavior
  nnoremap j gj
  nnoremap k gk

  " make K work like k
  nnoremap K k
  vnoremap K k

  "}}}

  " {{{ Customize bundles/plugins

  " {{{ vim-terraform 
  if count(g:spf13_bundle_groups, 'terraform')
    let g:terraform_align=1
    let g:terraform_fmt_on_save=1
    " These are set in vim-terraform's ftdetect, not sure why it isn't working
    autocmd BufRead,BufNewFile *.tf,*.tfvars,.terraformrc,terraform.rc set filetype=terraform
    autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json
  endif
  " }}}

  "  {{{ golden-ratio
  if count(g:spf13_bundle_groups, 'general')
    " disable auto golden ratio resizing
    let g:golden_ratio_autocommand = 0
    :map <leader>r :GoldenRatioResize<CR>
  endif
  " }}}

  " {{{ rainbow
  if count(g:spf13_bundle_groups, 'programming')
    let g:rainbow_active = 1
    "hue-contrasty order
    let g:rainbow_conf = {
          \ 'ctermfgs': ['1', '2', '4', '3', '5', '6', '7'],
          \ 'guifgs': ['red', 'orange', 'yellow', 'green', 'blue', 'violet', 'white']
          \ }

    "rainbow order
    "let g:rainbow_conf = {
    "      \ 'ctermfgs': ['1', '2', '4', '3', '5', '6', '7']
    "      \ }

  endif
  " }}}

  " {{{ xmledit
  if count(g:spf13_bundle_groups, 'programming')
    let g:xmledit_enable_html = 1 "make it work on html files
    " Override xmledit html callback, don't add extra attributes
    function! HtmlAttribCallback( xml_tag )
      return 0
    endfunction
  endif
  " }}}

  " {{{ camelcasemotion
  " Set up default mappings for camelcasemotion
  if count(g:spf13_bundle_groups, 'programming')
    call camelcasemotion#CreateMotionMappings('<leader>')
  endif
  " }}}

  " {{{ vdebug
  if count(g:spf13_bundle_groups, 'php')
    if !exists('g:vdebug_options')
      let g:vdebug_options = {}
    endif
    let g:vdebug_options["break_on_open"]=0

    " Taboo_rename vdebug tab
    noremap <F8> :TabooRename debugger<CR>
    " Auto renaming doesn't work because of python waiting or something
    "let g:vdebug_keymap = { 'run':"" }
    "noremap <F5> :python debugger.run()<CR> :TabooRename debugger<CR>
  endif
  " }}}

  " {{{ taboo
  if count(g:spf13_bundle_groups, 'general')
    " Customize renamed tab format
    let g:taboo_renamed_tab_format=" [%N]%f%m "
  endif
  "}}}

  " {{{ vim-indent-guides
  if count(g:spf13_bundle_groups, 'general')
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_default_mapping = 1 "leader-ig
    let g:indent_guides_auto_colors = 0
    " light bg
    "autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=0 ctermfg=10 guibg=#f1fdd8
    "autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=8 ctermfg=10 guibg=#f7f6d2
    " dark bg
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=0 ctermfg=10 guibg=#012d38
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=8 ctermfg=10 guibg=#073642
    "
    "autocmd VimEnter,Colorscheme * :hi link IndentGuidesOdd CursorLine "FIXME broken in macvim
    "autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=bg ctermfg=10 "FIXME broken in macvim
  endif
  "}}}

  " {{{ nerdtree
  if count(g:spf13_bundle_groups, 'general')
    " Shortcut to open file explorer
    :nnoremap <leader>n :NERDTreeToggle<CR>
    ":nnoremap <leader>m :NERDTreeToggle<CR>
    " Fix nerdtree weird characters
    let g:NERDTreeDirArrows=1
    let g:NERDTreeDirArrowExpandable="+"
    let g:NERDTreeDirArrowCollapsible="~"

    " ignore .pyc files
    let NERDTreeIgnore = ['\~$', '\.pyc$']

    " Shortcut to open nerdtree to current file location
    :map <leader>N :NERDTreeFind<CR>
  endif
  " }}}

  " {{{ nerdcommenter
  if count(g:spf13_bundle_groups, 'general')
    let g:NERDDefaultAlign = 'left'
  endif
  " }}}

  " {{{ ctrlp
  if count(g:spf13_bundle_groups, 'general')
    " Shortcut to open file explorer
    ":map <leader>, :CtrlP<CR>
    nnoremap <C-p> :CtrlP<CR>
    let g:ctrlp_map = ''
    " Ctrlp show hidden files
    "let g:ctrlp_show_hidden=1
    " Ignore files and/or directories
    let g:ctrlp_custom_ignore = {
          \ 'dir': '\v[\/](\.git|vendor|\.vim)$'
          \ }
    " ctrlp search defaults to current dir up to closest .git dir
    let g:ctrlp_working_path_mode = 'ra'
  endif
  " }}}

  " {{{ Syntastic
  if count(g:spf13_bundle_groups, 'programming')
    " show errors list when detected
    "let g:syntastic_auto_loc_list=1
    " Syntastic, show errors list, close when empty, don't open automatically
    let g:syntastic_auto_loc_list=2
    "let g:syntastic_sh_shellcheck_args="-e SC2034"
  endif
  " }}}

  " {{{ YouCompleteMe
  if count(g:spf13_bundle_groups, 'youcompleteme')
    let g:ycm_key_list_select_completion = ['<Down>']
  endif
  " }}}

  " {{{ Snipmate
  if count(g:spf13_bundle_groups, 'snipmate')
    let g:snips_author = "Reese Wilson"
    let g:snipMate = get(g:, 'snipMate', {})
    let g:snipMate.scope_aliases = {}
    let g:snipMate.scope_aliases['php'] = 'php,html'
    let g:snipMate.scope_aliases['javascript'] = 'javascript,javascript-jquery'
    let g:snipMate.scope_aliases['css'] = 'css'

    let g:snipMate.no_default_aliases = 1
  endif
  " }}}

  " {{{ json
  if count(g:spf13_bundle_groups, 'json')
    " change json filetype from javascript for eslint
    au BufNewFile,BufRead *.json set filetype=json
    " disable json quote concealing
    let g:vim_json_syntax_conceal = 0

    " enable eslint
    let g:syntastic_javascript_checkers = ['eslint']
  endif
  " }}}

  " {{{ python
  if count(g:spf13_bundle_groups, 'python')
    if count(g:spf13_bundle_groups, 'programming')
      " enable python pep8
      let g:syntastic_python_checkers = ['python', 'pylint', 'pep8', 'flake8']
    endif
  endif
  " }}}

  " {{{ vim-go
  if count(g:spf13_bundle_groups, 'go')

    map <leader>t <Plug>(go-def-type-tab)
    "let g:go_def_reuse_buffer = 1

    " Set go linters (doesn't seem to work, and megacheck takes a long time
    " anyway, would need to find how to increase deadline timeout)
    let g:go_meta_linter_enabled = ['vet', 'golint', 'errcheck', 'megacheck']

    if count(g:spf13_bundle_groups, 'programming')
      let g:syntastic_go_checkers = ['golangci-lint']
    endif

    " help go_def work with local packages/modules in subdirectories
    "let g:go_def_mode="godef"
  endif
  " }}}

  " Open omnifunc whenever '.' is pressed in go
  "au filetype go inoremap <buffer> . .<C-x><C-o>


  " }}} // customize bundles

  "{{{ Custom functions and mappings

  " {{{ copy/paste mode

  " Shortcut to prepare for paste
  "nnoremap <leader>p :se paste!<CR> "doesn't provide feedback on current mode
  function! PasteToggle()
    if &paste
      setlocal nopaste
      echom "Paste mode disabled"
    else
      setlocal paste
      echom "Paste mode enabled"
    endif
  endfunction
  function! PasteXclip()
    setlocal paste
    r ! xclip -o -sel clipboard
    setlocal nopaste
  endfunction
  function! PasteSystem()
    setlocal paste
    normal! "*p
    setlocal nopaste
  endfunction
  function! PasteGui()
    setlocal paste
    normal! "+p
    setlocal nopaste
  endfunction

  nnoremap <leader>p :call PasteToggle()<CR>
  "add paste shortcuts below to .vimrc, depending on environment
  "nnoremap <c-p> :call PasteXclip()<CR>
  nnoremap <leader>P :call PasteSystem()<CR>

  " Fold columns
  let defaultfdc=2
  "" Set 80 char wrapping for certain file types
  "autocmd BufRead *.php,*.php call SetCodeWrapping()
  "function! SetCodeWrapping()
  "  " Turn on wrapping
  "  set wrap
  "  " Set width to 80
  "  setlocal textwidth=80
  "  " More space for split windows
  "  let defaultfdc=1
  "  execute ":setlocal fdc=".defaultfdc
  "endfunction

  execute ":se fdc=".defaultfdc

  " Shortcut to prepare for copy
  function! CopyToggle()
    if &foldcolumn
      " hide extra columns
      let b:defaultfdc = &fdc
      setlocal nonu
      if (&rnu)
        let b:rnu=1
      endif
      ALEDisable
      SyntasticReset
      setlocal nornu
      setlocal nolist
      setlocal foldcolumn=0
      echom "Copy mode enabled"
    else
      " show extra columns
      if (exists('b:defaultfdc'))
      else
        let b:defaultfdc = defaultfdc
      endif
      if b:rnu
        setlocal rnu
      endif
      ALEEnable
      setlocal nu
      setlocal list
      "setlocal foldcolumn=defaultfdc
      "execute ":setlocal fdc=".defaultfdc
      execute ":se fdc=".b:defaultfdc
      echom "Copy mode disabled"
    endif
  endfunction

  nnoremap <leader>c :call CopyToggle()<CR>

  "}}}

  " {{{ Indenting

  " Indent the = sign on a range of lines
  "map <leader>ec :call IndentRange()<CR>
  map <F1> :call IndentRange()<CR>

  function! GetIndentColumn()
    normal 0f=
    return col(".")
    "let b:EqualColumn = col(".")
  endfunction

  function! ResetIndent()
    s/ \+=/ =/g
    "let b:EqualColumn = col(".")
  endfunction

  function! IndentEqualsTo(column)
    "echom col(".")
    "echom b:EqualColumn
    normal 0f=
    while col(".") < a:column
      exe "normal i l"
    endwhile
  endfunction

  function! IndentRange()
    let l:first_line = line("'<")
    let l:last_line = line("'>")
    let l:current_line = l:first_line
    let l:biggest_indent_line = l:first_line
    let l:biggest_indent = 0
    "go through each line, searching for biggest indent
    while l:current_line <= l:last_line
      exe "normal " . l:current_line . "G"
      call ResetIndent()
      let column = GetIndentColumn()
      if l:column > l:biggest_indent
        let l:biggest_indent = l:column
        let l:biggest_indent_line = l:current_line
      endif
      let l:current_line = l:current_line + 1
    endwhile
    "start over, indenting each line as we go
    let l:current_line = l:first_line
    while l:current_line <= l:last_line
      exe "normal " . l:current_line . "G"
      let l:column = IndentEqualsTo(l:biggest_indent)
      if l:column > l:biggest_indent
        let l:biggest_indent = l:column
        let l:biggest_indent_line = l:current_line
      endif
      let l:current_line = l:current_line + 1
    endwhile
  endfunction
  "}}}

  " {{{ Hex mode

  " ex command for toggling hex mode - define mapping if desired
  command! -bar Hexmode call ToggleHex()

  " helper function to toggle hex mode
  function! ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1
    if !exists("b:editHex") || !b:editHex
      " save old options
      let b:oldft=&ft
      let b:oldbin=&bin
      let b:oldeol=&eol
      " set new options
      setlocal binary " make sure it overrides any textwidth, etc.
      silent :e " this will reload the file without trickeries
      "(DOS line endings will be shown entirely )
      setlocal noeol
      let &ft="xxd"
      " set status
      let b:editHex=1
      " switch to hex editor
      %!xxd -ps
    else
      " restore old options
      let &ft=b:oldft
      let &eol=b:oldeol
      if !b:oldbin
        setlocal nobinary
      endif
      " set status
      let b:editHex=0
      " return to normal editing
      %!xxd -r -ps
    endif
    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
  endfunction
  "}}}

  " {{{ View diff from last save
  if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
  endif

  " Run phpunit on a group
  function! s:PhpUnit(group)
    echom "group=" + a:group
    let g:phpunit_args_append = "--group " . a:group
    exec ":Test"
  endfunction
  "}}}

  " {{{ Edit vimrc files
  " The default mappings for editing and applying the spf13 configuration
  " are <leader>ev and <leader>sv respectively. Change them to your preference
  " by adding the following to your .vimrc.before.local file:
  "   let g:spf13_edit_config_mapping='<leader>ec'
  "   let g:spf13_apply_config_mapping='<leader>sc'
  if !exists('g:spf13_edit_config_mapping')
    let s:spf13_edit_config_mapping = '<leader>ev'
  else
    let s:spf13_edit_config_mapping = g:spf13_edit_config_mapping
  endif
  if !exists('g:spf13_apply_config_mapping')
    let s:spf13_apply_config_mapping = '<leader>sv'
  else
    let s:spf13_apply_config_mapping = g:spf13_apply_config_mapping
  endif

  function! s:ExpandFilenameAndExecute(command, file)
    execute a:command . " " . expand(a:file, ":p")
  endfunction
  function! s:EditSpf13Config()
    call <SID>ExpandFilenameAndExecute("tabedit", "~/.vimrc")
    "call <SID>ExpandFilenameAndExecute("vsplit", "~/.vimrc.before")
    call <SID>ExpandFilenameAndExecute("vsplit", "~/.vimrc.bundles")

    execute bufwinnr(".vimrc") . "wincmd w"
    call <SID>ExpandFilenameAndExecute("split", "~/.vimrc.local")
    wincmd l
    call <SID>ExpandFilenameAndExecute("split", "~/.vimrc.before.local")
    wincmd l
    call <SID>ExpandFilenameAndExecute("split", "~/.vimrc.bundles.local")

    execute bufwinnr(".vimrc.local") . "wincmd w"
  endfunction
  execute "noremap " . s:spf13_edit_config_mapping " :call <SID>EditSpf13Config()<CR>"
  execute "noremap " . s:spf13_apply_config_mapping . " :source ~/.vimrc<CR>"
  " }}}

  " Leader-t runs phpunit on specified group
  "command! -nargs=1 Phpunit call s:PhpUnit(<q-args>)
  "map <leader>t :Phpunit

  "}}}

  "{{{ Folding

  " Set vim filetype to marker folded
  :au Filetype vim exec "se fdm=marker"
  :au Filetype vim exec "se foldmarker={{{,}}}"

  " Autofold document with {,}
  nnoremap <leader>f :call AutoFold()<CR>
  nnoremap <leader>F :call AutoFold2()<CR>

  function! AutoFold()
    set foldmethod=marker
    set foldmarker={,}
    "set foldmethod=manual
  endfunction
  function! AutoFold2()
    "set foldmethod=marker
    "set foldmarker={,}
    set foldmethod=manual
  endfunction

  " Reese's command for custom fold text: first line concat next line
  function! MyFoldText()
    let line = getline(v:foldstart)
    let line2 = getline(v:foldstart + 1)
    let sub = substitute(line . "|" . line2, '/\*\|\*/\|{{{\d\=', '', 'g') "}}} close  fold on this line
    let ind = indent(v:foldstart)
    let lines = v:foldend-v:foldstart + 1
    let i = 0
    let spaces = ''
    while i < (ind - ind/4)
      let spaces .= ' '
      let i = i+1
    endwhile
    "let chars = eval(s/././ng)
    "winwidth('.')
    let offset = 10 + float2nr(log10(lines)) + &foldcolumn + &numberwidth
    let filler = winwidth(0) - strlen(spaces . sub) - offset
    return spaces . sub . repeat('-', filler) . '('. lines . ' lines)'
  endfunction

  "from http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
  function! CustomFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
      let line = getline(v:foldstart)
    else
      let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
  endfunction

  "set foldtext=MyFoldText()
  set foldtext=CustomFoldText()

  "}}}

  "{{{ Appearance

  " Statusline {{{

  set statusline=%f "filename
  set statusline+=%m "modified flag
  set statusline+=%r "read only flag
  set statusline+=\ #%n "buffer number
  set statusline+=%= "right-align the rest
  set statusline+=%l,%v "line/column number
  " Syntastic settings, show errors in statusline
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%{fugitive#statusline()}
  set statusline+=%*
  "}}}

  " Add line numbers
  set nu

  " Allow for cursor beyond last character
  set virtualedit=onemore

  " Buffer closed when switching
  set nohidden
  " Allow buffer switching without saving
  "set hidden

  " show tabs as '| '
  set list
  set listchars=tab:\|\ 

  " show trailing whitespace chars
  set listchars+=trail:¯,nbsp:¯
  " Show symbol if line wraps
  "set listchars+=extends:#

  " Set colorscheme *after* solarized bundle sourced
  set bg=dark

  " Allow to trigger background
  function! ToggleBG()
    let s:tbg = &background
    " Inversion
    if s:tbg == "dark"
      set background=light
    else
      set background=dark
    endif
  endfunction
  noremap <leader>bg :call ToggleBG()<CR>

  colorscheme solarized

  set mouse=a                 " Automatically enable mouse usage
  set mousehide               " Hide the mouse cursor while typing

  if has("gui_running")
    " Mac Font
    "set guifont=Monaco:h10
    " Powerline Font
    set guifont=MesloLGS\ NF\ Regular\ 8
    " Other
    set guifont=SourceCodePro\ 8
    " Menu bar
    set guioptions-=m
    " Toolbar
    set guioptions-=T
    " Remove vertical and horizontal scrollbars
    set guioptions-=L
    set guioptions-=l
    set guioptions-=R
    set guioptions-=r
    set guioptions-=b
    " Switch to text-style tab display
    set guioptions-=e
    " Cursor colors
    highlight Cursor guifg=black guibg=white
    highlight iCursor guifg=white guibg=steelblue
    " Cursorline colors
    hi CursorLine gui=underline
    ":hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
    "setguicursor=n-v-c:block-Cursor
    "setguicursor+=i:ver100-iCursor
    "setguicursor+=n-v-c:blinkon0
    "setguicursor+=i:blinkwait10
  else
    " Cursor colors
    "hi CursorLine gui=underline guibg=gray10
    "ctermfg=white
    "ctermbg=darkred ctermfg=white guibg=darkred guifg=white
    hi CursorLine ctermbg=0 cterm=underline
    if &term =~ "xterm-256color\\|xterm\\|rxvt"
      " Use orange cursor in insert mode
      let &t_SI = "\<Esc>]12;orange\x7"
      " Red cursor
      let &t_EI = "\<Esc>]12;red\007"
      " Reset cursor when vim exits
      autocmd VimLeave * silent !echo -ne "\033]112\007"
    endif
    "highlight whitespace at beginning of line
    "hi PreWhitespace ctermbg=darkgreen guibg=darkgreen
    " Match PreWhitespace /^\ \+/
  endif

  if version >= 703
    " Highlight column 81 and beyond
    "autocmd VimEnter,Colorscheme * :hi ColorColumn ctermbg=0
    "dark bg
    autocmd VimEnter,Colorscheme * :hi ColorColumn ctermbg=0 guibg=#073642 "solarized base02
    "light bg
    "autocmd VimEnter,Colorscheme * :hi ColorColumn ctermbg=0 guibg=#f7f6d2
    "autocmd VimEnter,Colorscheme * :hi! link ColorColumn CursorLine
    "hi ColorColumn ctermbg=0
    hi! link ColorColumn CursorLine
    "let &colorcolumn=join(range(81,999),",")
    let &colorcolumn=81
  endif

  " switch between dark and light themes (or fix missing column colors)
  nmap <leader>l :call Light()<CR>
  nmap <leader>d :call Dark()<CR>

  function! Dark()
      autocmd! VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=0 ctermfg=10 guibg=#012d38
      autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=8 ctermfg=10 guibg=#073642
      autocmd VimEnter,Colorscheme * :hi ColorColumn ctermbg=0 guibg=#073642 "solarized base02
      se bg=dark
  endfunction

  function! Light()
    autocmd! VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=0 ctermfg=10 guibg=#e5e5d7
    "autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=8 ctermfg=10 guibg=#f7f6d2
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=8 ctermfg=10 guibg=#ffffdf
    autocmd VimEnter,Colorscheme * :hi ColorColumn ctermbg=0 guibg=#f7f6d2
    se bg=light
  endfunction

  function! FontSizePlus ()
    let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
    let l:gf_size_whole = l:gf_size_whole + 1
    let l:new_font_size = ' '.l:gf_size_whole
    let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
  endfunction

  function! FontSizeMinus ()
    let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
    let l:gf_size_whole = l:gf_size_whole - 1
    let l:new_font_size = ' '.l:gf_size_whole
    let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
  endfunction

  if has("gui_running")
      nmap <C-_> :call FontSizeMinus()<CR>
      nmap <C-=> :call FontSizePlus()<CR>
  endif

  " Show cursorline on window enter, hide on leave
  " Do this after solarized theme loaded
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline

  " Undo italic gui comments
  highlight Comment cterm=none gui=none

  "highlight FoldColumn guibg=Black guifg=White
  "highlight FoldColumn ctermbg=black ctermfg=white
  :highlight FoldColumn guibg=Black guifg=White
  :highlight FoldColumn ctermbg=black ctermfg=white

  "}}}

  "{{{ Misc

  " Instead of reverting the cursor to the last position in the buffer, we
  " set it to the first line when editing a git commit message
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

  " Custom file type behavior {{{
  autocmd FileType yaml setlocal sw=2 ts=2
  autocmd FileType javascript setlocal sw=2 ts=2
  autocmd FileType vim setlocal sw=2 ts=2 expandtab
  autocmd FileType go setlocal sw=4 ts=4 noexpandtab listchars=trail:¯,nbsp:¯,tab:\ \ 
  autocmd FileType go let b:ale_linters = ['golangci-lint']
  "}}}

  "}}}

  "{{{ Conclusion
  " Save these lines until the end to help with plugin filetype detection
  " Enable filetype based indenting
  if (has("autocmd"))
    filetype plugin indent on
  else
  endif

  " These have to go after the filetype autocommands
  " ALE checker options
  let g:ale_go_go111module="on"
  let g:ale_go_golangci_lint_package=1
  let g:ale_go_golangci_lint_options=""

  let g:ale_sh_shellcheck_exclusions = 'SC2034'
  let g:ale_sh_shellcheck_options="-e SC2034"
  "let g:sonyntastic_sh_shellcheck_args="-e SC2034"

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

  " Enable syntax highlighting. this should go near the end of vimrc
  syntax on
  syntax enable

  "}}}

  " End autocommand group
:augroup END
