;;My init.el file
;; ver. 0.3

;;setup package management
(require 'package)
(setq package-archives
      `(,@package-archives
        ("melpa" . "https://melpa.org/packages/")
;;        ("marmalade" . "https://marmalade-repo.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
;;        ("user42" . "https://download.tuxfamily.org/user42/elpa/packages/")
        ("emacswiki" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/emacswiki/")
;;        ("sunrise" . "http://joseito.republika.pl/sunrise-commander/")
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
  (use-package-verbose t)
  (use-package-minimum-reported-time 0.005)
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
  (emacs-lisp-mode . rainbow-identifiers-mode) actually, turn it off
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
;; (use-package evil
;;  :ensure t)

(load-theme 'manoj-dark t)

(use-package display-line-numbers
  :bind ("<f6> l" . display-line-numbers-mode))

;; Modernise package menu

;; (use-package paradox
;;   :ensure t
;;   :defer 1
;;   :config
;;   (paradox-enable))


;; Let's optimise a little bit

(use-package gcmh
  :ensure t
  :init
  (gcmh-mode 1))

;; disable suspend on C-z
(use-package frame
  :bind
  ("C-z" . nil)
  :custom
  (initial-frame-alist '((vertical-scroll-bars))))

;; C-c C-g always quits minibuffer
(use-package delsel
  :bind
  (:map mode-specific-map
        ("C-g" . minibuffer-keyboard-quit)))

;; dired

;; make dired faster
(use-package async
  :ensure t
  :defer t
  :custom
  (dired-async-mode 1))

;; localization
(use-package mule
  :defer 0.1
  :config
  (prefer-coding-system 'utf-8)
  (set-language-environment "UTF-8")
  (set-terminal-coding-system 'utf-8))

;; fancy gui

(load-theme 'manoj-dark)

(use-package olivetti
  :ensure t
  :custom
  (olivetti-body-width 95))

(use-package font-lock+
  :defer t
  :quelpa
  (font-lock+ :repo "emacsmirror/font-lock-plus" :fetcher github))

(use-package all-the-icons
  :ensure t
  :defer t
  :config
  (setq all-the-icons-mode-icon-alist
        `(,@all-the-icons-mode-icon-alist
          (package-menu-mode all-the-icons-octicon "package" :v-adjust 0.0)
          (jabber-chat-mode all-the-icons-material "chat" :v-adjust 0.0)
          (jabber-roster-mode all-the-icons-material "contacts" :v-adjust 0.0)
          (telega-chat-mode all-the-icons-fileicon "telegram" :v-adjust 0.0
                            :face all-the-icons-blue-alt)
          (telega-root-mode all-the-icons-material "contacts" :v-adjust 0.0))))

(use-package all-the-icons-dired
  :ensure t
  :hook
  (dired-mode . all-the-icons-dired-mode))

(use-package winner
  :config
  (winner-mode 1))

(use-package mwheel
  :custom
  (mouse-wheel-scroll-amount '(1
                               ((shift) . 5)
                               ((control))))
  (mouse-wheel-progressive-speed nil))

(use-package pixel-scroll
  :config
  (pixel-scroll-mode))

(use-package tooltip
  :defer t
  :custom
  (tooltip-mode -1))

;; (use-package time
;;   :defer t
;;   :custom
;;   (display-time-default-load-average nil)
;;   (display-time-24hr-format t)
;;   (display-time-mode t))

;; (use-package fancy-battery
;;   :ensure t
;;   :hook
;;   (after-init . fancy-battery-mode))




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(fancy-battery mood-line lor-theme paradox evil nameless ipretty suggest eros highlight-sexp highlight-quoted highlight-defined rainbow-mode rainbow-identifiers rainbow-delimiters quelpa-use-package page-break-lines hl-todo highlight-numbers highlight-escape-sequences eshell-toggle eshell-prompt-extras esh-help esh-autosuggest company-shell company-quickhelp)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-todo ((t (:inherit hl-todo :italic t))))
 '(mode-line ((t (:inherit default (:box (:line-width -1 :style released-button)))))))
