"=============================================================================
" FILE: plugin/stardict.vim
" AUTHOR: Phong V. Cao <phongvcao@phongvcao.com>
" License: MIT license {{{
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be included
" in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
" OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
" IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
" CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
" TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
" SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================


if exists('g:loaded_stardict')
    finish
endif

if !exists('g:stardict_split_size')
    let g:stardict_split_size = ''
endif

if !exists('g:stardict_split_horizontal')
    let g:stardict_split_horizontal = 1
endif

if !exists('g:stardict_data_dir')
    let g:stardict_data_dir = 'dict'
endif

function! <SID>StartDictSelect()
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    call stardict#StarDict("--data-dir", g:stardict_data_dir, "--utf8-output", l:pattern)
    let @" = l:saved_reg
endfunction

" Map :StarDict command to stardict#StarDict() function
command! -nargs=* StarDict call stardict#StarDict("--data-dir", g:stardict_data_dir, "--utf8-output", <f-args>)
command! -nargs=* StarDictCursor call stardict#StarDict("--data-dir", g:stardict_data_dir, "--utf8-output", expand('<cword>'))
command! -range=% -nargs=* StarDictSelect call <SID>StartDictSelect()

nmap <silent><leader>sd :StarDictCursor<CR>
vmap <silent><leader>sd :StarDictSelect<CR>
