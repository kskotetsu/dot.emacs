; -*- coding: utf-8 -*-

(defun my-python-mode ()
  (setq imenu-create-index-function 'python-imenu-create-index)
  (setq indent-tabs-mode nil)
  (setq indent-level 4)
  (setq python-indent 4)
  (setq tab-width 4)
  (setq python-indent-guess-indent-offset nil)
  (flycheck-mode t)
  (jedi:setup)
  (setq jedi:complete-on-dot t)
  (local-set-key (kbd "<f1> j") 'jedi:show-doc)
  (define-key python-mode-map (kbd "C-c C-b") 'python-add-breakpoint)
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

