# Flycheck checker for golang using [gometalinter](https://github.com/alecthomas/gometalinter)

This package provides [flycheck][flycheck-ref] checker for golang.

## Installation

Install [gometalinter](https://github.com/alecthomas/gometalinter) and install all available checkers with:

```
gometalinter --install --update
```

Copy `flycheck-gometalinter.el` file to `load-path` and add to `init.el`.

```
(require 'flycheck-gometalinter)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-gometalinter-setup))
```

[flycheck-ref]: http://www.flycheck.org                 "Flycheck"
