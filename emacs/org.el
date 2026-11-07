(defun my/org-mode-setup ()
  
  (variable-pitch-mode 1)
  (visual-line-mode 1)
  
)

(add-hook 'org-mode-hook #'my/org-mode-setup)
