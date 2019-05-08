scriptencoding utf-8
" VimNoteBook
" Last Change:	2019 May 09
" Maintainer:	Ninja <sheepwing@kyudai.jp>
" License:	Mit licence

if !exists('g:loaded_zosan')
    finish
endif
let g:loaded_zosan = 1


let s:save_cpo = &cpo
set cpo&vim



function! zosan#write_zosan (fname)
python3 << zosan
import pystache
from typing import Dict, Any
import json
import vim

class Zosan:
    def __init__(self, data_set: str) -> None:
        with open(data_set) as fp:
            data = json.load(fp)
        data = list(filter(lambda x: 'title-short' in x,
                           data))
        self.data_set = {'data_set': data}
        self.text: str

    def set_text(self, text_fname: str) -> None:
        with open(text_fname) as text_fp:
            self.text = text_fp.read()

    def make_tag(self, tag_name: str) -> str:
        return '@[' + tag_name.split('/')[-1] + ']'

    def make_data_for_zotero(self) -> str:
        reference: dict = {'reference': []}
        for r in self.data_set['data_set']:
            tag = self.make_tag(r['title-short'])
            if tag in self.text:
                r['_loc'] = self.text.find(tag)
                reference['reference'].append(r)

        reference['reference'] = sorted(reference['reference'],
                                        key=lambda x: x['_loc'])
        line = 1
        for r in reference['reference']:
            r['loc'] = line
            line += 1
        result: str = pystache.render(self.text, reference)
        for r in reference['reference']:
            tag = self.make_tag(r['title-short'])
            result = result.replace(tag, '[' + str(r['loc']) + ']')
        return result


st = Zosan(vim.eval('g:zotero_filename'))
st.set_text(vim.current.buffer.name)
with open(vim.eval('a:fname'), 'w') as fp:
  fp.write(st.make_data_for_zotero())
zosan
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
