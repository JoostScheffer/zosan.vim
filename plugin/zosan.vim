scriptencoding utf-8
" Zosan.vim
" Last Change:	2019 Mar 11
" Maintainer:	Ninja <sheepwing@kyudai.jp>
" License:	Mit licence

if exists('g:loaded_zosan')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

let g:loaded_zosan = 1
let g:zotero_useid = 1

" Default file name of jsonfile from Zotero.
let g:zotero_filename = 'My Library.json'
command! -nargs=1 ZosanWrite call zosan#write_zosan(<f-args>)
command! ZosanAbstract call zosan#read()

let &cpo = s:save_cpo
unlet s:save_cpo
