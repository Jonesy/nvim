nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
" nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
" set timeoutlen=100

" Coc Search & refactor
nnoremap <leader>? :CocSearch <C-R>=expand("<cword>")<CR><CR>
let g:which_key_map['?'] = 'search word'

let g:which_key_use_floating_win = 0

" Single mappings
let g:which_key_map['/'] = [ ':call Comment()', 'comment' ]

let g:which_key_map['g'] = {
  \ 'name': '+git',
  \ 's': [ ':Gstatus', 'Git Status' ],
  \ 'p': [ ':Git push -u origin HEAD', 'Git push origin' ],
  \ 'P': [ ':Gpull', 'Git pull current branch' ],
  \ 'f': [ ':Gfetch origin', 'Git fetch origin' ],
  \ 'x': [ ':Gread! show HEAD:%', 'Git undo uncommit changes' ],
  \ 'b': [ ':Merginal', 'List Branches' ]
  \ }

" Register which key map
call which_key#register('<Space>', "g:which_key_map")
