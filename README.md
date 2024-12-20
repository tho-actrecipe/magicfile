# actrecipemagicfile (A CFFI fork of python-magic)
[![PyPI version](https://badge.fury.io/py/actrecipemagicfile.svg)](https://badge.fury.io/py/actrecipemagicfile)

`actrecipemagicfile` is a Python interface to the libmagic file type identification library. libmagic identifies file types by checking their headers against a predefined list. This functionality is accessible from the command line using the Unix command `file`.

Changelog

[2024-12-04]

    New: Added support for Mac Silicon (Python 3.10, 3.11).
    New: Added support for Linux ARM (Python 3.10, 3.11, 3.12).

## Usage

```python
>>> import magicfile as magic
>>> magic.from_file("testdata/test.pdf")
'PDF document, version 1.2'
>>> magic.from_buffer(open("testdata/test.pdf").read(1024))
'PDF document, version 1.2'
>>> magic.from_file("testdata/test.pdf", mime=True)
'application/pdf'
```

There is also a `Magic` class that provides more direct control,
including overriding the magic database file and turning on character
encoding detection.  This is not recommended for general use.  In
particular, it's not safe for sharing across multiple threads and
will fail throw if this is attempted.

```python
>>> f = magic.Magic(uncompress=True)
>>> f.from_file('testdata/test.gz')
'ASCII text (gzip compressed data, was "test", last modified: Sat Jun 28
21:32:52 2008, from Unix)'
```

You can also combine the flag options:

```python
>>> f = magic.Magic(mime=True, uncompress=True)
>>> f.from_file('testdata/test.gz')
'text/plain'
```

## License

`actrecipemagicfile` is distributed under the MIT license.  See the included
LICENSE file for details.

Notes:

- This package is primarily used in an internal project.
- Support for Mac Silicon and Linux ARM is effective from 2024-12-04.