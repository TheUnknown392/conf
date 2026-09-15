;; Package setup
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-face-attribute 'default nil :height 200)
(global-display-line-numbers-mode 1) 

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(condition-case err
    (load-theme 'gruber-darker t)
  (error (message "Could not load gruber-darker theme: %s" err)))

;; Ensure packages are installed. Each install is wrapped so one
;; failing/missing package does NOT stop the rest of init.el from loading.
(condition-case err
    (unless package-archive-contents
      (package-refresh-contents))
  (error (message "package-refresh-contents failed: %s" err)))

(dolist (pkg '(compat
               cond-let
               llama
               transient
               with-editor
               magit
               company
               elfeed
               multiple-cursors
               ace-jump-mode
               move-text
               indent-guide
               gruber-darker-theme))
  (condition-case err
      (unless (package-installed-p pkg)
        (package-install pkg))
    (error (message "Failed to install %s: %s" pkg err))))

;; Subword
(global-subword-mode 1)

;; Backups
(setq backup-directory-alist '(("." . "~/.emacs_backups")))
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs_saves/" t)))

;; ido setup for auto completion
(require 'ido)
(ido-mode 1)

;; Electric Pair
(electric-pair-mode 1)

;; Magit
(condition-case err
    (require 'magit)
  (error (message "Could not load magit: %s" err)))

;; elfeed
(condition-case err
    (require 'elfeed)
  (error (message "Could not load elfeed: %s" err)))

;; Indent guide (fixed: call as function, not setq)
(condition-case err
    (progn
      (require 'indent-guide)
      (indent-guide-global-mode 1))
  (error (message "Could not load indent-guide: %s" err)))

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

;; Move text (fixed: require added so keybindings actually work)
(condition-case err
    (progn
      (require 'move-text)
      (global-set-key (kbd "M-p") 'move-text-up)
      (global-set-key (kbd "M-n") 'move-text-down))
  (error (message "Could not load move-text: %s" err)))

;; Company
(condition-case err
    (progn
      (require 'company)
      (global-company-mode)
      (setq company-idle-delay 0.1)
      (setq company-show-quick-access t)
      (setq company-cancel-on-page-break t)
      (setq company-backends
            '(company-capf
              company-files
              company-dabbrev-code
              company-dabbrev))
      (setq company-minimum-prefix-length 2)
      (setq company-dabbrev-other-buffers t)
      (setq company-dabbrev-code-other-buffers t)
      (global-set-key (kbd "C-.") #'company-complete))
  (error (message "Could not load company: %s" err)))

;; multiple-cursors
(condition-case err
    (progn
      (require 'multiple-cursors)
      (global-set-key (kbd "C-<") 'mc/mark-next-like-this)
      (global-set-key (kbd "C->") 'mc/mark-previous-like-this)
      (global-set-key (kbd "C-c C-a") 'mc/mark-all-like-this)
      (global-set-key (kbd "C-c C-f") 'mc/mark-next-like-this)
      (global-set-key (kbd "C-c C-b") 'mc/mark-previous-like-this))
  (error (message "Could not load multiple-cursors: %s" err)))

;; jumping between words and lines
(condition-case err
    (progn
      (require 'ace-jump-mode)
      (global-set-key (kbd "C-c C-c") 'ace-jump-char-mode) ; jumps to character
      (global-set-key (kbd "C-c C-l") 'ace-jump-line-mode) ; jumps to line
      (global-set-key (kbd "C-c C-w") 'ace-jump-word-mode)) ; jumps to word
  (error (message "Could not load ace-jump-mode: %s" err)))

;; spaces everywhere
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil) ;; use spaces instead of tabs

;; HTML mode 2 spaces
(add-hook 'html-mode-hook
          (lambda ()
            (setq tab-width 2)
            (setq sgml-basic-offset 2)))

;; XML mode 2 spaces
(add-hook 'nxml-mode-hook
          (lambda ()
            (setq tab-width 2)
            (setq nxml-child-indent 2)))

;; Move focus left and right
(global-set-key (kbd "C-c p") #'windmove-left)
(global-set-key (kbd "C-c n") #'windmove-right)

;; Kill Focused pane
(global-set-key (kbd "C-c k") #'delete-window)

;; Change delete behaviour
(load-file "~/.emacs.d/delete.el")

;; Import elfeed data from this file
(load-file "~/.emacs.d/feeds.el")   ; just sets elfeed-feeds
(global-set-key (kbd "C-c r") #'elfeed)

(load "~/.emacs.d/java.el")
