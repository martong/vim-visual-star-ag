" From http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html

let s:visual_star_search_ag_search_buf = ""

" makes * and # work on visual mode too.
function! s:VSetSearchAg()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
  let g:visual_star_search_ag_search_buf = '\Q' . substitute(escape(@s, '\'), '\n', '\\n', 'g') . '\E'
  let @s = temp
endfunction

function! FindCommand(arg)
  let @/ = a:arg
  execute 'LAg! --cpp "'.a:arg.'"'
endfunction

"map <Leader>s :let @/="<C-R><C-W>" \| LAg! --cpp "\b<C-R><C-W>\b"<cr>
map <Leader>s :call FindCommand("<C-R><C-W>")<CR>
command! -nargs=1 F call FindCommand(<q-args>)

vmap <leader>s :<C-u>call <SID>VSetSearchAg()<CR>:execute 'noautocmd LAg! --cpp "' . g:visual_star_search_ag_search_buf . '"'<CR>

