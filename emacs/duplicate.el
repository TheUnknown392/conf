(defun my/duplicate-line ()
  "Duplicate the current line or selected region below."
  (interactive)
  (if (use-region-p)
      (let* ((start (region-beginning))
             (end (region-end))
             (text (buffer-substring-no-properties start end)))
        (goto-char end)
        (insert "\n" text))
    (let ((column (current-column))
          (line (buffer-substring-no-properties
                 (line-beginning-position)
                 (line-end-position))))
      (end-of-line)
      (insert "\n" line)
      (move-to-column column))))

(global-set-key (kbd "C-,") #'my/duplicate-line)
