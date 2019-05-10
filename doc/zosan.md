Zosan!  /*:AboutZosan*
==================================================
🐘 Pawooooooo!

Zotero wo Sansho suru!

## What is Zosan?
Zosan is a plugin to use Zotero.
Not for latex or MSword, but for Markdown.
This uses mustache tepmlate engine.
And make reference.

## Install and requirement
It depends on Denite, vim with python3, zotero, pystache
pystache is a package of python.
It can be installed by this command.

```
pip install pystache
```

## Usage

### Export Zotero Data
At first, export Zotero data.
Zotero data should be json.
There is a menu to export json file ;)

And then, put it in the directory your text file exists.

### Editing by Denite
Denite source can be used.

```
:Denite zosan
```

This inserts title-short tag of zotero.
Sometimes, there is a data without title-short.
Such data will be skipped.
Why do'nt you edit Zotero data which lacks section?

The tags are like this.
```
@[Life of Zosan]
```

### Make Reference
Write reference template using Denite.
The command is this!

```
:Denite zosan-ref
```

The usage is same of mustache.
These are blocks.
Some blocks are converted because raw data is not readable.

- title {{title}}
  Title
- title-short {{title-short}}
  Short title
- page {{page}}
  Page of the paper
- volume {{volume}}
  Volume of the paper
- author {{#author}}\n\n{{/author}}',
  + given {{given}}
    Given name of author
  + family {{family}}
    Family name fo author
- reference {{#reference}}\n\n{{/reference}}',
  Make reference block.
  All the reference must be inside the block.
- year {{year}}
- month {{month}}
- day {{day}}
  Day of publish of each reference.
- issued {{#issued}}\n\n{{/issued}}',
  The date paper published.
  But it is not useful... so, it is good to use
  year, month, day block.
- container-title {{container-title}}
  Title of magazine or book.
- type {{type}}
  May be magazine or book.
- URL {{URL}}
  URL
- ISSN {{ISSN}}
  ISSN
- note {{note}}
  note in Zotero.
- DOI {{DOI}}
  DOI
- language {{language}}
  language of paper
- id {{id}}
  ID of Zotero. It's form is URL.
- source {{source}}
  May be web site of the paper.


### Output the formatted text file
After you edit the template of the paper,
run Zosan command!

```
:WriteZosan out.md
```

And then, there is a text file, named "out.md".

### Options
If you want to change zotero json filename,
you can change this variable.

```
let g:zotero_filename = 'My Library.json'
```

### Todo
This plugin is under development.
Big change can be done.

I want to add functions to...

- Sort by title name.
