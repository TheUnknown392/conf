(condition-case err
    (global-activity-watch-mode)
  (error (message "Could not load global-activity-watch-mode: %s" err)))
