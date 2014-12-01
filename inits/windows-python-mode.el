; -*- coding: utf-8 -*-

(defun my-python-mode ()
  (my-python-mode-common)
  (setq
   python-shell-interpreter "C:\\Python34\\python.exe"
   python-shell-interpreter-args
   "-i C:\\Python34\\Scripts\\ipython-script.py")
										; windowsではipythonのプロンプトが出なくて無限待ちになる
  (setq
   python-shell-interpreter "ipython"
   python-shell-interpreter-args ""
   python-shell-prompt-regexp "In \\[[0-9]+\\]: "
   python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
   python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
   python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
   python-shell-completion-string-code
    "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"
   )
  )


;; for windows
(eval-after-load "jedi"
    '(setq jedi:server-command (list "/Python34/python" jedi:server-script)))

