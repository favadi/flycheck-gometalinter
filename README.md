[![MELPA Stable](http://stable.melpa.org/packages/flycheck-gometalinter-badge.svg)](http://stable.melpa.org/#/flycheck-gometalinter)[![MELPA](https://melpa.org/packages/flycheck-gometalinter-badge.svg)](https://melpa.org/#/flycheck-gometalinter)
# Flycheck checker for golang using [gometalinter](https://github.com/alecthomas/gometalinter)

This package provides [flycheck][flycheck-ref] checker for golang.

## Installation

Install [gometalinter](https://github.com/alecthomas/gometalinter) and install all available checkers with:

```
gometalinter --install --update
```

### Manually Installation
Copy `flycheck-gometalinter.el` file to `load-path` and add to `init.el`.

```elisp
(require 'flycheck-gometalinter)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-gometalinter-setup))
```

### Install with Melpa

This package is available in
[Melpa](https://melpa.org/#/flycheck-gometalinter) and
[Melpa Stable](http://stable.melpa.org/#/flycheck-gometalinter), can
be installed with `package-install` command.

For `use-package` user:

```elisp
(use-package flycheck-gometalinter
  :ensure t
  :config
  (progn
    (flycheck-gometalinter-setup)))
```

## Configuration

```elisp
;; skips 'vendor' directories and sets GO15VENDOREXPERIMENT=1
(setq flycheck-gometalinter-vendor t)
;; only run fast linters
(setq flycheck-gometalinter-fast t)
;; use in tests files
(setq flycheck-gometalinter-test t)
;; disable linters
(setq flycheck-gometalinter-disable-linters '("gotype" "gocyclo"))
;; Only enable selected linters
(setq flycheck-gometalinter-disable-all t)
(setq flycheck-gometalinter-enable-linters '("golint"))
;; Set different deadline (default: 5s)
(setq flycheck-gometalinter-deadline "10s")
```

[flycheck-ref]: http://www.flycheck.org                 "Flycheck"
