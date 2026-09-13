(defun my/lsp-mode-setup ()
  (require 'lsp-mode)

  (setq lsp-completion-provider :capf)
  (setq lsp-completion-enable-snippet t)
  (setq lsp-completion-show-detail t)
  (setq lsp-completion-show-kind t)
  (setq lsp-idle-delay 0.15)

  (setq lsp-java-progress-reports-enabled nil)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-modeline-diagnostics-enable nil)
  (setq lsp-modeline-code-actions-enable nil)
  (setq lsp-modeline-workspace-status-enable nil)

  )

