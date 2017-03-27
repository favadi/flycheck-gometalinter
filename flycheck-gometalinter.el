;;; flycheck-gometalinter.el --- flycheck checker for gometalinter

;; Copyright (c) 2015, Diep Pham
;; All rights reserved.

;; Author: Diep Pham <me@favadi.com>
;; Keywords: convenience, tools, go
;; Version: 0.1.0
;; URL: https://github.com/favadi/flycheck-gometalinter
;; Package-Requires: ((emacs "24") (flycheck "0.22"))

;; This file is not part of GNU Emacs.

;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions
;; are met:

;; * Redistributions of source code must retain the above copyright
;;   notice, this list of conditions and the following disclaimer.

;; * Redistributions in binary form must reproduce the above copyright
;;   notice, this list of conditions and the following disclaimer in
;;   the documentation and/or other materials provided with the
;;   distribution.

;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
;; FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
;; COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
;; INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
;; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
;; SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
;; STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
;; OF THE POSSIBILITY OF SUCH DAMAGE.

;;; Commentary:
;; Flycheck checker for gometalinter

;;; Code:

(require 'flycheck)

(flycheck-def-option-var flycheck-gometalinter-concurrency nil gometalinter
  "Number of concurrent linters to run."
  :safe #'integerp
  :type 'integer)

(flycheck-def-option-var flycheck-gometalinter-vendor nil gometalinter
  "Skips 'vendor' directories and sets GO15VENDOREXPERIMENT=1."
  :safe #'booleanp
  :type 'boolean)

(flycheck-def-option-var flycheck-gometalinter-errors-only nil gometalinter
  "Only show errors."
  :safe #'booleanp
  :type 'boolean)

(flycheck-def-option-var flycheck-gometalinter-fast nil gometalinter
  "Only run fast linters."
  :safe #'booleanp
  :type 'boolean)

(flycheck-def-option-var flycheck-gometalinter-tests nil gometalinter
  "Include test files for linters that support this option."
  :safe #'booleanp
  :type 'boolean)

(flycheck-def-option-var flycheck-gometalinter-disable-all nil gometalinter
  "Disable all linters, ony enable those defined in
flycheck-gometalinter-enable-linters."
  :safe #'booleanp
  :type 'boolean)

(flycheck-def-option-var flycheck-gometalinter-disable-linters
    nil gometalinter
  "List of linters to disable."
  :type '(repeat (string :tag "linter"))
  :safe #'flycheck-string-list-p)

(flycheck-def-option-var flycheck-gometalinter-enable-linters
    nil gometalinter
  "List of linters to enable, use with flycheck-gometalinter-disable-all."
  :type '(repeat (string :tag "linter"))
  :safe #'flycheck-string-list-p)

(flycheck-def-option-var flycheck-gometalinter-deadline "5s" gometalinter
  "Cancel linters if they have not completed within this
  duration."
  :safe #'stringp)

(flycheck-def-option-var flycheck-gometalinter-concurrency "16" gometalinter
  "Number of linters to run concurrently."
  :safe #'stringp)

(flycheck-def-option-var flycheck-gometalinter-sort "none" gometalinter
  "Sort output by any of none, path, line, column, severity, message, linter."
  :safe #'stringp)

(flycheck-define-checker gometalinter
  "A all-in-one Go linter.
See URL: `https://github.com/alecthomas/gometalinter'"
  :command ("gometalinter"
            (option "--concurrency=" flycheck-gometalinter-concurrency concat flycheck-option-int)
            (option-flag "--vendor" flycheck-gometalinter-vendor)
            (option-flag "--errors" flycheck-gometalinter-errors-only)
            (option-flag "--disable-all" flycheck-gometalinter-disable-all)
            (option-flag "--fast" flycheck-gometalinter-fast)
            (option-flag "--tests" flycheck-gometalinter-tests)
            (option "--concurrency=" flycheck-gometalinter-concurrency concat)
            (option "--deadline=" flycheck-gometalinter-deadline concat)
            (option "--sort=" flycheck-gometalinter-sort concat)
            (option-list "--disable=" flycheck-gometalinter-disable-linters concat)
            (option-list "--enable=" flycheck-gometalinter-enable-linters concat)
            "--checkstyle"
            ".")
   :error-parser flycheck-parse-checkstyle
   :error-filter flycheck-dequalify-error-ids
   :modes go-mode)


;;;###autoload
(defun flycheck-gometalinter-setup ()
  "Setup Flycheck gometalinter.
Add `gometalinter' to `flycheck-checkers'."
  (interactive)
  (add-to-list 'flycheck-checkers 'gometalinter))

(provide 'flycheck-gometalinter)

;;; flycheck-gometalinter.el ends here
