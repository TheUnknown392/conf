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

;; Theme
;; (load-theme 'gruber-darker t)
(load-theme 'flatland t)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(require 'magit)
(setq indent-guide-global-mode 1)

;; C# style
(add-hook 'csharp-mode-hook
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

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8288bfda564c129eb993ce6333f859410679e8c4b4f3a0ec221fd8c91d04ca41" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
