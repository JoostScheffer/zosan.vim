scriptencoding utf-8
" VimNoteBook
" Last Change:	2019 Apr 24
" Maintainer:	Ninja <sheepwing@kyudai.jp>
" License:	Mit licence

if exists('g:loaded_zosan')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

let g:loaded_zosan = 1


let g:zotero_filename = 'My Library.json'
command! -nargs=1 WriteZosan call zosan#write_zosan(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo
