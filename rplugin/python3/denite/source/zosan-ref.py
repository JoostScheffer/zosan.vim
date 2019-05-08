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
        return [{'word': '{{title-short}}'},
                {'word': '{{source}}'},
                {'word': '{{given}}'},
                {'word': '{{family}}'},
                {'word': '{{title}}'},
                {'word': '{{container-title}}'},
                {'word': '{{page}}'},
                {'word': '{{volume}}'},
                {'word': '{{type}}'},
                {'word': '{{URL}}'},
                {'word': '{{#reference}}\n\n{{/reference}}'}]
