(load "~/.emacs.d/lsp.el")

(defun my/java-lsp-setup ()
  "Lazy-load and configure LSP only when a Java buffer is opened."
  (my/lsp-mode-setup)
  (require 'lsp-java)


  (setq gc-cons-threshold (* 256 1024 1024)
        read-process-output-max (* 4 1024 1024))


  (setq lsp-java-vmargs '("-XX:+UseParallelGC"
                          "-XX:GCTimeRatio=4"
                          "-XX:AdaptiveSizePolicyWeight=90"
                          "-Dsun.zip.disableMemoryMapping=true"
                          "-Xmx4G")
        lsp-enable-indentation nil
        lsp-java-completion-max-results 50
        lsp-java-progress-reports :disabled
        lsp-java-autobuild-enabled nil
        lsp-java-java-path "java"
        lsp-java-server-install-dir (expand-file-name "jdtls/" user-emacs-directory))

  (lsp-deferred))

(add-hook 'java-mode-hook #'my/java-lsp-setup)
(add-hook 'java-ts-mode-hook #'my/java-lsp-setup)
