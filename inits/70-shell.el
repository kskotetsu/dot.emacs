(defun cygwin-shell ()
  "Run cygwin bash in shell mode."
  (interactive)
  (let ((explicit-shell-file-name "d:/cygwin64/bin/bash"))
    (call-interactively 'shell)))
