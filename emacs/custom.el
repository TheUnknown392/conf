(unless (file-exists-p custom-file-name)
  (write-region (region-beginning) (region-end) custom-file-name))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(thanks vertico orderless multiple-cursors move-text magit lsp-javacomp lsp-java indent-guide gruber-darker-theme elfeed-web company auctex activity-watch-mode ace-jump-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
