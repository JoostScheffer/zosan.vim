from .base import Base
from typing import Any
from pathlib import Path
from denite import util, process
import json


class Source(Base):
    def __init__(self, vim: Any) -> None:
        super().__init__(vim)
        self.name = 'zosan-ref'
        self.kind = 'word'

    def on_init(self, context: dict) -> None:
        context['__proc'] = None

    def on_close(self, context: dict) -> None:
        if context['__proc']:
            context['__proc'].kill()
            context['__proc'] = None

    def gather_candidates(self, context: Any) -> list:
        return [
                {'word': '{{title}}', 'abbr': 'title'},
                {'word': '{{title-short}}', 'abbr': 'title-short'},
                {'word': '{{page}}', 'abbr': 'page'},
                {'word': '{{volume}}', 'abbr': 'volume'},
                {'word': '{{#author}}\n\n{{/author}}',
                 'abbr': 'author'},
                {'word': '{{given}}', 'abbr': 'given'},
                {'word': '{{family}}', 'abbr': 'family'},
                {'word': '{{#reference}}\n\n{{/reference}}',
                 'abbr': 'reference'},
                {'word': '{{#issued}}\n\n{{/issued}}',
                 'abbr': 'issued'},
                {'word': '{{year}}', 'abbr': 'year'},
                {'word': '{{month}}', 'abbr': 'month'},
                {'word': '{{day}}', 'abbr': 'day'},
                {'word': '{{container-title}}', 'abbr': 'container-title'},
                {'word': '{{type}}', 'abbr': 'type'},
                {'word': '{{URL}}', 'abbr': 'URL'},
                {'word': '{{ISSN}}', 'abbr': 'ISSN'},
                {'word': '{{note}}', 'abbr': 'note'},
                {'word': '{{DOI}}', 'abbr': 'DOI'},
                {'word': '{{language}}', 'abbr': 'language'},
                {'word': '{{id}}', 'abbr': 'id'},
                {'word': '{{type}}', 'abbr': 'type'},
                {'word': '{{journalAbbreviation}}',
                 'abbr': 'journalAbbreviation'},
                {'word': '{{abstruct}}', 'abbr': 'abstruct'},
                {'word': '{{#date-parts}}\n\n{{/date-parts}}',
                 'abbr': 'date-parts'},
                {'word': '{{source}}', 'abbr': 'source'}
                ]
