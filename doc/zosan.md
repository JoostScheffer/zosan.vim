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
Why dont you edit in Zotero?

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
