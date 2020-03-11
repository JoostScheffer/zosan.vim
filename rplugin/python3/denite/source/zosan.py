from .base import Base
from typing import Any
from pathlib import Path
from denite import util, process
from os.path import exists
import json


class Source(Base):

    def __init__(self, vim: Any) -> None:
        super().__init__(vim)
        self.name = 'zosan'
        self.kind = 'word'
        self.library_name = vim.eval('g:zotero_filename')
        self.use_id = True if vim.eval('g:zotero_useid') == 1 else False

    def on_init(self, context: dict) -> None:
        context['__proc'] = None

    def on_close(self, context: dict) -> None:
        if context['__proc']:
            context['__proc'].kill()
            context['__proc'] = None

    def gather_candidates(self, context: Any) -> list:
        try:
            with open(self.library_name) as fp:
                data_set = json.load(fp)
            data_set = list(filter(lambda x: 'title' in x, data_set))
            if self.use_id:
                self.data = [{'abbr': x['title'],
                              'word': '@[' + x['id'].split('/')[-1] + ']'}
                             for x in data_set]
            else:
                self.data = [{'abbr': x['title'],
                              'word': '@[' + x['title'] + ']'}
                             for x in data_set]
            return self.data
        except FileNotFoundError:
            return [{'word': '', 'abbr': 'There is no Zotero JSON file.'},
                    {'word': '', 'abbr': 'Please export JSON file from zotero,'},
                    {'word': '', 'abbr': 'and put it in this directory.'},
                    {'word': '', 'abbr': 'The name of file should be "'
                     + self.library_name + '"'}]
        except:
            return [{'word': '', 'abbr': 'Something went wrong.'}]
