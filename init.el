;; My init.el file
;; ver. 0.3

;; setup package management
(require 'package)
(setq package-archives
      `(,@package-archives
        ("melpa" . "https://melpa.org/packages/")
        ;; ("marmalade" . "https://marmalade-repo.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ;; ("user42" . "https://download.tuxfamily.org/user42/elpa/packages/")
        ;; ("emacswiki" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/emacswiki/")
        ;; ("sunrise" . "http://joseito.republika.pl/sunrise-commander/")
        ))
(package-initialize)

;; installing and configuring use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(put 'use-package 'lisp-indent-function 1)

(use-package use-package-core
  :custom
  ;; (use-package-verbose t)
  ;; (use-package-minimum-reported-time 0.005)
  (use-package-enable-imenu-support t))


(use-package quelpa
  :ensure t
  :defer t
  :custom
  (quelpa-update-melpa-p nil "Don't update the MELPA git repo."))

(use-package quelpa-use-package
  :init
  (setq quelpa-use-package-inhibit-loading-quelpa t)
  :ensure t)

;; eshell
(use-package em-smart
  :defer t
  :config
  (eshell-smart-initialize)
  :custom
  (eshell-where-to-jump 'begin)
  (eshell-review-quick-commands nil)
  (eshell-smart-space-goes-to-end t))

(use-package esh-help
  :ensure t
  :defer t
  :config
  (setup-esh-help-eldoc))

(use-package esh-autosuggest
  :ensure t
  :hook (eshell-mode . esh-autosuggest-mode))


(use-package eshell-prompt-extras
  :ensure t
  :after (eshell esh-opt)
  :custom
  (eshell-prompt-function #'epe-theme-dakrone))

(use-package eshell-toggle
  :ensure t
  :after projectile
  :custom
  (eshell-toggle-use-projectile-root t)
  (eshell-toggle-run-command nil)
  :bind
  ("M-`" . eshell-toggle))

;; (use-package eshell-fringe-status
;;   :ensure t
;;   :hook
;;   (eshell-mode . eshell-fringe-status-mode))

;; some highlighting
(use-package paren
  :config
  (show-paren-mode t))

(use-package hl-line
  :hook
  (prog-mode . hl-line-mode))

(use-package highlight-numbers
  :ensure t
  :hook
  (prog-mode . highlight-numbers-mode))

(use-package highlight-escape-sequences
  :ensure t
  :config (hes-mode))

(use-package hl-todo
  :ensure t
  :custom-face
  (hl-todo ((t (:inherit hl-todo :italic t))))
  :hook ((prog-mode . hl-todo-mode)
         (yaml-mode . hl-todo-mode)))

(use-package page-break-lines
  :ensure t
  :hook
  (help-mode . page-break-lines-mode)
  (prog-mode . page-break-lines-mode)
  (special-mode . page-break-lines-mode)
  (compilation-mode . page-break-lines-mode))

(use-package rainbow-delimiters
  :ensure t
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-identifiers
  :ensure t
  :custom
  (rainbow-identifiers-cie-l*a*b*-lightness 80)
  (rainbow-identifiers-cie-l*a*b*-saturation 50)
  (rainbow-identifiers-choose-face-function
   #'rainbow-identifiers-cie-l*a*b*-choose-face)
  :hook
  (emacs-lisp-mode . rainbow-identifiers-mode) ; actually, turn it off
  (prog-mode . rainbow-identifiers-mode))

(use-package rainbow-mode
  :ensure t
  :hook '(prog-mode help-mode))

;; autocomplete
(use-package company
  :ensure t
  :bind
  (:map company-active-map
        ("C-n" . company-select-next-or-abort)
        ("C-p" . company-select-previous-or-abort))
  :hook
  (after-init . global-company-mode))

(use-package company-quickhelp
  :ensure t
  :defer t
  :custom
  (company-quickhelp-delay 3)
  (company-quickhelp-mode 1))

(use-package company-shell
  :ensure t
  :after company
  :defer t)

;; elisp
(use-package lisp
  :hook
  (after-save . check-parens))

(use-package elisp-mode
  :bind
  (:map emacs-lisp-mode-map
        ("C-c C-d C-d" . describe-function)
        ("C-c C-d d" . describe-function)
        ("C-c C-k" . eval-buffer)))

(use-package highlight-defined
  :ensure t
  :custom
  (highlight-defined-face-use-itself t)
  :hook
  (help-mode . highlight-defined-mode)
  (emacs-lisp-mode . highlight-defined-mode))

(use-package highlight-quoted
  :ensure t
  :hook
  (emacs-lisp-mode . highlight-quoted-mode))

(use-package highlight-sexp
  :quelpa
  (highlight-sexp :repo "daimrod/highlight-sexp" :fetcher github :version original)
  :hook
  (clojure-mode . highlight-sexp-mode)
  (emacs-lisp-mode . highlight-sexp-mode)
  (lisp-mode . highlight-sexp-mode))

(use-package eros
  :ensure t
  :hook
  (emacs-lisp-mode . eros-mode))

(use-package suggest
  :ensure t
  :defer t)

(use-package ipretty
  :defer t
  :ensure t
  :config
  (ipretty-mode 1))

(use-package nameless
  :ensure t
  :hook
  (emacs-lisp-mode .  nameless-mode)
  :custom
  (nameless-global-aliases '())
  (nameless-private-prefix t))

;; let's try evil mode
(use-package evil
  :ensure t)

;; (load-theme 'manoj-dark t)

(use-package lor-theme
  :config
  (load-theme 'lor t)
  :quelpa
  (lor-theme :repo "a13/lor-theme" :fetcher github :version original))

(use-package paradox
  :ensure t
  :defer 1
  :config
  (paradox-enable))

;; Markup mode

(use-package markdown-mode
  :ensure t
  :ensure-system-package markdown
  :mode (("\\`README\\.md\\'" . gfm-mode)
         ("\\.md\\'"          . markdown-mode)
         ("\\.markdown\\'"    . markdown-mode))
  :custom
  (markdown-command "markdown"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(lor-theme paradox evil nameless ipretty suggest eros highlight-sexp highlight-quoted highlight-defined rainbow-mode rainbow-identifiers rainbow-delimiters quelpa-use-package page-break-lines hl-todo highlight-numbers highlight-escape-sequences eshell-toggle eshell-prompt-extras esh-help esh-autosuggest company-shell company-quickhelp)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-todo ((t (:inherit hl-todo :italic t)))))
