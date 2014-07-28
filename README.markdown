[![Build Status](https://secure.travis-ci.org/rolandwalker/unicode-enbox.png?branch=master)](http://travis-ci.org/rolandwalker/unicode-enbox)

# Overview

Surround a string with box-drawing characters in Emacs.

## Quickstart

```elisp
(require 'unicode-enbox)
 
(insert "\n" (unicode-enbox "testing"))
```

## Explanation

Unicode-enbox.el has no user-level interface; it is only useful
for programming in Emacs Lisp.

This library provides two functions:

	unicode-enbox
	unicode-enbox-debox

which can be used to add/remove box-drawing characters around
a single- or multi-line string.

## See Also

<kbd>M-x</kbd> <kbd>customize-group</kbd> <kbd>RET</kbd> <kbd>unicode-enbox</kbd> <kbd>RET</kbd>

## Notes

For good monospaced box-drawing characters, it is recommended to
install the free DejaVu Sans Mono font and use unicode-fonts.el.
If unicode-fonts.el is too heavy for your needs, try adding the
following bit to your ~/.emacs file:

```elisp
(set-fontset-font "fontset-default"
                  (cons (decode-char 'ucs #x2500)  (decode-char 'ucs #x257F))
                  '("DejaVu Sans Mono" . "iso10646-1"))
```

## Compatibility and Requirements

	GNU Emacs version 24.4-devel     : yes, at the time of writing
	GNU Emacs version 24.3           : yes
	GNU Emacs version 23.3           : yes
	GNU Emacs version 22.3 and lower : no

Requires [string-utils.el](http://github.com/rolandwalker/string-utils), [ucs-utils.el](http://github.com/rolandwalker/ucs-utils)

Uses if present: [unicode-fonts.el](http://github.com/rolandwalker/unicode-fonts)
