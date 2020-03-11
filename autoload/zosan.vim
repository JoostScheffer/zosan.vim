scriptencoding utf-8
" Zosan.vim
" Last Change:	2019 May 11
" Maintainer:	Ninja <sheepwing@kyudai.jp>
" License:	Mit licence

if !exists('g:loaded_zosan')
    finish
endif
let g:loaded_zosan = 1


let s:save_cpo = &cpo
set cpo&vim


function! zosan#read ()
  let zosan_end = match(getline('.'), ']', virtcol('.')) - 2
  let zosan_start = virtcol('.') + 1
  let zosan_token = strpart(getline('.'), zosan_start, zosan_end)
  echo zosan_token.':'
  echo zosan#reader(zosan_token)
endfunction

function! zosan#reader (token)
python3 << zosan_reader
import json
import vim


class Zosan:
    def __init__(self, data_set: str) -> None:
        with open(data_set) as fp:
            data = json.load(fp)
        self.use_id = True if vim.eval('g:zotero_useid') == '1' else False
        self.data = list(filter(lambda x: 'title' in x, data))

    def read(self, token):
        if self.use_id:
            for data in self.data:
                if token in data['id']:
                    print(data['title'])
                    print('--------------------')
                    print(data['abstract'])
        else:
            for data in self.data:
                if token == data['title']:
                    print(data['title'])
                    print('--------------------')
                    print(data['abstract'])


Zosan(vim.eval('g:zotero_filename')).read(vim.eval('a:token'))
zosan_reader
endfunction


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
        # I want to use title as tag.
        # Because, it is long but may be readable.
        data = list(filter(lambda x: 'title' in x, data))
        # let issue day out of issued section.
        # Almost all of casese, another section 'accessed' is
        # useless when writing paper.
        self.use_id = True if vim.eval('g:zotero_useid') == '1' else False
        for d in data:
            if 'issued' in d:
                try:
                    if len(d['issued']['date-parts'][0]) == 3:
                        d.update({'year': d['issued']['date-parts'][0][0],
                                  'month': d['issued']['date-parts'][0][1],
                                  'day': d['issued']['date-parts'][0][2]})
                    if len(d['issued']['date-parts'][0]) == 2:
                        d.update({'year': d['issued']['date-parts'][0][0]})
                    if len(d['issued']['date-parts'][0]) == 1:
                        d.update({'year': d['issued']['date-parts'][0][0]})
                except:
                    pass
        self.data = data
        self.text: str

    def set_text(self, text_fname: str) -> None:
        '''
        Set template text.
        '''
        with open(text_fname) as text_fp:
            self.text = text_fp.read()

    def make_tag(self, tag_name: str) -> str:
        return '@[' + tag_name.split('/')[-1] + ']'

    def make_data_for_zotero(self) -> str:
        '''
        Let json usable from mustashe engine.
        '''
        reference: dict = {'reference': []}
        for data in self.data:
            if self.use_id:
                tag = self.make_tag(data['id'])
            else:
                tag = self.make_tag(data['title'])
            if tag in self.text:
                data['_loc'] = self.text.find(tag)
                reference['reference'].append(data)

        reference['reference'] = sorted(reference['reference'],
                                        key=lambda x: x['_loc'])
        line = 1
        for ref in reference['reference']:
            ref['loc'] = line
            line += 1
        result: str = pystache.render(self.text, reference)
        for ref in reference['reference']:
            tag = self.make_tag(ref['title'])
            result = result.replace(tag, '[' + str(ref['loc']) + ']')
        return result


st = Zosan(vim.eval('g:zotero_filename'))
st.set_text(vim.current.buffer.name)
with open(vim.eval('a:fname'), 'w') as fp:
    fp.write(st.make_data_for_zotero())
zosan
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
