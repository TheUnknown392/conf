;; Package setup
(require 'package)
(setq package-archives
'(("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Font Size
(set-face-attribute 'default nil :height 200)

;; Line numbers
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; Subword
(global-subword-mode 1)

;; Backups
(setq backup-directory-alist '(("." . "~/.emacs_backups")))
(setq auto-save-file-name-transforms
`((".*" "~/.emacs_saves/" t)))

;; ido setup for auto completion
(require 'ido)
(ido-mode 1)

;; Theme
(load-theme 'gruber-darker t)
;;(load-theme 'flatland t)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; Electric Pair
(electric-pair-mode 1)

(require 'magit)
(setq indent-guide-global-mode 1)

;; C# style
(add-hook 'csharp-mode-hook
(lambda ()
(c-set-style "k&r")
(setq c-basic-offset 4)
(setq indent-tabs-mode nil)))

;; c style
(add-hook 'c-mode-common-hook
(lambda ()
(c-set-style "k&r")
(setq c-basic-offset 4)
(setq indent-tabs-mode nil)))

;; Move text
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;; Company
(require 'company)
(global-company-mode)

(setq company-idle-delay nil)
(setq company-show-quick-access t)

(setq company-backends
'((company-dabbrev-code
company-dabbrev
company-files)
company-capf))

(setq company-dabbrev-other-buffers nil)
(setq company-dabbrev-ignore-case t)
(setq company-dabbrev-downcase nil)

(setq company-minimum-prefix-length 1)

(global-set-key (kbd "C-.") #'company-complete)

;; Removing top bars and scroll bar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; multiple-cursores
(require 'multiple-cursors)

(global-set-key (kbd "C-<") 'mc/mark-next-like-this)
(global-set-key (kbd "C->") 'mc/mark-previous-like-this)

(global-set-key (kbd "C-c C-a") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c f") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c b") 'mc/mark-previous-like-this)

;; jumping between words and lines
(require 'ace-jump-mode)
(global-set-key (kbd "C-c C-c") 'ace-jump-char-mode) ; jumps to character
(global-set-key (kbd "C-c C-l") 'ace-jump-line-mode) ; jumps to line
(global-set-key (kbd "C-c C-w") 'ace-jump-word-mode) ; jumps to word


;; spaces everywhere
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil) ;; use spaces instead of tabs

;; HTML mode  2 spaces
(add-hook 'html-mode-hook
(lambda ()
(setq tab-width 2)
(setq sgml-basic-offset 2)))

;; XML mode 2 spaces
(add-hook 'nxml-mode-hook
(lambda ()
(setq tab-width 2)
(setq nxml-child-indent 2)))
