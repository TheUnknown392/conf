;; uses csharp-ls from global. dotnet tools ... something csharp-ls
(load "~/.emacs.d/lsp.el")

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))

(with-eval-after-load 'lsp-mode
  (setq lsp-completion-provider :capf
        lsp-enable-indentation nil))

(defun my/csharp-lsp-setup ()
  (my/lsp-mode-setup)
  (require 'lsp-csharp)
  (lsp-deferred))

(add-hook 'csharp-mode-hook #'my/csharp-lsp-setup)
(add-hook 'csharp-ts-mode-hook #'my/csharp-lsp-setup)
